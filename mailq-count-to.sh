mailq | grep -A 3 ^[0-9A-F] | grep '^  *\([^ ]*\)$' | sed 's/^ *//' | sort | uniq -c | sort -nr
