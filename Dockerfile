FROM debian:jessie
# Inspired by aespinosa/jenkins by Allan Espinosa "allan.espinosa@outlook.com"
MAINTAINER Marc Richter <mail@marc-richter.info>

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get --no-install-recommends install -q -y openjdk-7-jre-headless && \
    apt-get install -q -y git && \
    rm -rf /var/lib/apt/lists/*
ADD http://mirrors.jenkins-ci.org/war/1.626/jenkins.war /opt/jenkins.war
ADD init.sh /init
RUN chmod +x /init
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

EXPOSE 8080
CMD ["/init"]