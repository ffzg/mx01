#!/usr/bin/perl
use warnings;
use strict;

use Data::Dumper;

my $debug = $ENV{DEBUG} || 0;

# if we don't have pipe or arguments
if ( -t STDIN and not @ARGV ) {
	push @ARGV, '/var/log/mail.log';
}

open(my $ids_fh, '<', '/dev/shm/msg.ids') || die "/dev/shm/msg.ids: $!";
my $id_usage;
my @ids = map { s/[\r\n]$//; $id_usage->{$_} = 1; $_ } <$ids_fh>;
close($ids_fh);

my $id_regex = join('|', @ids);

warn "# got ", scalar(@ids), " message ids $id_regex\n";

while(<>) {
	chomp;
	#if ( m/: ($id_regex):/ ) { # only postfix lines
	if ( m/($id_regex)/ ) {	# everything with this queue id
		$id_usage->{$1}++;
		print "$_\n";
		if ( m/queued as ([0-9A-F]+)/ ) {
			if ( length($1) >= 7 ) { # minimum valid message id
				$id_usage->{$1}++; undef $id_regex;
				warn "## ++ queued id_regex: $1\n" if $debug;
			} else {
				warn "# ignore $1 not valid message id\n";
			}
		}
		if ( m/forwarded as ([0-9A-F]+)/ ) {
			$id_usage->{$1}++; undef $id_regex;
			warn "## ++ orwarded id_regex: $1\n" if $debug;
		}
		if ( m/: ([0-9A-F]+): removed/ ) {
			warn "## -- removed id_regex: $1\n" if $debug;
			delete $id_usage->{$1}; undef $id_regex;
		}

		$id_regex = join('|', keys %$id_usage) if ( ! $id_regex );
	}
}

warn "# left ",Dumper( $id_usage );
