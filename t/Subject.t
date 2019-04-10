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

$schema->resultset('Subject')->create({
	subject => 'pod/perl/Set/Scalar',
}) or die ;

done_testing();
