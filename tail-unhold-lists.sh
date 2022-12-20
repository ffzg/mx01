#!/bin/sh -e

# unhold-lists.sh

# -B 1 to support to address from mailq

tail -F /var/log/mail.log  \
	| grep ': [0-9A-F]*: hold:' \
	| tee /dev/stderr \
	| grep -B 1 -E -f regex/unhold-from \
	| tee /dev/stderr \
	| cut -d' ' -f6 | tr -d ':' \
	| xargs -i postsuper -H {}

exit 0
	| grep '^[0-9A-F]*!' \
	| awk '{ print $1 }' | tr -d '!' | xargs -i postsuper -H {}
sendmail -q
