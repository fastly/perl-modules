
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Version::Requirements',
                       'DISTNAME' => 'Version-Requirements',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Ricardo Signes <rjbs@cpan.org>',
                       'BUILD_REQUIRES' => {
                                             'Test::More' => '0.88'
                                           },
                       'ABSTRACT' => 'a set of version requirements for a CPAN dist',
                       'EXE_FILES' => [],
                       'VERSION' => '0.101020',
                       'PREREQ_PM' => {
                                        'Scalar::Util' => '0',
                                        'version' => '0.77',
                                        'Carp' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{BUILD_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.56) };

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



