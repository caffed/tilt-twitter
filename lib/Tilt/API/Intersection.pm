package Tilt::API::Intersection;
use Tilt::API::Twitter qw( tget );
use JSON;

use Exporter qw(import);
our @EXPORT_OK = qw( intersection );

# gets followers for a single user
sub followers {
  my ($screen_name, $cursor) = ($_[0], $_[1]);
  tget "followers/ids.json", { "screen_name" => $screen_name, "count" => 5000, "cursor" => $cursor }
}

# loop until $cursor == 0
# tried looping using next_cursor. always failed around 40-50k ids due to rate limits.
# sub get_all_followers {
#   my ($screen_name, $cursor) = ($_[0], $_[1]);
#   my @followers = ();
#   my $json = JSON->new->utf8->allow_nonref;
#
#   # only know about one point for the next request, so can't use threads
#   while ($cursor != 0){
#     my $resp = followers($screen_name, $cursor);
#     push @followers, values $resp->{ids};
#     $cursor = $resp->{next_cursor};
#   }
#
#   return \@followers;
# }

# exported sub
# entrypoint to calculate intersection
sub intersection {
  my ($user_one, $user_two) = ($_[0], $_[1]);
  my @intersect = ();

  my $list_one = followers($user_one, -1) ;
  my $list_two = followers($user_two, -1) ;

  foreach my $i (@{ $list_one->{ids} }) {
    if (grep { $_ =~ /^$i$/ } @{ $list_two->{ids} }) {
      push @intersect, $i;
    }
  }

  return \@intersect;
}

true;

