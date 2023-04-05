#!/bin/sh -e

# unhold-body.sh

sudo id >/dev/null
mailq | grep '^[0-9A-Z]*!' | awk '{ print $1 }' | sed 's/!$//' | while read id ; do
	#echo "### $id ###"
	sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat -hbe {} | sed "s/^/$id /" | \
		grep -i -E -f regex/unhold-body -f regex/unhold-body-exact \
		| tee /dev/stderr \
		| cut -d' ' -f1 | sudo postsuper -H -
done
