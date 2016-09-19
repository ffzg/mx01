mailq | grep ^[0-9A-Z] | awk '{ print $1 }' \
| sed 's!\(.\)\(.\)\(.\)!/var/spool/postfix/deferred/\1/\2/\3/\1\2\3!' \
| xargs -i sudo grep -a X-PHP-Originating-Script {} \
| tr '[\000-\011\013-\037\177-\377]' '\n' \
| grep X-PHP-Originating-Script
