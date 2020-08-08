#!/usr/bin/env perl

use strict;
use warnings;
use lib './';
use Term::ANSIColor;
use Data::Dumper;
use Cwd qw(abs_path);

my $path = abs_path;
say "sqlite db root path: $path";
my $driver = "DBI:SQLite:dbname=$path/db/blog_villain.db;";
my $host = "";
my $port = "";


$YAML::Indent = 4;
use YAML qw(Dump Bless);
my $hash = {
	BLOGVILLAIN_DATABASE => {
		dsn => "$driver$host$port", 
		user => 'blog_villain', 
		dbd_opts => {
			AutoCommit => 1
		}
	}
};
print Dump $hash;
