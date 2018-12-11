#!/bin/bash
# CIS Red Hat Enterprise Linux 7 Benchmark 1.1.2

if [ $(mount | grep /tmp > /dev/null) ] ; then
  echo "Control passed: /tmp is a separate filesystem"
else 
  echo "Control failed: /tmp is not a separate filesystem"
fi