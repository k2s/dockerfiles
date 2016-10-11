#bigm/letsencrypt

Generate your HTTPS certificates with [dehydrated](https://github.com/lukas2511/dehydrated).
 
* Supports HTTP and DNS challenges.
* Includes dnsmadeeasy.com [hook](https://github.com/alisade/letsencrypt-DNSMadeEasy-hook)

## With DNS challenge

```bash
# create file ~/.letsencrypt/domains.txt, see https://github.com/lukas2511/dehydrated/blob/master/docs/domains_txt.md

# this example uses dnsmadeeasy hook
# you have to obtain own API key from https://www.dnsmadeeasy.com/
DME_API_KEY=<your API key>
DME_SECRET_KEY=<your secret key>

# let's generate
docker run --rm -ti \
    -e DME_API_KEY="$DME_API_KEY" -e DME_SECRET_KEY="$DME_SECRET_KEY" \
    -e ID_USER=`id -u` -e ID_GROUP=`id -g` \
    -v ~/.letsencrypt:/opt/dehydrated/certs \
    -e DOMAINS_TXT=/opt/dehydrated/certs/domains.txt \
    bigm/letsencrypt \
    zsh

cp $DOMAINS_TXT /opt/dehydrated/ 
/opt/dehydrated/dehydrated -c -t dns-01 -k 'hooks/dnsmadeeasy/hook.py'
exit
```

## With HTTP challenge

Same as above, but simplify the command to: `/opt/dehydrated/dehydrated -c`