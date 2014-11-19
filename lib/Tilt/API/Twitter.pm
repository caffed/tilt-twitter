package Tilt::API::Twitter;
use Dancer;
use URI::Encode;
use MIME::Base64;
use URI::Query;
use JSON;
use LWP;

use Exporter qw(import);
our @EXPORT_OK = qw( tget tpost );

# This module manages Twitter API authorization and calling endpoints
# https://dev.twitter.com/oauth/overview
# https://dev.twitter.com/oauth/application-only

# this takes the consumer key and secret to make the silly base64 hash
# 1. url encode consumer key and secret
# 2. concatenate with :
# 3. base64 encode
sub auth_basic_hash {
  my $uri = URI::Encode->new();
  encode_base64( $uri->encode(config->{twitter}{consumer_key}) . ":" .
                 $uri->encode(config->{twitter}{consumer_secret}) )
}


# POST https://api.twitter.com/oauth2/token
# HEADERS:
# Content-Type: application/x-www-form-urlencoded;charset=UTF-8
# Authorization: Basic gen_auth_hash
# BODY
# grant_type=client_credentials
#
# returns
# {
#    "token_type": "bearer",
#    "access_token": "AAAAAA...."
# }
sub authorize {
  my $ua = LWP::UserAgent->new;
  my $req = HTTP::Request->new(POST => config->{twitter}{uri} . "/oauth2/token");
  $req->header("Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8");
  $req->header("Authorization" => "Basic @{[ auth_basic_hash() ]}");
  $req->content("grant_type=client_credentials");

  my $resp = $ua->request($req);
  JSON->new->decode($resp->content);
}

# VERBS listed at https://dev.twitter.com/rest/public

# GET
sub tget {
  my ($path, $query) = ($_[0], $_[1]);
  my $ua = LWP::UserAgent->new;

  my $query_string = "";
  if (keys %$query > 0) {
    $query_string = "?" . URI::Query->new($query)->stringify("&");
  }

  my $req = HTTP::Request->new(GET => config->{twitter}{uri} . "/1.1/" . $path . $query_string );
  $req->header("Content-Type" => "application/json");
  $req->header("Authorization" => "Bearer @{[ authorize()->{access_token} ]}");

  my $resp = $ua->request($req);
  JSON->new->decode($resp->content);
}

# POST
sub tpost {
  my ($path, $body) = ($_[0], $_[1]);
  my $ua = LWP::UserAgent->new;

  my $req = HTTP::Request->new(POST => config->{twitter}{uri} . "/1.1/" . $path);
  $req->header("Content-Type" => "application/json");
  $req->header("Authorization" => "Bearer @{[ authorize()->{access_token} ]}");
  $req->content($body);

  my $resp = $ua->request($req);
  JSON->new->decode($resp->content);
}

true;
