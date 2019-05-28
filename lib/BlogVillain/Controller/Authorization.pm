package BlogVillain::Controller::Authorization;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use feature qw/ say /;

# This action will render a template

sub login {
    my $self = shift;
    say Dumper('asdasd');

}
1;
