#!/bin/bash

# g_benchmark="CIS_RHEL7"
g_token="66a4327c-5db6-4fdb-97a1-9fdafcd193e1"
g_splunk_endpoint="https://splunk.slice.puppetlabs.net:8088/services/collector" 

data=$1
curl -s -k -H "Authorization: Splunk $g_token" -H "Content-Type: application/json" $g_splunk_endpoint -d "$data"