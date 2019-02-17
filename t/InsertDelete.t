#!/usr/bin/env perl

use strict;
use warnings;
use lib '../lib';

use Data::Dumper;
use Test::More;
use BlogVillain::Schema;
use DateTime;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');
my $datetime = DateTime->now;

my $post_ma = $schema->resultset('Post')->create({
	title => '1',
	content => '1',
	time => $datetime,
}) or die ;
# print $post_ma->{_column_data}->{title}."\n";
#$post_ma->delete or die;

done_testing();
