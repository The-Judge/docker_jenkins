#!/bin/bash
# Warte bis die JB erreichbar ist

# Laden der Funktionen
source /helper/functions.sh

# Laden der Konstanten
load_const

# Maximale Wartezeit, die die JB hochfahren darf in Sekunden
WAIT=300

function state {
    if [ $? -ne 0 ]; then
        echo "Build-Umgebung konnte nicht sauber gestartet werden."
        return 1
    else
        echo "Build-Umgebung wurde gestartet."
        return 0
    fi
}

wait_for_status ${WAIT} RUNNING
state || exit 1
wait_for_running ${WAIT} true
state || exit 1
