#!/bin/bash
# Warte bis die JB erreichbar ist

# Laden der Funktionen
source /helper/functions.sh

# Laden der Konstanten
load_const

# Maximale Wartezeit, die die JB hochfahren darf in Sekunden
WAIT=300

wait_for_status ${WAIT} RUNNING
wait_for_running ${WAIT} true

if [ $? -ne 0 ]; then
    echo "Build-Umgebung konnte nicht sauber gestartet werden."
    exit 1
else
    echo "Build-Umgebung wurde gestartet."
fi
