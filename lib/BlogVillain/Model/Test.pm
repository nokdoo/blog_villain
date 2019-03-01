package BlogVillain::Model::Test;


use strict;
use warnings;
use Mojo::Home;
use Data::Dumper;


# Find and manage the project root directory
my $home = Mojo::Home->new;
$home->detect;
print Dumper($home);
