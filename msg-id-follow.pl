#!/usr/bin/perl
use warnings;
use strict;

# if we don't have pipe or arguments
if ( -t STDIN and not @ARGV ) {
	push @ARGV, '/var/log/mail.log';
}

open(my $ids_fh, '<', '/dev/shm/msg.ids') || die "/dev/shm/msg.ids: $!";
my @ids = map { s/[\r\n]$//; $_ } <$ids_fh>;
close($ids_fh);

my $id_regex = join('|', @ids);

warn "# got ", scalar(@ids), " message ids $id_regex\n";

while(<>) {
	chomp;
	if ( m/: ($id_regex):/ ) {
		print "$_\n";
		if ( m/queued as ([0-9A-F]+)/ ) {
			$id_regex .= '|' . $1;
			#warn "## ++ id_regex: $id_regex\n";
		}
		if ( m/: ([0-9A-F]+): removed/ ) {
			$id_regex =~ s/$1\|//;
			#warn "## -- id_regex: $id_regex\n";
		}
	}
}
