FROM jenkins/jenkins:lts-jdk11
MAINTAINER   Nash Gadre <allnash@live.com>
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false


COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < usr/share/jenkins/plugins.txt

USER root

RUN apt-get update && \
    apt-get -y install apt-transport-https \
     curl \
     make \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

RUN apt-get update
RUN apt-get -y install docker-ce

RUN usermod -aG docker jenkins
RUN apt-get clean

USER jenkins
