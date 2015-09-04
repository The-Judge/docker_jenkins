#!/bin/bash -x
# Create JB

# Load constants
CONSTANTS_FILE="/helper/constants"
if [ -e "${CONSTANTS_FILE}" ]; then
    source "${CONSTANTS_FILE}"
else
    echo ""${CONSTANTS_FILE}" not found."
    exit 1
fi

# Create JB
result="$(curl -d name=${BUILD_ID} -d planid=20 -d distribution=debian_jessie_64bit -d use_sshkey ${base_url})"
if [ -z "echo ${result} | egrep ',"status":"CREATING"'" ]; then
    echo "Couldn't be started properly. Result was:"
    echo "${result}"
    # Try to delete the JB
    echo "Trying to delete failed JB..."
    # Bringe die ID der JB in Erfahrung
    curl -X DELETE ${base_url}/$(python /helper/jb_trans_name_to_id.py ${token} ${BUILD_ID})
    exit 1
fi
