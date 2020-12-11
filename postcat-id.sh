#!/bin/sh -e

sudo id
sudo find /var/spool/postfix/deferred/ -name $1 | sudo xargs -i postcat {} | less
