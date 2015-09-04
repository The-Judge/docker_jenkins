#!/bin/bash -x
# Erzeugen der Build-Umgebung

# Laden der Funktionen
source /helper/functions.sh

# Laden der Konstanten
load_const

# Erzeugen der Build-Umgebung
result="$(curl -s -S -d name=${BUILD_ID} -d planid=20 -d distribution=debian_jessie_64bit -d use_sshkey ${base_url})"

# Fehlerbehandlung im Fehlerfall
if [ -z "echo ${result} | egrep ',"status":"CREATING"'" ]; then
    echo "Konnte nicht sauber starten. Der Rückgabewert war:"
    echo "${result}"
    echo ""
    sleep 10
    kill_box
    exit 1
fi
