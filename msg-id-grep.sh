#!/bin/sh -xe

if [ ! -z "$LOG" ] ; then
	log_file=/tmp/$( basename $LOG )
	zcat $LOG > $log_file
	zgrep postfix $log_file | grep "$@" | tee /dev/stderr | sed -e 's/^.*\]: \([0-9A-F]*\):.*$/\1/' | sort -u > /dev/shm/msg.ids
	./msg-id-follow.pl $log_file | less -S
	exit
fi


grep postfix /var/log/mail.log | grep "$@" | tee /dev/stderr | sed -e 's/^.*\]: \([0-9A-F]*\):.*$/\1/' | sort -u > /dev/shm/msg.ids
