#!/bin/sh -e

# tail-unhold-lists.sh

cd /home/dpavlin/mx01

tail -F /var/log/mail.log  \
	| grep --line-buffered ': [0-9A-F]*: hold:' \
	| xargs -i sh -cx './unhold-body.sh ; ./unhold-lists.sh'

