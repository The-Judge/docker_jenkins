#!/bin/bash
# Load constants
if [ -e $(dirname $(readlink -f $0))/constants ]; then
    . $(dirname $(readlink -f $0))/constants
fi

# Create JB
result="$(curl -d name=${BUILD_ID} -d planid=20 -d distribution=debian_jessie_64bit -d use_sshkey ${base_url})"
echo ${base_url}
if [ ! -z "echo ${result} | egrep ',"status":"CREATING"'" ]; then
    echo "Couldn't be started properly."
    exit 1
fi
