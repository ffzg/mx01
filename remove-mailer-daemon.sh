# usage: ./remove-mailer-daemon.sh [MAILER-DAEMON] | sudo postsuper -d -

from=MAILER-DAEMON
test ! -z "$1" && from=$1
mailq | grep -C 1 -i $from | grep ^[0-9A-Z] | awk '{ print $1 }' | sed 's/[*!]$//'
