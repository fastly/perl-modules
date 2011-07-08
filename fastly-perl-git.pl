#!/usr/bin/perl

use strict;
use warnings;

my $module = shift;

use JSON;

use Data::Dumper;


my $output = `cpanm -L /tmp/foo/ --scandeps $module --format json`;
#my $output = `cat test.json`;
my $data = from_json($output);

#print Dumper($data);

my $i = 0;
sub process {
    my $entry = shift;
    my $dist = shift @$entry;
    my $dep = shift @$entry;
    
    my $space = " " x $i;

    $i++;
    my @deps;
    foreach my $list (@$dep) {
	push @deps, "$list->[0]->{dist}/$list->[0]->{filename}";
	process($list);
    }
    $i--;
    next if -d "$dist->{dist}/$dist->{filename}";
    unless(-d $dist->{dist}) {
	system("mkdir $dist->{dist}");

    }
    system("cp $dist->{local_path} $dist->{dist}");
    open(my $foo, ">$dist->{dist}/$dist->{distvname}.build") || die "$dist->{dist}/$dist->{distvname}.build";
    print $foo join("\n", @deps);
    close($foo);
    system("git add $dist->{dist}");
    system("git commit -m 'imported module $dist->{filename}'");
    print "$space$dist->{module} => $dist->{filename} " . join(" ,", @deps) . "\n";
}

foreach my $list (@$data) {
   process($list);
    
}

print 
exit;
for my $item (split(/\s+/, $output)) {

    my ($author, $file) = split("/", $item);
    print "$author, $file\n";

    my ($dir) = $file =~/(.*)-(.*?)/;

    print "$dir -- $file-\n";
    unless (-d $dir) {
	system("mkdir $dir");
#	system("git add $dir");
    }
    next if -d "$dir/$item";
#    print "Installing $dir - $item\n";
    chdir($dir);
    system("cp ~/.cpanm/latest-build/${item}.tar.gz .");
#    system("git add $item");
    chdir("..");
#    system("git commit -m 'added module $item' $dir");
}


