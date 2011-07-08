
use strict;
use warnings;

BEGIN { require 5.006; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'the distribution metadata for a CPAN dist',
  'AUTHOR' => 'David Golden <dagolden@cpan.org>, Ricardo Signes <rjbs@cpan.org>',
  'BUILD_REQUIRES' => {
    'Data::Dumper' => '0',
    'File::Spec' => '0',
    'File::Temp' => '0.20',
    'IO::Dir' => '0',
    'Test::More' => '0.96'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'CPAN-Meta',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'CPAN::Meta',
  'PREREQ_PM' => {
    'CPAN::Meta::YAML' => '0.002',
    'Carp' => '0',
    'JSON::PP' => '2.27103',
    'Parse::CPAN::Meta' => '1.4400',
    'Scalar::Util' => '0',
    'Version::Requirements' => '0.101020',
    'version' => '0.82'
  },
  'VERSION' => '2.110930',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



