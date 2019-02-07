#!/usr/bin/env perl

use warnings;
use strict;
use lib './';
use BlogVillain::Schema;
use Data::Dumper;

my $drivername = 'Pg';
my $database = 'blog_villain';
my $hostname = '127.0.0.1';
my $port = '5432';
my $dsn = "DBI:$drivername:dbname=$database;host=$hostname;port=$port";
my $user = 'blog_villain';
my $password = '1353';

my $schema = BlogVillain::Schema->connect(
  $dsn,
  $user,
  $password,
);
print Dumper($schema);

# 값이 1일 때 적용됨
#$schema->deploy( { add_drop_table => 1 } );

