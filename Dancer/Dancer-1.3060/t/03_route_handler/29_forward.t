use strict;
use warnings;
use Test::More tests => 16, import => ['!pass'];

use Dancer ':syntax';
use Dancer::Logger;
use File::Temp qw/tempdir/;
use Dancer::Test;

my $dir = tempdir(CLEANUP => 1, TMPDIR => 1);
set appdir => $dir;
Dancer::Logger->init('File');

get '/'        => sub { 
    'home:' . join(',', params);
};
get '/bounce/' => sub {
    return forward '/';
};
get '/bounce/:withparams/' => sub {
    return forward '/';
};
get '/bounce2/adding_params/' => sub {
    return forward '/', { withparams => 'foo' };
};
post '/simple_post_route/' => sub {
    'post:' . join(',', params);
};
get '/go_to_post/' => sub {
    return forward '/simple_post_route/', { foo => 'bar' }, { method => 'post' };
};

response_status_is  [ GET => '/' ] => 200;
response_content_is [ GET => '/' ] => 'home:';

response_status_is  [ GET => '/bounce/' ] => 200;
response_content_is [ GET => '/bounce/' ] => 'home:';

response_status_is  [ GET => '/bounce/thesethings/' ] => 200;
response_content_is [ GET => '/bounce/thesethings/' ] => 'home:withparams,thesethings';

response_status_is  [ GET => '/bounce2/adding_params/' ] => 200;
response_content_is [ GET => '/bounce2/adding_params/' ] => 'home:withparams,foo';

response_status_is  [ GET => '/go_to_post/' ] => 200;
response_content_is [ GET => '/go_to_post/' ] => 'post:foo,bar';

my $expected_headers = [
    'Content-Length' => 5,
    'Content-Type' => 'text/html',
    'X-Powered-By' => "Perl Dancer ${Dancer::VERSION}",
];

response_headers_are_deeply [ GET => '/bounce/' ], $expected_headers;

# checking post

post '/'        => sub { 'post-home'  };
post '/bounce/' => sub { forward('/') };

response_status_is  [ POST => '/' ] => 200;
response_content_is [ POST => '/' ] => 'post-home';

response_status_is  [ POST => '/bounce/' ] => 200;
response_content_is [ POST => '/bounce/' ] => 'post-home';

$expected_headers->[1] = 9;
response_headers_are_deeply [ POST => '/bounce/' ], $expected_headers;

Dancer::Logger::logger->{fh}->close;
File::Temp::cleanup();

