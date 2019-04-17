#!/usr/bin/env perl

use warnings;
use strict;
use lib "$ENV{BLOGVILLAIN_HOME}/t/DBIC/lib";
use Schema;
use Data::Dumper;

my $schema = Schema->connect("dbi:SQLite:$ENV{BLOGVILLAIN_HOME}/t/DBIC/db/example.db");

$schema->deploy( { add_drop_table => 1 } );
