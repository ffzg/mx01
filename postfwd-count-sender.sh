#!/bin/sh -xe

test -z "$LOG" && LOG=/var/log/mail.log

recipient="#"
test ! -z "$1" && recipient='s/, recipient=/ /'
grep 'postfwd.*sender=' $LOG | sed -e 's/^.*sender=//' -e "$recipient" -e 's/,.*//' -e 's/[<>]//g'| sort | uniq -c | sort -nr | column -t
