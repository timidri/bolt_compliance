#!/bin/bash
#
# CIS Apache HTTP Server Benchmark 3.2
#
# Give the Apache User Account an Invalid Shell
#
# Description:
#
# The apache account must not be used as a regular login account
# and should be assigned an invalid or nologin shell to ensure
# that the account cannot be used to login.
# 
# Rationale:
# 
# Service accounts such as the apache account represent a risk
# if they can be used to get a login shell to the system.
#

if [ "$(awk -F: -v user="${PT_user}" '$1 == user {print $7 }' /etc/passwd)" = "/sbin/nologin" ] ; then
  echo "Control passed: Shell is invalid for login"
else
  echo "Control failed: Shell is not invalid for login"
fi
