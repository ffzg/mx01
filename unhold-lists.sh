#!/bin/sh -e

mailq | grep '^[0-9A-F]*!' | grep -E '(drupaladmin@mail.h-net.org|owner-museum-l@HOME.EASE.LSOFT.COM|visionesdelofantastico@gmail.com)' | awk '{ print $1 }' | tr -d '!' | xargs -i postsuper -H {}
sendmail -q
