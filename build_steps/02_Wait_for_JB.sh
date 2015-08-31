#!/bin/bash
# Parameter
# Maximale Wartezeit, die die JB hochfahren darf in Sekunden
WAIT=300

# Load constants
if [ -e /helper/constants ]; then
    . /helper/constants
fi

# Bringe die ID der JB in Erfahrung
JBID="$(python /helper/py_jb_translate_name_to_id.py ${token} ${BUILD_ID})"

# Lese den status aus
