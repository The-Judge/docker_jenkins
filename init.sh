#!/bin/bash
# If /user/init is available, run this before running jenkins actually
if [ -x /user/init ]; then
    /user/init
fi

# Start jenkins
java -jar /opt/jenkins.war
