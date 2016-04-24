FROM debian:jessie

MAINTAINER Gabriel Rezzonico <gabrielrezzonico@gmail.com>

ENV DEBIAN_FRONTEND noninteractive 
ENV DOCKER_USER docker-user
ENV DOCKER_SHARED_GROUP docker-shared
ENV DOCKER_SHARED_GROUP_ID 7777

#
# DO NOT install recommended and suggested packages by default
# http://askubuntu.com/questions/179060/how-not-to-install-recommended-and-suggested-packages

RUN echo "APT::Install-Recommends \"false\";" >> /etc/apt/apt.conf.d/01norecommends \
    && echo "APT::Install-Suggests \"false\";" >> /etc/apt/apt.conf.d/01norecommends;

#
# Install extra packages
#

RUN apt-get update && apt-get install -y \
    ca-certificates \
    nano \
    wget \
 && rm -rf /var/lib/apt/lists/*
 
#
# Remove /bin/su
#

RUN rm -f /bin/su

#
#  Create a user and a group, to be shared between host and guest
#

RUN addgroup -gid ${DOCKER_SHARED_GROUP_ID} ${DOCKER_SHARED_GROUP} \
    && adduser --disabled-password --gecos "" ${DOCKER_USER} \
    && adduser ${DOCKER_USER} ${DOCKER_SHARED_GROUP}

USER ${DOCKER_USER}

WORKDIR /home/${DOCKER_USER}/

RUN echo 'umask g+w' >> ~/.bashrc

ENTRYPOINT ["/bin/bash","-l"]