#!/bin/sh

log=$1

if [ -z "$log" ] ; then
	log=/var/log/mail.log
fi

while [ ! -z "$log" ] ; do
	echo "# $log"
	zgrep 'banned sending IP' $log | tee /dev/shm/o365.banned.tmp

	cat /dev/shm/o365.banned.tmp | sed -e 's/^.*banned sending IP \[//' -e 's/\].*$//' | sort -u >> /dev/shm/o365.banned.ip.tmp

	if [ ! -z "$1" ] ; then
		shift
		log=$1
	else
		log=
	fi
done

echo "# banned IPs on o365:"
sort -u /dev/shm/o365.banned.ip.tmp
