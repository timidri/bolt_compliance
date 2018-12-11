#!/bin/bash
#
# CIS Red Hat Enterprise Linux 7 Benchmark 1.1.2
#
# Ensure separate partition exists for /tmp
#
# Description:
# The /tmp directory is a world-writable directory used for temporary storage by all users
# and some applications.
# 
# Rationale:
# 
# Since the /tmp directory is intended to be world-writable, there is a risk of resource
# exhaustion if it is not bound to a separate partition. In addition, making /tmp its own file
# system allows an administrator to set the noexec option on the mount, making /tmp useless
# for an attacker to install executable code. It would also prevent an attacker from
# establishing a hardlink to a system setuid program and wait for it to be updated. Once the
# program was updated, the hardlink would be broken and the attacker would have his own
# copy of the program. If the program happened to have a security vulnerability, the attacker
# could continue to exploit the known flaw.

if mount | grep /tmp > /dev/null ; then
  echo -n "Control passed: /tmp is a separate filesystem"
else 
  echo -n "Control failed: /tmp is not a separate filesystem"
fi
