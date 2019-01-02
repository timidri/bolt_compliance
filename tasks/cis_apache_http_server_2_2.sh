#!/bin/bash
#
# CIS Apache HTTP Server Benchmark 2.2
#
# Enable the Log Config Module
#
# Description:
# The log_config module provides for flexible logging of client requests
# and provides for the configuration of the information in each log.
# 
# Rationale:
# 
# Logging is critical for monitoring usage and potential abuse of your web server.
# This module is required to configure web server logging using the log_format directive.
#

if /usr/sbin/httpd -M | grep -q log_config ; then
  echo -n "Control passed: Log Config module is enabled"
else 
  echo -n "Control failed: Log Config module is not enabled"
fi
