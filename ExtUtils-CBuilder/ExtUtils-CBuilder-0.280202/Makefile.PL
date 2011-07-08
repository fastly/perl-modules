
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Compile and link C code for Perl modules',
  'AUTHOR' => 'Ken Williams <kwilliams@cpan.org>, The Perl 5 Porters',
  'BUILD_REQUIRES' => {
    'Test::More' => '0.47'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'ExtUtils-CBuilder',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'ExtUtils::CBuilder',
  'PREREQ_PM' => {
    'Cwd' => '0',
    'File::Basename' => '0',
    'File::Spec' => '3.13',
    'File::Temp' => '0',
    'IO::File' => '0',
    'IPC::Cmd' => '0',
    'Text::ParseWords' => '0'
  },
  'VERSION' => '0.280202',
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

$WriteMakefileArgs{INSTALLDIRS} = 'perl'
    if $] >= 5.009005 && $] <= 5.011000;

WriteMakefile(%WriteMakefileArgs);



