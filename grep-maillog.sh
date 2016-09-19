#!/bin/sh -xe
top_from=`./mailq-count-from.sh | sort -n -r | head -1 | awk '{ print $2 }'`
sudo grep $* $top_from /var/log/mail.log
