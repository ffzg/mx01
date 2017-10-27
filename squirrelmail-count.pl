#!/usr/bin/perl
use warnings;
use strict;
use autodie;

use Data::Dump qw(dump);

my $stat;

my $file = shift @ARGV || '/var/log/mail.log';

open(my $fh, '<', $file);
my $tell = $file;
$tell =~ s/\W//g;
$tell = "/dev/shm/tell.$tell";
if ( -e $tell && ! $ENV{DEBUG} ) {
	open(my $fh_tell, '<', $tell);
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

warn dump($stat) if $ENV{DEBUG};

open(my $fh_tell, '>', $tell);
print $fh_tell tell($fh);
close($fh_tell);

if ( exists $stat->{'Mass mailing'} ) {
	foreach my $user ( keys %{ $stat->{'Mass mailing'} } ) {
		my $count = 0;
		foreach my $ip ( keys %{ $stat->{'Mass mailing'}->{$user} } ) {
			$count += $stat->{'Mass mailing'}->{$user}->{$ip};
		}
		if ( $count > 5 ) { # FIXME arbitrary set for our users to avoid false trigger
			print "$user MASS MAILING $count times\n";
		}
	}
}

