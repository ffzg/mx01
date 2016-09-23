#!/bin/sh -xe
grep from= log/deenes | sed 's/^.*from=//' | cut -d' ' -f1 | grep ffzg.hr | sed 's/,//' | sort | uniq -c | sort -nr | less -S
