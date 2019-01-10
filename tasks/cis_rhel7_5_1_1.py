#!/usr/bin/env python
#
# 5.1.1 Ensure cron daemon is enabled (Scored)
#
# Description:
#
# The cron daemon is used to execute batch jobs on the system.
# Rationale:
#
# While there may not be user jobs that need to be run on the system, the system does have
# maintenance jobs that may include security monitoring that have to run, and cron is used
# to execute them.

import subprocess
import json

command = 'systemctl is-enabled crond'

description = "The cron daemon is used to execute batch jobs on the system."
rationale = """While there may not be user jobs that need to be run on the system, the system does have
maintenance jobs that may include security monitoring that have to run, and cron is used
to execute them"""

result = {}

try:
    output = subprocess.check_output(command, shell=True)
    result['_output'] = "control passed: crond enabled - " + output
    result['compliant'] = True
except subprocess.CalledProcessError as e:
    result['_output'] = "control failed: crond disabled - " + e.output
    result['compliant'] = False

result['description'] = description
result['rationale'] = rationale

print(json.dumps(result))
