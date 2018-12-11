#!/usr/bin/env python

import sys
import json
import requests

params = json.load(sys.stdin)

splunk_endpoint = params['splunk_endpoint']
splunk_token = params['splunk_token']
data = params['data']

headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Splunk ' + splunk_token
}

response = requests.post(
    splunk_endpoint, headers=headers, json=data, verify=False)

result = {}
result['_output'] = response.text

print(json.dumps(result))
