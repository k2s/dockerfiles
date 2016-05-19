# proxy-cache

Runs squid3 and apt-cacher-ng servers in one container.

## Example systemd service file

Create `.config/systemd/user/proxy-cache.service` or add as system wide service file

    [Unit]
    Description=proxy-cache container

    [Service]
    TimeoutStartSec=0
    Restart=always
    #ExecStartPre=/usr/bin/docker pull quay.io/bigm/proxy-cache
    ExecStartPre=-/usr/bin/docker rm -f proxy-cache
    ExecStart=/usr/bin/docker run --rm --name=proxy-cache -v /var/cache/apt:/var/cache/apt-cacher-ng -v /var/cache/squid3:/var/spool/squid3 -p 3142:3142 -p 3128:3128 bigm/proxy-cache
    ExecStop=-/usr/bin/docker rm -f proxy-cache

    [Install]
    WantedBy=default.target


Enable/start the service

    systemctl --user enable proxy-cache
    systemctl --user start proxy-cache