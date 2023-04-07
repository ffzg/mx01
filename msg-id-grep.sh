#!/bin/sh -xe

:> /dev/shm/msg.ids

if [ ! -z "$LOG" ] ; then
	log_file=/tmp/$( basename $LOG )
	zcat $LOG > $log_file
	zgrep postfix $log_file | grep "$@" | tee /dev/stderr | sed -e 's/^.*\]: \([0-9A-F]*\):.*$/\1/' | sort -u > /dev/shm/msg.ids
	./msg-id-follow.pl $log_file | less -S
	exit
fi


zgrep postfix $( ls -t /var/log/mail.log-*.gz | head -1 ) | grep "$@" | tee /dev/stderr | $( dirname $0 )/msg-id-filter.sh
grep postfix /var/log/mail.log | grep "$@" | tee /dev/stderr | $( dirname $0 )/msg-id-filter.sh
export GREP="$@"
( zcat $( ls -t /var/log/mail.log-*.gz | head -1 ) ; cat /var/log/mail.log ) | $( dirname $0 )/msg-id-follow.pl | less -S
