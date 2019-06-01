#!/bin/sh -e

ls /var/log/mail.log-*.gz | while read log ; do
	echo "# $log"
	zgrep user= $log | grep sender= | grep -v 193.198.21[2-5] | sed -e 's/^.*user=//' -e 's/,.*$//' | sort | uniq -c | sort -rn | head -3
done

