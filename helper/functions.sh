#!/bin/bash -x

# Laden der Konstanten-Datei
function load_const {
    CONSTANTS_FILE="/helper/constants"
    if [ -e "${CONSTANTS_FILE}" ]; then
        source "${CONSTANTS_FILE}"
    else
        echo ""${CONSTANTS_FILE}" nicht gefunden."
        exit 1
    fi
    unset CONSTANTS_FILE
}

# Auslesen der ID eines Namens
function get_id {
    ID="$(python /helper/jb_trans_name_to_id.py ${token} ${BUILD_ID})"
    echo ${ID}
}

# Status der Build-Umgebung auslesen und zurückgeben
# get_state FELD
# FELD kann entweder "status" oder "running" sein
function get_state {
    ID=$(get_id)
    STATE="$(python /helper/jb_get_status.py ${token} $(get_id) $1)"
    echo ${STATE}
}

# Wartet eine gewisse Zeit ($1) ob bis dahin ein Status ($2) eintritt
# und gibt einen Status von 0 oder 1 zurück
function wait_for_status {
    load_const
    WAIT=$1
    STATUS=$2
    while [ ${WAIT} -gt 0 ]; do
    if [ "$(get_state status)" == "${STATUS}" ]; then
        break
    fi
    sleep 1
    ((WAIT--))
    if [ ${WAIT} -gt 0 ]; then
        return 0
    else
        return 1
    fi
done
}

# Löschen der Build-Umgebung
function kill_box {
    load_const
    ID=$(get_id)
    # Forciertes herunterfahren der Build-Umgebung
    curl -s -S -X PUT -d status=PULLPLUG ${base_url}/${ID}
    while [ ${WAIT} -ge 0 ]; do
        if [ "$(get_state status)" == "READY" ]; then
            break
        fi
        sleep 1
        ((WAIT--))
    done
    # Löschen der Build-Umgebung
    curl -s -S -X DELETE ${base_url}/${ID}
    unset ID
}