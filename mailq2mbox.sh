#!/bin/sh -xe

find /dev/shm/ -name 'id.*' -ctime +1 -exec rm -v {} \;

mbox=/tmp/mbox.mailq
:> $mbox
:> $mbox.ids


mailq | grep '^[0-9A-F][0-9A-F]*' | while read line ; do

id=$( echo $line | awk '{ print $1 }' | tr -d '!' );
echo $id >> $mbox.ids
echo -n "From $id " >> $mbox
sudo postcat -e -q $id > /dev/shm/id.$id
grep message_arrival_time: /dev/shm/id.$id | cut -d: -f2- >> $mbox
sudo postcat -hb -q $id| tee -a /dev/shm/id.$id >> $mbox
echo >> $mbox

done

mutt -f $mbox
