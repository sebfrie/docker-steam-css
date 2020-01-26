# Docker Image for Counter-Strike Source Server

This docker image provides a preconfigured Counter-Strike Source server with several plugins.

The Docker image in the Docker Hub can be found [here](https://hub.docker.com/r/ddyess/css-server). It is a fork of the Docker Image by foxylion, found [here](https://hub.docker.com/r/foxylion/steam-css/).

### Why a Fork?

foxylion's docker image runs very well, but I needed a customized one. I also have some plugin preferences. Finally, I want to, eventually, include a stats and admin web frontend.

## Builds and Tags

I am currently using 2 tags:
- latest
- dev

### Latest

The ``latest`` tag is the stable build that I am running on my server. This image is built from the ``master`` branch on GitHub.

### Dev

The ``dev`` tag is a version I am working on, but have not yet decided it is good enough to merge into ``master``. This image is built from the ``dev`` branch on GitHub

## Plugins and Maps

List of Added Plugins:
- [metamod:source v1.10.7-971](http://www.metamodsource.net/)
- [SourceMod v1.10.0-6460](http://www.sourcemod.net/downloads.php?branch=stable)
  - With MapChooser, RockTheVote, and Nominations enabled
- [RankMe v2.8.3](https://forums.alliedmods.net/showthread.php?p=1456869)
- Damage Report

List of Unofficial Maps:
- aim_deagle7k
- awp_leet
- awp_paradise
- de_cpl mill
- de_cpl strike
- de_out_rats
- de_westwood_2010
- fy_iceworld2k18
- scoutzknives
  - Low Gravity On/Off Menu options now available in admin menu

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

## Simplify Administration

Create a folder in the server's root folder such as ``/games/css`` and use that to customize server settings without working with the Docker container repeatedly. 

The file overrides below can at most allow you to restart the container, rather than having to change anything in the container. 

Note: The end goal is to allow almost total customization from outside the container without all of the individual overrides or requiring the entire ``cstrike`` folder to be outside of the container.

### Custom motd_default.txt

```
-v /path/to/motd_default.txt:/home/steam/css/cstrike/cfg/motd_default.txt
```

Note: There is an ``extra`` folder that contains a copy of the default motd_default.txt.

### Custom mapcycle.txt

```
-v /path/to/mapcycle.txt:/home/steam/css/cstrike/cfg/mapcycle.txt
```

Note: The mapcycle.txt file included as default does not contain all official maps or the unofficial ones.

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
