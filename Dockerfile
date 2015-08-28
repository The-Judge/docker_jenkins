FROM debian:jessie
# Inspired by aespinosa/jenkins by Allan Espinosa "allan.espinosa@outlook.com"
MAINTAINER Marc Richter "mail@marc-richter.info"

ENV DEBIAN_FRONTEND noninteractive
ENV JENKINS_VERSION 1.626

# Add jessie-backports
RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list

# Install updates and basics
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get --no-install-recommends install -q -y openjdk-7-jre-headless && \
    apt-get install -q -y git

# Install Docker
RUN apt-get install -y docker.io

# Cleanup APT
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war /opt/jenkins.war
ADD init.sh /init
RUN chmod +x /init
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

VOLUME ["/jenkins"]

EXPOSE 8080
EXPOSE 5000
CMD ["/init"]
