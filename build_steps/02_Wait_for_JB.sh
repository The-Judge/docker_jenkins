#!/bin/bash
# Warte bis die JB erreichbar ist

# Load constants
CONSTANTS_FILE="/helper/constants"
if [ -e "${CONSTANTS_FILE}" ]; then
    source "${CONSTANTS_FILE}"
else
    echo ""${CONSTANTS_FILE}" not found."
    exit 1
fi

# Maximale Wartezeit, die die JB hochfahren darf in Sekunden
WAIT=300

# Bringe die ID der JB in Erfahrung
JBID="$(python /helper/jb_translate_name_to_id.py ${token} ${BUILD_ID})"

# Lese den status aus
#TODO: TBC