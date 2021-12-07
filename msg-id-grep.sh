#!/bin/sh -xe

grep postfix /var/log/mail.log | grep "$@" | tee /dev/stderr | sed -e 's/^.*\]: \([0-9A-F]*\):.*$/\1/' | sort -u > /dev/shm/msg.ids
