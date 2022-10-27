#!/bin/sh -e

mailq | grep '^[0-9A-F]*!' | grep -E '(drupaladmin@mail.h-net.org|owner-museum-l@HOME.EASE.LSOFT.COM|visionesdelofantastico@gmail.com|@hotmail.com|jtomas@ffzg.hr|bounce@client.scholargatherings.com|owner-digital-preservation@JISCMAIL.AC.UK|info.icarushr@gmail.com|owner-infoling@LISTSERV.REDIRIS.ES|bounce-mc)' | awk '{ print $1 }' | tr -d '!' | xargs -i postsuper -H {}
sendmail -q