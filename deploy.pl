#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use YAML::Tiny;
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($DEBUG);
use List::Util 'first';

my $dbic_file = "$ENV{HOME}/.dbic.yaml";
INFO "========        Start setting $dbic_file";
my $yaml_string = `perl ./printdbic.pl`;

if ( -e $dbic_file ) {
	INFO "$dbic_file does exist";
	my $name = "BLOGVILLAIN_DATABASE";
	my $home_yaml_string = YAML::Tiny->read($dbic_file);
	my $yaml = YAML::Tiny->read_string($yaml_string);
	my $property_of_db = $yaml->[0];

	INFO "Find $name property already exists";
	my $found = 0;
	for ( @{$home_yaml_string} ) {
		if ( exists ${$_}{$name} ) {
			INFO "Replace found $name property with new $name property";
			$_ = $property_of_db;
			$found = 1;
			last;
		}
	}
	if ( !$found ) { 
		INFO "Not found";
		INFO "Add new $name property to $dbic_file";
		push @{$home_yaml_string}, $property_of_db;
	}
	
	$home_yaml_string->write($dbic_file);
	INFO "ok\n";
} else {
	INFO "$dbic_file does not exist";
	INFO "write new $dbic_file";	
	open (my $new_dbic_file, ">", $dbic_file) or die "Can't open $dbic_file";
	print $new_dbic_file, $yaml_string;
	close $new_dbic_file;
	INFO "ok";
}

INFO "========        End setting $dbic_file";
