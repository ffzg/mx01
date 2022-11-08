#!/bin/sh

# usage: $0 grep-pattern /var/log/mail.log-20221105.gz

out=/dev/shm/follow.out

test -e /dev/shm/msg.ids && rm /dev/shm/msg.ids
zgrep $1 $2 | ./msg-id-filter.sh
zcat $2 | ./msg-id-follow.pl | tee $out | less -S
echo "output in $out"
