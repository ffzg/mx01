grep from= spam.* | sed -e 's/.*from=<//' -e 's/>.*//' | sort -u | grep -v '^@ffzg.hr' > /tmp/from
ssh mx01 mailq | grep -f /tmp/from > /tmp/from.ids
ls -al /tmp/from.ids
cat /tmp/from.ids | awk '{ print $1 }' | ssh mx01 'tee from.ids | wc -l'
echo "# if > 0 run following on mx01 to cleanup mailq:"
echo "cat from.ids | sudo postsuper -d -"

