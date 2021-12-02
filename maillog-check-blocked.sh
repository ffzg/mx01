#!/bin/sh -xe

grep block /var/log/mail.log | grep -v https://support.google.com/mail/answer
