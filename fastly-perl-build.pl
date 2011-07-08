#!/usr/bin/perl

use strict;
use warnings;




my $dist = shift;
my $version = shift;


build("$dist/$dist-$version.tar.gz");

sub build {
    my $filename = shift;
    open(my $i, "$filename.build") || die;

    while(<$i>) {
	chomp;
	build($_);
    }
    
    print "building $filename\n";
    system("cpanm -L /tmp/build-$$/ $filename");
    close($i);
}

