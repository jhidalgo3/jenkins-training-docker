FROM jenkins:2.5
MAINTAINER "Jose Maria Hidalgo Garcia" <jhidalgo3@gmail.com>

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG gid_docker=600

USER root

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
            sudo \
            ansible \
      && groupadd -g ${gid_docker} docker \
      && curl -sSL https://get.docker.com/ | sh \
      && echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers \
      && usermod -aG docker ${user} \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* \
      && rm -rf /tmp/*

USER ${user}

ADD JENKINS_HOME /usr/share/jenkins/ref
