#!/bin/sh -e

sudo id >/dev/null
mailq | grep '^[0-9A-Z]*!' | awk '{ print $1 }' | sed 's/!$//' | while read id ; do
	#echo "### $id ###"
	sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat {} | sed "s/^/$id /" | grep -E '(messages are queued in the server due to error.|Mailbox Full|storageapi.fleek.co|support@posta.hr|service@intl.paypl.com|newsletter@intersport.hr|cutt.ly/5NrSmeX|Ferzi Karhan|imate isto prezime kao i moj pokojni klijent|Ujedinjenih naroda .UN. na razini Prevaranti / Prevaranti)' | cut -d' ' -f1 | sudo postsuper -d -
done
