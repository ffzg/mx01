#!/bin/sh -xe

test -z "$1" && echo "Usage: $0 to-email@example.com" && exit 1
mailq | grep -B 2 anita_ruso@yahoo.com | tee /dev/stderr | grep '^[0-9A-F]' | awk '{ print $1 }'

