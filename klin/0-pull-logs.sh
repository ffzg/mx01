#!/bin/sh -xe

pull() {
	test -d log || mkdir -p log.d/$1
	rsync -va $1:/var/log/mail.log* log.d/$1
}

rsync -va mudrac:/etc/aliases log.d/mudrac/

pull deenes
pull mx01
pull mudrac
pull pauk
pull ws1
