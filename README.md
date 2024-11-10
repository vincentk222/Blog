# Installation
## Wifi

```sh
curl -sSL -o wifi.sh https://raw.githubusercontent.com/vincentk222/Blog/main/script/wifi.sh
chmod +x wifi.sh
sudo ./wifi.sh
```

<details wifi.sh>
<summary>wifi.sh</summary>

Pour voir le contenu du script, cliquez [ici](https://raw.githubusercontent.com/vincentk222/Blog/main/script/wifi.sh).

```bash
    {% include_relative script/wifi.sh %}
```

</details>

## Remote access for Docker daemon

 
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










