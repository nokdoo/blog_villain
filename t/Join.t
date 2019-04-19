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

my @categories = $schema->resultset('Category')->search();
my %collections;
for (@categories) {
	my $category = $_->get_column('category');
	my @posts = $schema->resultset('Post')->search(
		{ 'category.category' => $category },
		{ join => 'category' }
	);
	my @fulltitles = map { $_->get_column('fulltitle') } @posts ;
	$collections{$category} = \@fulltitles;
}

print Dumper(%collections);

done_testing();
