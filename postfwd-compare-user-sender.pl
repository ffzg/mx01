#!/usr/bin/perl
use warnings;
use strict;

use autodie;
use Data::Dump qw(dump);

my $stat;

open(my $fh, '<', 'aliases');
while(<$fh>) {
	chomp;
	next unless m/:\s+/;
	my ( $from, $to ) = split(/:\s*/,$_,2);
	$stat->{aliases}->{lc($from)} = $to;
}
close($fh);

while(<>) {
	chomp;
	if ( m/postfwd.*user=(\S+), sender=<([^>]+)/ ) {
		$stat->{_lines}++;
		print STDERR '.' if $stat->{_lines} % 1000 == 0;
		my ($user,$sender) = ($1,$2);
		$user =~ s/\@ffzg.hr$//;
		$sender =~ s/\@ffzg.hr$//;

		next if lc($user) eq lc($sender);

		if ( exists $stat->{aliases}->{lc($sender)} ) {
			my $to = $stat->{aliases}->{lc($sender)};
			#warn "# alias $sender -> $to";
			if ( $to ne $user ) {
				$stat->{warn}->{$user}->{$sender}++;
			}
			next;
		}

		$stat->{spam}->{$user}->{$sender}++ unless $user eq $sender;
	}
}

my $find;


delete $stat->{aliases};

print "# stat = ",dump($stat), $/ if scalar(keys(%$stat)) > 1;
