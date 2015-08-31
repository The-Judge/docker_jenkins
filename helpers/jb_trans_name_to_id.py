#!/usr/bin/env python
import sys
import requests
import json

'''
This script takes two arguments: API-TOKEN NAME
It queries the JiffyBox - API for a list of all existing JiffyBoxes using the API-Token provided. It returns the ID of
the JiffyBox with the given name.
'''

# Set constants
token = sys.argv[-2]
base_url = "https://api.jiffybox.de/"
base_url += token
base_url += "/v1.0/jiffyBoxes"

# Create response object r
r = requests.get(base_url)

# Create json object json from response object r
json = json.loads(r.text)

# Find id matching name
for id in json['result']:
    if sys.argv[-1] in json['result'][id]['name']:
        print id
