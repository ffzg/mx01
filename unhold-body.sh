#!/bin/sh -e

sudo id >/dev/null
mailq | grep '^[0-9A-Z]*!' | awk '{ print $1 }' | sed 's/!$//' | while read id ; do
	#echo "### $id ###"
	sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat {} | sed "s/^/$id /" | \
		grep -E '(paper abstract|abstract submission)' | cut -d' ' -f1 | sudo postsuper -H -
done
