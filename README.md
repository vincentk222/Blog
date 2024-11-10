# Installation
## Wifi

```sh
curl -sSL -o wifi.sh https://raw.githubusercontent.com/vincentk222/Blog/main/script/wifi.sh
chmod +x wifi.sh
sudo ./wifi.sh
```
Pour voir le contenu du script, cliquez [ici](https://raw.githubusercontent.com/vincentk222/Blog/main/script/wifi.sh).

```bash
    {% include_relative script/wifi.sh %}
```

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






Oui, il est possible de placer un bloc incluable dans un bloc réductible (expandable) si vous utilisez un générateur de site statique comme Jekyll, qui prend en charge les inclusions de fichiers. Voici comment vous pourriez structurer votre Markdown :

### Exemple avec un bloc réductible

```markdown
# Installation

## Wifi

```bash
curl -sSL -o wifi.sh https://raw.githubusercontent.com/vincentk222/Blog/main/script/wifi.sh
chmod +x wifi.sh
sudo ./wifi.sh
```

<details>
<summary>wifi.sh</summary>

Pour voir le contenu du script, cliquez [ici](https://raw.githubusercontent.com/vincentk222/Blog/main/script/wifi.sh).


{% include_relative script/wifi.sh %}


</details>
```

### Remarques :
- Dans cet exemple, la première partie `<summary>wifi.sh</summary>` vous permet de déplier le contenu lorsque l'utilisateur clique dessus.
- Le contenu inclus par `{% include_relative script/wifi.sh %}` sera affiché lorsque le bloc sera déplié.
- Assurez-vous que votre blog ou votre site est configuré pour traiter les inclusions Jekyll. Les inclusions ne fonctionneront pas si vous n’êtes pas sur un environnement qui traite les commandes Jekyll.

### Limitations :
- Le bloc de code sera rendu seulement si le générateur de site est en mesure d'appliquer cette logique au moment de la compilation. Dans un fichier Markdown standard (sans moteur de génération), cela ne fonctionnera pas.
- Si vous ouvrez le fichier Markdown directement dans un visualiseur Markdown qui ne supporte pas ces directives, vous ne verrez pas le contenu inclus.






