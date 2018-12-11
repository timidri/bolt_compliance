#!/usr/bin/env python

import subprocess

command = 'systemctl is-enabled crond'

try:
    output = subprocess.check_output(command, shell=True)
    print "control passed: crond enabled"
except subprocess.CalledProcessError as e:
    print "control failed: crond disabled"
