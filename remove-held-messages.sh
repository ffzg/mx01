#!/bin/sh -xe

# ./remove-held-messages.sh | sudo postsuper -d -

mailq | grep '^[0-9A-Z]*!' | awk '{ print $1 }' | sed 's/!$//'
