#!/usr/bin/env perl

use strict;
use warnings;
use lib $ENV{BLOGVILLAIN_HOME}."/lib";

use Data::Dumper;
use Test::More;
use BlogVillain::Schema;
use DateTime;
use Encode;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');
my $datetime = DateTime->now;

my $post_row = $schema->resultset('Post')->search or die ;
print Dumper($post_row);
#print $post_row->{_column_data}->{title};
#$post_ma->delete or die;

done_testing();
