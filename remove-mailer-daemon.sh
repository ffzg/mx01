mailq | grep MAILER-DAEMON | grep ^[0-9A-Z] | awk '{ print $1 }' | sed 's/*$//'
