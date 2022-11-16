grep Greylisted /var/log/mail.log | sed -e 's/^.*from //' -e 's/\[.*$//' | sort | uniq -c | sort -rn | tee /dev/shm/graylisted.hosts | head -20
