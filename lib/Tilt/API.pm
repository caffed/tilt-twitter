package Tilt::API;
use Dancer ':syntax';
use Tilt::API::Tweets qw(tweets);
use Tilt::API::Intersection qw(intersection);
our $VERSION = '0.0.1';

set serializer => 'JSON';

# Route definitions for API endpoints
prefix '/api/v1' => sub {
  get '/:user/tweets.json' => sub {
    return  {
              "user"   => param("user"),
              "tweets" => tweets param("user")
            };
  };

  get '/users/intersection.json' => sub {
    return { "intersection" => intersection(params->{user_one}, params->{user_two}) };
  };
};

true;
