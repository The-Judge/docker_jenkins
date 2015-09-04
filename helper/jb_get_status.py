#!/usr/bin/env python
import sys
import requests
import json

'''
This script takes two arguments: API-TOKEN ID STATUS
It queries the JiffyBox - API for a list of all existing JiffyBoxes using the API-Token provided. It returns the status
of the field STATUS for the JiffyBox with the given name.

STATUS can be any of the following:
status
running
'''

# Set constants
token = sys.argv[-3]
boxid = sys.argv[-2]
field = sys.argv[-1]
base_url = "https://api.jiffybox.de/"
base_url += token
base_url += "/v1.0/jiffyBoxes/"
base_url += boxid

# Create response object r
r = requests.get(base_url)

# Create json object json from response object r
json = json.loads(r.text)

# Find id matching name
print json['result'][field]
