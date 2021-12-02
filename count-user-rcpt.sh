#!/bin/sh -e

LIMIT="head -5"
test ! -z "$1" && LIMIT="$@"
(
ls /var/log/mail.log-$DATE* | while read log ; do
	echo "# $log"
	# count unique recipients for each logged in user
	zgrep user= $log | grep recipient= | grep -v 193.198.21[2-5] | sed -e 's/^.*user=//' -e 's/,.*recipient=/ /' -e 's/,.*$//' | sort -u | cut -d' ' -f1 | uniq -c | sort -rn | $LIMIT || true
done
) | tee /dev/shm/$( basename $0 ).txt

