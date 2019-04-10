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
my $datetime = DateTime->now;

my @all_posts = $schema->resultset('Post')->search(undef,
	{
		select => [ 
					'fulltitle', 
					\"substr(fulltitle, 1, instr(fulltitle, '/')-1)"
					#{ SUBSTR =>	[ 'fulltitle', 1, { INSTR => ['fulltitle', "'/'"],  } ], 
					#	 -as => 'before_slash' } 
				  ],
		as => [ qw / fulltitle ti / ]
	}
)->all;
print Dumper (@all_posts);

done_testing();
