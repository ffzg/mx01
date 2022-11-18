#!/bin/sh -ex

discard_file=/dev/shm/postfix.discard

write_discard() {
	patt=$1
	ext=$2

	file=$discard_file$ext

	test -z "$patt" && return
	grep "$patt" $file && return

	echo "## write_discard $patt [$ext]"
	echo "/$patt/	DISCARD" | tee -a $file

	./hold-remove-grep.sh $patt
}

echo "# top 5 from" > /dev/stderr
most_from=$( mailq | grep '^[0-9A-F]' | sort -k 7 | grep \! | awk '{ print $7 }' | sort | uniq -c | sort -nr | head -5 | tee /dev/stderr | head -1 | awk '{ print $2 }');

echo "## most_from $most_from"

#mailq | grep '^[0-9A-F]' | sort -k 7 | grep \! | grep $most_from | while read line ; do
line=$( mailq | grep '^[0-9A-F]' | grep \! | grep $most_from )

	id=$( echo $line | cut -d\! -f1 )

	echo "## id $id [$line]"
	id_file=/dev/shm/id.$id

	sudo find /var/spool/postfix/ -name $id | sudo xargs -i postcat {} > $id_file
	reply_to=$( grep '^Reply-To: .*' $id_file | cut -d: -f2 )
	echo "## replay_to $replay_to"

	if [ ! -z "$reply_to" ] ; then
		less -P "DISCARD reply to $reply_to" $id_file
		write_discard "$reply_to" # quote to pass as signle arg
		echo $id | tee $discard_file.id

	else
		less -P "find pattern" $id_file
	fi


	read -p "ENTER anything and press ENTER to discard (ctrl+c to abort) [$sender] " do_discard < /dev/stdin
	test ! -z "$do_discard" && write_discard "$do_discard" ".body"
	echo "unhold	postsuper -H $id"
	echo "delete	postsuper -d $id"

	sender=$( grep '^sender: ' $id_file | grep '[0-9][0-9]*@gmail.com' | cut -d' ' -f2 )
	write_discard "$sender"




#done
