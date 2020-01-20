# Docker Image for Counter-Strike Source Server

This docker image provides a preconfigured Counter-Strike Source server with several plugins.

The Docker image in the Docker Hub can be found [here](https://hub.docker.com/r/ddyess/css-server). It is a fork of the Docker Image by foxylion, found [here](https://hub.docker.com/r/foxylion/steam-css/).

### Why a Fork?

foxylion's docker image runs very well, but I needed a customized one. I also have some plugin preferences. Finally, I want to, eventually, include a stats and admin web frontend.

List of used plugins:
- [metamod:source v1.10.7-971](http://www.metamodsource.net/)
- [SourceMod v1.10.0-6460](http://www.sourcemod.net/downloads.php?branch=stable)
- [MapChooser Extended 1.10.2](https://forums.alliedmods.net/showthread.php?t=156974)
- [RankMe v2.8.3](https://forums.alliedmods.net/showthread.php?p=1456869)

## Start the container

The docker container requires some ports to be exposed, therefore a more advanced run command is required.

```
docker run -d --name css-server \
           -p 27015:27015 -p 27015:27015/udp -p 1200:1200 \
           -p 27005:27005/udp -p 27020:27020/udp -p 26901:26901/udp \
           -e RCON_PASSWORD=mypassword \
           ddyess/css-server
```

## Available Environment Variables

- ``RCON_PASSWORD`` is your personal RCON password to authenticate as the administrator
- ``CSS_HOSTNAME`` is your custom server name shown in the server list
- ``CSS_PASSWORD`` is the password a user may require to connect, can be left empty

To use spaces in a variable value, wrap it in singles quotes, with the value in quotes:

``-e 'CSS_HOSTNAME="Moody Crew"'``

## Expose you maps and sounds as a htdocs directory

You can mount a directory where the css server should copy all currently installed maps and sounds so you can use the `sv_downloadurl` option.

```
- v /path/to/target:/home/steam/htdocs
```

## Other files to override

### Custom mapcycle.txt

```
-v /path/to/mapcycle.txt:/home/steam/css/cstrike/cfg/mapcycle.txt
```

### SourceMod admins_simple.ini

To control the SourceMod admins on the server you can use your own admins.cfg or admins_simple.ini file.

```
-v /path/to/admins_simple.ini:/home/steam/css/cstrike/addons/sourcemod/configs/admins_simple.ini
```

### Modified server.cfg

The default server.cfg can also be overriden, but you can also only override some specific settings, therefore use the following pattern
```
-v /path/to/my-server.cfg:/home/steam/css/cstrike/cfg/my-server.cfg
```

### Other configuration files

Any other configuration file can also be overriden using the same method as above, you must just locate the right file in the docker container. The folder structure is the same as when you install the server locally.
