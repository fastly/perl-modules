#!/usr/bin/perl

use strict;
use warnings;

my $module = shift;

my $output = `cpanm -L /tmp/foo/ --scandeps $module`;

for my $item (split(/\s+/, $output)) {
    next if $item =~/\\_/;
    $item =~s/\s*[\_]+\s//;
    my ($dir) = $item =~/(.*)-(.*?)/;
    unless (-d $dir) {
	system("mkdir $dir");
	system("git add $dir");
    }
    next if -d "$dir/$item";
    print "Installing $dir - $item\n";
    chdir($dir);
    system("tar zxvf ~/.cpanm/latest-build/${item}.tar.gz");
    system("git add $item");
    chdir("..");
    system("git commit -m 'added module $item' $dir");
}


