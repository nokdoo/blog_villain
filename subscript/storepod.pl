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

my $dir = '../public/post/';

find(\&printfile, $dir);

sub printfile
{
	if( -f $_ && $_ =~ /.*\.pod$/)
	{
		my $file = $File::Find::name;
		my $path_regex = qr |.*/post/(.*).pod|;
		$file =~ $path_regex;
		my $fullname = $1;
		
		return if $fullname eq 'test';
		
		my $mtime = ((stat($_))[9]);
		my $time = strftime("%Y-%m-%dT%H:%M:%S", localtime($mtime));
		my $pod = readpod ( $_ );
		$_ =~ s/.pod//;
		my $name = $_;

		$schema->resultset('Post')->create({
			name => $name,
			fullname => $fullname,
			pod => $pod,
			time => $time,
		}) or die ;


	}
}

sub readpod
{
	my $file = shift;
	local $/ = undef;
	open(my $pod, '<:encoding(utf8)', $file) or die "Could not open file '$file'";
	my $a = <$pod>;
	close $pod;
	$a;
}
