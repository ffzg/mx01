#!/bin/sh -e

cat <<__SQL__ | tee /dev/null | mysql --user=postfwdspam --password=$(grep 'my $password' /etc/postfix/postfwd-plugins/postfwd-anti-spam.plugin  | cut -d\" -f2) postfwdspam
select * from postfwd_logins
where sasl_username="$1"
order by sasl_username,last_login
__SQL__
