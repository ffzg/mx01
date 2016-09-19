sudo grep -lr 'eval("\\' /srv/www/$*  | xargs -i ls -al {}
