# Docker remote access for Docker daemon
## remote access for Docker daemon

```sh
sudo systemctl edit docker.service
```

Add  the following lines

    [Service]
    ExecStart=
    ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375

```sh
sudo systemctl daemon-reload
sudo systemctl restart docker.service
```

```sh
sudo apt install net-tools
sudo netstat -lntp | grep dockerd
```
