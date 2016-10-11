#!/usr/bin/perl
use warnings;
use strict;
use autodie;

# ./find-sasl-fakers.pl `grep -l sasl_ ./log.d/*/*.log`

use Data::Dump qw(dump);

my $aliases;
open(my $a, '<', 'log.d/mudrac/aliases');
while(<$a>) {
	next if ( /^\s*#/ );
	if ( /^(\S+):\s*(\S+)/ ) {
		my ( $full_name, $login ) = ( $1, $2 );
		$aliases->{$full_name} = $login;
	}
}
close($a);

open(my $s, '>>', "spam.$$.log");

my $spam;
my $ids;

my $regex = 'X';

while(<>) {
	chomp;

	next if m{postfix/cleanup};

	if ( /\s(\w+): client=(\S+), .+ sasl_username=(\S+)/ ) {
		my ( $id, $client, $username ) = ( $1,$2,$3 );
		$username =~ s/\@ffzg.hr//;
		$ids->{$id} = [ $username, $client ];
		$regex = join('|', keys %$ids);
	} elsif ( /\s($regex): .+?from=<([^>]+)>/ ) {
		my ( $id, $from ) = ( $1, $2 );
		$from =~ s/\@ffzg.hr//;
		if ( my $login = $aliases->{$from} ) {
			$from = $login;
		}

		next if ! defined $ids->{$id};
		my $login = $ids->{$id}->[0];

		if ( $from eq $login ) {
			#warn "# OK $id $from ",dump( $ids->{$id} );
			print STDERR ".";
			delete $ids->{$id};
		} elsif ( $from ne 'MAILER-DAEMON' ) {
			#warn "SPAM $id $from ",dump( $ids->{$id}, $_ );
			print STDERR "S";
			$spam->{$login}++;
			print $s "$id $from ",dump( $ids->{$id} ), "$_\n";
			$s->flush;
		}
	}
}

#warn "# ids ",dump($ids);
warn "# spam ",dump($spam);
