#!/bin/sh -xe

cat <<__SQL__ | mysql --user=postfwdspam --password=$(grep 'my $password' /etc/postfix/postfwd-plugins/postfwd-anti-spam.plugin  | cut -d\" -f2) $1 postfwdspam
select * from postfwd_logins
order by sasl_username,last_login
__SQL__
