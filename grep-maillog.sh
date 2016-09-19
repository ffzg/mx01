#!/bin/sh -xe
test -z "$FROM" && FROM=`./mailq-count-from.sh | sort -n -r | head -1 | awk '{ print $2 }'`
sudo grep $* $FROM /var/log/mail.log
