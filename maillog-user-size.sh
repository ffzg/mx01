#!/bin/sh -xe

grep postfix/qmgr /var/log/mail.log | grep size= | sed -e 's/^.*from=<//' -e 's/>, size=/ /' -e 's/,.*$//' -e 's/^ /- /' | awk '{ sum[$1] += $2 count[$1]++ } END { for (u in sum) printf "%8d %8d %8d %s\n", sum[u], count[u], sum[u] / count[u], u }' | sort -k1 -n -r
