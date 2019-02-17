#!/usr/bin/env perl

use strict;
use warnings;
use lib '../lib';

use Data::Dumper;
use Test::More;
use File::Find;
use Cwd;
use BlogVillain::Schema;
use POSIX qw ( strftime );

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');

my $dir = '../public/pod/';

find(\&printfile, $dir);

sub printfile
{
	if( -f $_ && $_ =~ /.*\.pod$/)
	{
		my $file = $File::Find::name;
		$file =~ /.*\/(pod\/.*).pod/;
		my $title = $1;
		
		return if $title eq 'pod/test';
		
		my $mtime = ((stat($_))[9]);
		my $time = strftime("%Y-%m-%dT%H:%M:%S", localtime($mtime));
		my $content = readpod ( $_ );
		print $content."\n\n";

		$schema->resultset('Post')->create({
			title => $title,
			content => $content,
			time => $time,
		}) or die ;


	}
}

sub readpod
{
	my $file = shift;
	local $/ = undef;
	open(my $pod, '<', $file) or die "Could not open file '$file'";
	my $a = <$pod>;
	close $pod;
	$a;
}

