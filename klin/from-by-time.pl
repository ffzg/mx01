#!/usr/bin/perl
use warnings;
use strict;

use Data::Dump qw(dump);
my $stat;
my $l = 0;
my $top = $ENV{TOP} || 5;

while(<>) {
	chomp;
	my ( $mon, $dd, $time, $host, $daemon, $msg ) = split(/\s+/,$_,6);

	next unless $msg =~ m/from=<([^>]+)>/;
	next if $msg =~ m/(NOQUEUE|FILTER)/;
	my $from = $1;

	my $t = $time;
	$t =~ s/\d:\d\d$/_/; # group by 10 min

	$stat->{$mon}->{$dd}->{$t}->{$from}++;

	$l++;
	print STDERR "$l " if $l % 10000 == 0;
}

#warn "# stat = ", dump( $stat );

foreach my $mon ( sort keys %$stat ) {
	foreach my $dd ( sort { $a <=> $b } keys %{$stat->{$mon}} ) {
		foreach my $t ( sort keys %{ $stat->{$mon}->{$dd} } ) {
			my $n = 0;
			my $e = $stat->{$mon}->{$dd}->{$t};
			my $fmt = "%3s %2s %5s %4d %s\n";
			foreach my $email ( sort { $e->{$b} <=> $e->{$a} } keys %$e ) {
				if ( $n == 0 ) {
					printf $fmt, $mon, $dd, $t, $e->{$email}, $email;
				} elsif ( $n == $top ) { # stop after top entries
					last;
				} else {
					printf $fmt, '', '', '', $e->{$email}, $email;
				}
				$stat->{_from}->{$email} += $e->{$email};
				$n++;
			}
		}
	}
}
#print "_from = ",dump( $stat->{_from} );
print "# XXX count,email\n";
my $nr = 0;
foreach my $email ( sort { $stat->{_from}->{$b} <=> $stat->{_from}->{$a} } keys %{ $stat->{_from} } ) {
	printf "%4d %s\n", $stat->{_from}->{$email}, $email;
	$nr++;
	last if $nr == $top;
}
