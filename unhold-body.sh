#!/bin/sh -e

# unhold-body.sh

sudo id >/dev/null
mailq | grep '^[0-9A-Z]*!' | awk '{ print $1 }' | sed 's/!$//' | while read id ; do
	#echo "### $id ###"
	sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat {} | sed "s/^/$id /" | \
		grep -i -E '(paper abstract|abstract submission|najava edukacije|esteem delegates|Hrvatska kulturna zajednica|List-Post:|List-Unsubscribe:|pozvati Vas|znanstvenu konferenciju|akademskog|University|article|izlet|studentice|studenti|predavanje|Professor|Radionica|akademici|conference|Pozivnica|izlet|domjen|vrtic|seminar|Predstava|letak|roditelji|sastanku|roditelje|evidenciji|knjig|diplome|nagrade|unizg.hr|kgz.hr)' \
		| cut -d' ' -f1 | sudo postsuper -H -
done
