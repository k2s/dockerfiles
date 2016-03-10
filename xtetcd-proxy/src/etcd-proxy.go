package main

import (
	"io"
	"net/http"
	"strconv"
	"fmt"
	"strings"
	"errors"
	"flag"
)

//Handle http requests
type ConnectionInfo struct {
	LocalPort    int
	EtcdPort     int
	EtcdHost     string
	AllowedPaths []string
}

func (ci *ConnectionInfo) proxyHandlerWrapper(respWriter http.ResponseWriter, req *http.Request) {
	err := ci.proxyHandler(respWriter, req)
	if err != nil {
		println(err.Error())
		http.Error(respWriter, "Bad Gateway: " + err.Error(), 502)
	}
}

func (ci *ConnectionInfo) isSafePath(urlPath string) bool {
	for _, element := range ci.AllowedPaths {
		// element is the element from someSlice for where we are
		if (strings.HasPrefix(urlPath, element)) {
			return true
		}
	}
	return false
}

func (ci *ConnectionInfo) proxyHandler(respWriter http.ResponseWriter, req *http.Request) error {
	// security check
	if !ci.isSafePath(req.URL.Path) {
		return errors.New("not allowed request: " + req.URL.Path)
	}

	// prepare the request
	req.Host = fmt.Sprintf("%s:%v", ci.EtcdHost, ci.EtcdPort)
	req.URL.Host = req.Host
	req.URL.Scheme = "http" // has to be set
	req.RequestURI = "" //go requires that this be empty
	req.RemoteAddr = "" //go likes filling this one in itself

	// send the request
	transport := http.Transport{} //Had to use a transport instead of http.Client so that Location header requests would come through instead of being followed
	resp, err := transport.RoundTrip(req)
	if err != nil {
		return err
	}

	copyHeaders(respWriter.Header(), resp.Header)
	respWriter.WriteHeader(resp.StatusCode)
	io.Copy(respWriter, resp.Body)

	// close response from etcd
	defer resp.Body.Close()

	return nil
}

func copyHeaders(dst, src http.Header) {
	for k, _ := range dst {
		dst.Del(k)
	}
	for k, vs := range src {
		for _, v := range vs {
			dst.Add(k, v)
		}
	}
}

func etcd(w http.ResponseWriter, r *http.Request) {
	// curl -L http://127.0.0.1:8000/v2/keys/xtqueue/container1
	// curl -L -X PUT http://127.0.0.1:8000/v2/keys/xtqueue/container1 -d value="localhost:1111"
	// security check
	url := r.URL.Path

	// get data from etcd
	resp, err := http.Get(url)
	if err != nil {
		// handle error
		http.Error(w, err.Error(), 500)
		return
	}

	// return data
	copyHeaders(w.Header(), resp.Header)
	w.WriteHeader(resp.StatusCode)
	io.Copy(w, resp.Body)

	// close response from etcd
	defer resp.Body.Close()
}

func main() {
	println("xtetcd-proxy started")

	arguments := &ConnectionInfo{}

	var allowedPathsStr string
	flag.IntVar(&arguments.LocalPort, "LocalPort", 3279, "(Optional) The local port you connect to to forward a request")
	flag.StringVar(&arguments.EtcdHost, "EtcdHost", "127.0.0.1", "(Optional) The domain host that requests are forwarded to")
	flag.IntVar(&arguments.EtcdPort, "EtcdPort", 2379, "(Optional) The port for the remote domain")
	flag.StringVar(&allowedPathsStr, "AllowedPaths", "-", "(Required) Comma separated allowed start paths eg. ”/v2/keys/xtqueue/” for requests. Other requests will be refused.")
	flag.Parse()

	if allowedPathsStr == "-" {
		println("Error: AllowedPaths is required")
		println("\nDefaults:")
		flag.PrintDefaults()
		println("")
		return
	}
	// TODO make sure it starts with /v2/keys and ends with /
	arguments.AllowedPaths = strings.Split(allowedPathsStr, ",")

	http.HandleFunc("/", arguments.proxyHandlerWrapper)
	http.ListenAndServe(":" + strconv.Itoa(arguments.LocalPort), nil)
}

