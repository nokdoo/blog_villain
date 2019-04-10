#!/usr/bin/env perl

use warnings;
use strict;
use lib "$ENV{BLOGVILLAIN_HOME}/lib";
use BlogVillain::Schema;
use Data::Dumper;


my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');

# print Dumper($schema);

# 값이 1일 때 적용됨
$schema->deploy( { add_drop_table => 1 } );
