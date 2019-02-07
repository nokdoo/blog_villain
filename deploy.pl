#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use YAML::Tiny;
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($DEBUG);


INFO "==========     dbi     ==========";
my $etc_dbic = '/etc/dbic.yaml';
my $dbic = './dbic.yaml';
if ( -e $etc_dbic )
{
	INFO "dbi.yaml does exist";
	my $etc_yaml = YAML::Tiny->read($etc_dbic);
	my $yaml = YAML::Tiny->read($dbic);
	my $database = $yaml->[0]->{BLOGVILLAIN_DATABASE};
	$etc_yaml->[0]->{BLOGVILLAIN_DATABASE} = $database;
	$yaml->write($etc_dbic);
	INFO "ok\n";
}
else
{
	INFO "copy $dbic to $etc_dbic";	
	`cp $dbic $etc_dbic`;
	INFO "ok";
}
