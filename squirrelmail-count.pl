#!/usr/bin/perl
use warnings;
use strict;
use autodie;

# ./squirrelmail-count.pl /var/log/mail.log

use Data::Dump qw(dump);

my $stat;

while(<>) {
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

#warn dump($stat);

if ( exists $stat->{'Mass mailing'} ) {
	foreach my $user ( keys %{ $stat->{'Mass mailing'} } ) {
		my $count = 0;
		foreach my $ip ( keys %{ $stat->{'Mass mailing'}->{$user} } ) {
			$count += $stat->{'Mass mailing'}->{$user}->{$ip};
		}
		if ( $count > 5 ) { # FIXME arbitrary set for our users to avoid false trigger
			print "$user MASS MAILING $count times ip:", join(' ',keys %{ $stat->{'Mass mailing'}->{$user} }),"\n";
			my $ip = ( keys %{ $stat->{'Mass mailing'}->{$user} } )[0];
			system "geoiplookup $ip | grep -v HR && ssh -i /var/lib/postfw/.ssh/id_rsa root\@mudrac $user";
		}
	}
}

