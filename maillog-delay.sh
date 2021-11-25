zgrep delays= $( test ! -z "$@" && echo $@ || echo /var/log/mail.log ) | grep -v status=deferred | sed -e 's/postfix.*delay=//' -e 's/, delays=/ /' -e 's/, dsn=.*$//' | awk '{ if ( $5 > 20 ) print }'
