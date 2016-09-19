sudo grep $1 /var/log/uwsgi/*.log | cut -d: -f1,9 | sed -e 's/:.* POST //' -e 's/ .*$//' -e 's!var/log/uwsgi!srv/www!' -e 's/\.log//' | sort -u
