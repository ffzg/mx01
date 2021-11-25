#!/bin/sh

test -z $DELAY && DELAY=20

zgrep delays= $( test ! -z "$@" && echo $@ || echo /var/log/mail.log ) | grep -v status=deferred | sed -e 's/postfix.*delay=//' -e 's/, delays=/ /' -e 's/, dsn=.*$//' | awk -v DELAY=$DELAY '{ if ( $5 > DELAY ) print }'
