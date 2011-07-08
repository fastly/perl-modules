use Test::More tests => 9;
use strict;
$^W = 1;

use_ok 'Email::Simple';

my @emails;

push @emails, Email::Simple->new(<<'__MESSAGE__');
From: casey@geeknest.com
To: drain@example.com
Subject: Message in a bottle
__MESSAGE__

push @emails, Email::Simple->new(<<'__MESSAGE__');
From: casey@geeknest.com
To: drain@example.com
Subject: Message in a bottle
subject: second subject!

HELP!
__MESSAGE__

for my $email (@emails) {
  for my $method ('header_names', 'headers') {
    can_ok($email, $method);
    is_deeply(
      [ qw(From To Subject) ],
      [ $email->$method()   ],
      "have expected headers (via $method)"
    );
  }
}
