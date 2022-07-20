#!/bin/sh -xe

sudo id
mailq | grep '^[0-9A-Z]*!' | awk '{ print $1 }' | sed 's/!$//' | while read id ; do
	echo "### $id ###"
	sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat {} | tee /dev/stderr | sed "s/^/$id /" | grep -E '(messages are queued in the server due to error.)' | cut -d' ' -f1 | sudo postsuper -d -
done
