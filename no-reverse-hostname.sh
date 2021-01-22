#!/bin/sh -e

grep 'Client host rejected: cannot find your reverse hostname' /var/log/mail.log | cut -d\[ -f3 | cut -d\] -f1 | sort | uniq -c | tee /dev/shm/no-reverse-hostname
