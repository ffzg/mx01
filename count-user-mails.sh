#!/bin/sh -e

# filter just for one user:
# $0 grep karijere

# filter just some files by date:
# DATE=202111 ./count-user-mails.sh

LIMIT="head -5"
test ! -z "$1" && LIMIT="$@"

(
ls /var/log/mail.log-$DATE* | while read log ; do
	echo "# $log"
	zgrep user= $log | grep sender= | grep -v 193.198.21[2-5] | sed -e 's/^.*user=//' -e 's/,.*$//' | sort | uniq -c | sort -rn | $LIMIT || true
	# || true is here to keep processing files in grep in LIMIT didn't find anything
done
) | tee /dev/shm/$( basename $0 ).txt

cat /dev/shm/count-user-mails.sh.txt | awk '$1 > 300 { print $2 }' | tail -9 | tee /dev/shm/spam.logins
