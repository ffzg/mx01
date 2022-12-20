#!/bin/sh -e

# unhold-lists.sh

# -B 1 to support to address from mailq

mailq \
	| grep -B 1 -E -f regex/unhold-from \
	| tee /dev/stderr \
	| grep '^[0-9A-F]*!' \
	| awk '{ print $1 }' | tr -d '!' | xargs -i postsuper -H {}
sendmail -q
