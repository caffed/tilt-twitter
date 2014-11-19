package Tilt::Twitter;
use Dancer ':syntax';

our $VERSION = '0.0.1';

# Route definitions for client facing app
# AngularJS app defined in templates
get '/' => sub {
  template 'index';
};

true;
