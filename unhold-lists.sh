#!/bin/sh -e

# unhold-lists.sh

# -B 1 to support to address from mailq

mailq \
	| grep -B 1 -E '(drupaladmin@mail.h-net.org|owner-museum-l@HOME.EASE.LSOFT.COM|visionesdelofantastico@gmail.com|@hotmail.com|jtomas@ffzg.hr|bounce@client.scholargatherings.com|owner-digital-preservation@JISCMAIL.AC.UK|info.icarushr@gmail.com|owner-infoling@LISTSERV.REDIRIS.ES|bounce-mc|@mailer.opensciencejournals.net|bounce.linkedin.com|sender[0-9].acmbma.com|noreply@esavjetovanja.gov.hr|socinfolista@gmail.com|=astulhof=ffzg.hr@gmail.com|veda-nada@knjiga-znanja-veda.hr|istrazivanje.udruge@gmail.com|ffrz.hr|donotreply@fer.hr|knjiznica.m.j.zagorke@kgz.hr|myess@upf.edu|secretariat@wcprome2024.com|mail.data.europa.eu|@fuds.si|vedrancosic@gmail.com|shisecond@shiconference.site|prejimsfoundation@gmail.com|matica.cakovec@gmail.com|blackouthiphop@gmail.com|icadl2022@gmail.com|dr.stambuk@gmail.com|callforpaper@ijlrhss.com|usf.ffzg@gmail.com|socinfolista@gmail.com|pisjournal.net@gmail.com|hsls.zagreb@gmail.com|mandalenal@gmail.com)' \
	| grep '^[0-9A-F]*!' \
	| awk '{ print $1 }' | tr -d '!' | xargs -i postsuper -H {}
sendmail -q
