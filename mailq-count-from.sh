mailq | grep ^[0-9A-Z] | awk '{ print $7 }' | sort | uniq -c | sort -rn
