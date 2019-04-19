#!/usr/bin/env perl

use strict;
use warnings;
use lib "$ENV{BLOGVILLAIN_HOME}/lib";

use Data::Dumper;
use Test::More;
use BlogVillain::Schema;
use DateTime;
use Encode;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');
my @arr = map { $_->get_column('category') } $schema->resultset('Category')->search();
# print Dumper($schema->resultset('Category')->search());
print Dumper(\@arr);


done_testing();
