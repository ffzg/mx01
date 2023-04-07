#!/bin/sh -e

# filter just for one user:
# $0 grep karijere

# filter just some files by date:
# DATE=202111 ./count-user-mails.sh

LIMIT="head -10"
test ! -z "$1" && LIMIT="$@"

(
ls /var/log/mail.log-$DATE* | while read log ; do
	echo "# $log"
	zgrep postfwd $log | grep -v user= | grep sender= | grep -v 'sender=<[^>]*ffzg.hr>' | sed -e 's/^.*sender=//' -e 's/,.*$//' | sort | uniq -c | sort -rn | $LIMIT || true
	# || true is here to keep processing files in grep in LIMIT didn't find anything
done
) | tee /dev/shm/$( basename $0 ).txt

