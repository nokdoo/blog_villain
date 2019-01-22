#!/usr/bin/env perl

use warnings;
use strict;
use lib './';
use Schema;
use Data::Dumper;

my $drivername = 'Pg';
my $database = 'blog_villain';
my $hostname = '127.0.0.1';
my $port = '5432';
my $dsn = "DBI:$drivername:dbname=$database;host=$hostname;port=$port";
my $user = 'blog_villain';
my $password = '1353';

my $schema = Schema->connect(
  $dsn,
  $user,
  $password,
);

$schema->deploy( { add_drop_table => 0 } );
