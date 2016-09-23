#!/bin/sh -xe

pull() {
	test -d log || mkdir -p log.d/$1
	rsync -va $1:/var/log/mail.log* log.d/$1
}

pull ws1
pull mudrac
pull mx01
pull deenes
#pull pauk
