package BlogVillain::Controller::Test;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use feature qw/ say /;

# This action will render a template

sub oauth {
    my $self = shift;
    say Dumper($self->app->ua);
}

1;
