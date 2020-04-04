#!/bin/sh -xe

grep Received-SPF /var/log/mail.log | sed -e 's/^.*Received-SPF: //' -e 's/ .*$//'  | sort | uniq -c | sort -n
