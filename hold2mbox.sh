#!/bin/sh -xe

mbox=/tmp/mbox.hold
:> $mbox
:> $mbox.ids


mailq | grep '^[0-9A-F]*!' | while read line ; do

id=$( echo $line | awk '{ print $1 }' | tr -d '!' );
echo $id >> $mbox.ids
queue_file=$( sudo find /var/spool/postfix/ -name $id )
echo -n "From $id " >> $mbox
postcat -e $queue_file > /dev/shm/id.$id
grep message_arrival_time: /dev/shm/id.$id | cut -d: -f2- >> $mbox
postcat -hb $queue_file | tee -a /dev/shm/id.$id >> $mbox
echo >> $mbox

done

mutt -f $mbox

if [ ! -s $mbox ] ; then
	echo "postsuper -d - < $mbox.ids"
fi
