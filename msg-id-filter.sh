#!/bin/sh -e

echo "# remove with rm /dev/shm/msg.ids" >/dev/stderr
grep ': [0-9A-F][0-9A-F]*[:,]' | sed -e 's/^.*: \([0-9A-F]*\)[:,].*$/\1/' | sort -u | tee -a /dev/shm/msg.ids
