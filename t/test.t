#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('BlogVillain');

# HTML/XML
# $t->get_ok('/')->status_is(200)->text_is('div#message' => 'Hello!');

$t->get_ok('/post/Perl/Example/pipe-fork')->status_is(200)->text_is('div#perl' => 'Hello!');


done_testing();
