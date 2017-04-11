mailq | grep ^[0-9A-Z] | awk '{ print $1 }' | sed 's/*$//' \
| sed 's!\(.\)\(.\)\(.\)!/var/spool/postfix/deferred/\1/\2/\3/\1\2\3!' \
| xargs -i sudo grep -a -l X-PHP-Originating-Script {} \
| cut -d/ -f 9 \
| xargs -i sudo postcat -q {} \
| cat
exit 0
| grep X-PHP-Originating-Script

