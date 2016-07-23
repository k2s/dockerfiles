#bigm/letsencrypt

Generate your HTTPS certificates with [letsencrypt.sh](https://github.com/lukas2511/letsencrypt.sh).
 
* Supports HTTP and DNS challenges.
* Includes dnsmadeeasy.com [hook](https://github.com/alisade/letsencrypt-DNSMadeEasy-hook)

## With DNS challenge

```bash
# create file ~/.letsencrypt/domains.txt, see https://github.com/lukas2511/letsencrypt.sh/blob/master/docs/domains_txt.md

# this example uses dnsmadeeasy hook
# you have to obtain own API key from https://www.dnsmadeeasy.com/
DME_API_KEY=<your API key>
DME_SECRET_KEY=<your secret key>

# let's generate
docker run --rm -ti \
    -e DME_API_KEY="$DME_API_KEY" -e DME_SECRET_KEY="$DME_SECRET_KEY" \
    -e ID_USER=`id -u` -e ID_GROUP=`id -g` \
    -v ~/.letsencrypt:/opt/letsencrypt.sh/certs \
    -e DOMAINS_TXT=/opt/letsencrypt.sh/certs/domains.txt \
    bigm/letsencrypt \
    /opt/letsencrypt.sh/letsencrypt.sh -c -t dns-01 -k 'hooks/dnsmadeeasy/hook.py'
```

## With HTTP challenge

Same as above, but simplify the command to: `/opt/letsencrypt.sh/letsencrypt.sh -c`