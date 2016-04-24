# gabrielrezzonico/docker-debian

Dockerfile to build a debian:jessie baseimage with few extras.

## Docker security

/bin/su is removed from the docker, all the software that goes in top of this image can run without root permissions


## Docker size

apt-get "Install-Recommends" and "Install-Suggests" are setted to FALSE

@see http://askubuntu.com/questions/179060/how-not-to-install-recommended-and-suggested-packages

## User and group

A user named "docker-user" and a group named "docker-shared" (gid=7777) are created. umask is setted to "g+w".


## Extra packages

The following packages are installed:

> * ca-certificates
> * nano
> * wget
