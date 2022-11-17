#!/bin/sh -e

sudo id >/dev/null
mailq | grep '^[0-9A-Z]*!' | awk '{ print $1 }' | sed 's/!$//' | while read id ; do
	#echo "### $id ###"
	sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat {} | sed "s/^/$id /" | grep -E '(messages are queued in the server due to error.|Mailbox Full|storageapi.fleek.co|support@posta.hr|service@intl.paypl.com|newsletter@intersport.hr|cutt.ly/5NrSmeX|Ferzi Karhan|imate isto prezime kao i moj pokojni klijent|Ujedinjenih naroda .UN. na razini Prevaranti / Prevaranti|kontaktirao po ovom pitanju jer se prezivate|croloadredey-bd508c.ingress-earth.ewp.live/siudaaa|managed-vps.net|Admin@ffzg.hr|pangsheng79@gmail.com|outdated version of Webmail|dev.dkndetofdg8cz.amplifyapp.com|nema registriranog nasljednika u datotekama|primili gore navedena sredstva, savjetujemo vam da kontaktirate|policeinterpo222@gmail.com|ferzikarhan74.esq@gmail.com|infoattorneyatlaw414@gmail.com|bbosserman@twu.edu|bwainwri@eastern.edu|ANTONIO GEROVAC|odvjetnik Ferzi Karhan|Za vašu referencu priložen je dokument koji pokazuje neizmireno|Barrister David Abula|I am in possession of a large sum of money|barr.ferzikarhan.info@gmail.com|jjosephh1@hotmail.com|newyorkoffice6@gmail.com)' | cut -d' ' -f1 | sudo postsuper -d -
done
