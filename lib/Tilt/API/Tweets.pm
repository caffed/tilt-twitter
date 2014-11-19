package Tilt::API::Tweets;
use Tilt::API::Twitter qw( tget );
use JSON;

use Exporter qw(import);
our @EXPORT_OK = qw( tweets );

# This is the API logic to retrieve the latest tweets for one user
sub tweets {
  my $user = $_[0];
  tget "statuses/user_timeline.json", { "screen_name" => $user };
}

true;
