#!/usr/bin/perl
use warnings;
use strict;
use autodie;

use Data::Dump qw(dump);

my $stat;

open(my $fh, '<', '/var/log/mail.log');
if ( -e '/dev/shm/mail.tell' ) {
	open(my $fh_tell, '<', '/dev/shm/mail.tell');
	my $pos = <$fh_tell>;
	eval {
		seek($fh, $pos, 0);
	}
}
while(<$fh>) {
	if ( m/squirrelmail/ ) {
		chomp;
		my ( undef, $action, $user, $ip ) = split(/[:,]\s/,$_,4);
		$ip =~ s/\w+=//g;
		$user =~ s/\w+=//g;
		$user =~ s/[<>]//g;
		$stat->{$action}->{$user}->{$ip}++;
	} else {
		$stat->{lines}->{ignored}++;
	}
}

warn dump($stat);
open(my $fh_tell, '>', '/dev/shm/mail.tell');
print $fh_tell tell($fh);
close($fh_tell);
