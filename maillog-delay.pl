#!/usr/bin/perl
use warnings;
use strict;

# DELAY=5 ./maillog-delay.pl /var/log/mail.log
# zcat /var/log/mail.log-2021120*.gz | DELAY=60 ./maillog-delay.pl

my $debug = $ENV{DEBUG} || 0;
my $delay = $ENV{DELAY} || 60;

my $min = 999_999;
my $max = 0;

my $stat;
use Data::Dump;

while(<>) {
	chomp;
	next if m/status=deferred/;
	next if m/ postgrey\[/;

	if ( m/delay=(\d+(\.\d+)?)/ ) {
		my $d = $1;
		if ( $d > $delay ) {
			print "[$d] $_\n";

			$max = $d if $d > $max;
			$min = $d if $d < $min;

			if ( m/to=<[^@]+@([^>]+)>/ ) {
				$stat->{to_domain}->{lc($1)}++;
			}
		} else {
			#print "#[$d]# $_\n";
		}

	} else {
		warn "# $_\n" if $debug;
	}
}

print "# min:$min max:$max\n";
print Data::Dump::dump( $stat );
