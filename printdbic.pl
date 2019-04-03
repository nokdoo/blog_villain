#!/usr/bin/env perl

use strict;
use warnings;
use lib './';
use Term::ANSIColor;
use Data::Dumper;

my $driver = "DBI:SQLite:dbname=$ENV{BLOGVILLAIN_HOME}/db/blog_villain.db;";
my $host = "";
my $port = "";


$YAML::Indent = 4;
use YAML qw(Dump Bless);
my $hash = {
	BLOGVILLAIN_DATABASE => {
		dsn => "$driver$host$port", 
		user => 'blog_villain', 
		password => '1353',
		dbd_opts => {
			AutoCommit => 1
		}
	}
};
print Dump $hash;
