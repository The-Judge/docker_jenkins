#!/bin/bash -x
# Delete JB

# Load constants
CONSTANTS_FILE="/helper/constants"
if [ -e "${CONSTANTS_FILE}" ]; then
    source "${CONSTANTS_FILE}"
else
    echo ""${CONSTANTS_FILE}" not found."
    exit 1
fi

# Delete JB
curl -X DELETE ${base_url}/$(python /helper/jb_trans_name_to_id.py ${token} ${BUILD_ID})
