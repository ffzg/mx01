#!/usr/bin/perl
use warnings;
use strict;
use autodie;

#my ($command,$file) = @ARGV;
my $file = pop @ARGV;
my $cmd = $ARGV[0];
my $command = join(' ', @ARGV);

die "usage: $0 /bin/cat [optional arguments] /var/log/mail.log" unless -x $cmd && -r $file;

open(my $fh, '<', $file);
my $tell = $command . $file;
$tell =~ s/\W//g;
$tell = "/dev/shm/tell.$tell";
if ( -e $tell && ! $ENV{DEBUG} ) {
	open(my $fh_tell, '<', $tell);
	my $pos = <$fh_tell>;
	if ( $pos < -s $file ) {
		eval {
			#warn "# $file seek $pos\n";
			seek($fh, $pos, 0);
		}
	} else {
		#warn "# $file from beginning";
	}
}

open(my $fh_command, '|-', $command);
while(<$fh>) {
	print $fh_command $_;
}

open(my $fh_tell, '>', $tell);
print $fh_tell tell($fh);
close($fh_tell);

