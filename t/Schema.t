#!/usr/bin/env perl

use strict;
use warnings;
use lib '../lib';

use Data::Dumper;
use Test::More;
use BlogVillain::Schema;
use DateTime;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');

my $post_ma = $schema->resultset('Post')->create({
	title => '1',
	content => '1',
	time => DateTime->now,
});

done_testing();
