#!/bin/sh

ips="$*"
test -z "$ips" && ips=$( ip addr | grep 193.198 | sed -e 's/^.*inet //' -e 's/\/.*$//' )
echo "# ips: $ips"
rblcheck \
-s all.s5h.net \
-s b.barracudacentral.org \
-s bl.emailbasura.org \
-s bl.spamcop.net \
-s blacklist.woody.ch \
-s bogons.cymru.com \
-s cbl.abuseat.org \
-s combined.abuse.ch \
-s db.wpbl.info \
-s dnsbl-1.uceprotect.net \
-s dnsbl-2.uceprotect.net \
-s dnsbl-3.uceprotect.net \
-s dnsbl.anticaptcha.net \
-s dnsbl.dronebl.org \
-s dnsbl.inps.de \
-s dnsbl.sorbs.net \
-s dnsbl.spfbl.net \
-s drone.abuse.ch \
-s duinv.aupads.org \
-s dul.dnsbl.sorbs.net \
-s dyna.spamrats.com \
-s dynip.rothen.com \
-s http.dnsbl.sorbs.net \
-s ips.backscatterer.org \
-s ix.dnsbl.manitu.net \
-s korea.services.net \
-s misc.dnsbl.sorbs.net \
-s noptr.spamrats.com \
-s orvedb.aupads.org \
-s pbl.spamhaus.org \
-s proxy.bl.gweep.ca \
-s psbl.surriel.com \
-s relays.bl.gweep.ca \
-s relays.nether.net \
-s sbl.spamhaus.org \
-s singular.ttk.pte.hu \
-s smtp.dnsbl.sorbs.net \
-s socks.dnsbl.sorbs.net \
-s spam.abuse.ch \
-s spam.dnsbl.anonmails.de \
-s spam.dnsbl.sorbs.net \
-s spam.spamrats.com \
-s spambot.bls.digibase.ca \
-s spamrbl.imp.ch \
-s spamsources.fabel.dk \
-s ubl.lashback.com \
-s ubl.unsubscore.com \
-s virus.rbl.jp \
-s web.dnsbl.sorbs.net \
-s wormrbl.imp.ch \
-s xbl.spamhaus.org \
-s z.mailspike.net \
-s zen.spamhaus.org \
-s zombie.dnsbl.sorbs.net \
$ips | grep -v 'not listed by'

