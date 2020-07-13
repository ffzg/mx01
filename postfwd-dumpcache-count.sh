#!/bin/sh -xe

sudo -u postfw /usr/sbin/postfwd --port 10040 --dumpcache | grep @count | tr -d \' | sort -n -k 9 -r | less
