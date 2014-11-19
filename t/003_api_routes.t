use Test::More tests => 3;
use strict;
use warnings;

# the order is important
use Tilt::Twitter;
use Tilt::API;
use Dancer::Test;

route_exists [GET => '/api/v1/:user/tweets.json'], 'a route handler is defined for /api/v1/:user/tweets.json';
response_status_is ['GET' => '/api/v1/:user/tweets.json'], 200, 'response status is 200 for /api/v1/:user/tweets.json';

route_exists [GET => '/api/v1/users/intersection.json'], 'a route handler is defined for /api/v1/users/intersection.json';
response_status_is ['GET' => '/api/v1/users/intersection.json'], 200, 'response status is 200 for /api/v1/users/intersection.json';
