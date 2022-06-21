#!/bin/sh -e

sudo id
id=$( echo $1 | sed s/!$// )
sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat {} | less
