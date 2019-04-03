#!/usr/bin/env perl

use strict;
use warnings;
use Term::ANSIColor;
use Data::Dumper;
use File::HomeDir;
use DBI;
use Cwd;
use FindBin;
use lib "$FindBin::Bin/./lib";
use Directory;

my $root = Directory->root;

print $root;
