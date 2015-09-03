#!/bin/bash -x
# Delete JB

# Load constants
# TODO: Hier muss noch ein geeigneter Ablageort für constants und die Helper-Scripte bestimmt werden
CONSTANTS_FILE="/helper/constants"
if [ -e "${CONSTANTS_FILE}" ]; then
    source "${CONSTANTS_FILE}"
else
    echo ""${CONSTANTS_FILE}" not found."
    exit 1
fi

# Delete JB
result="$(curl -X DELETE ${base_url}/$(python /helpers/py_jb_trans_name_to_id.py))"
echo "${result}"
