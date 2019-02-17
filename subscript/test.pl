#!/usr/bin/env perl

use strict;
use warnings;

open(my $file, '<' , '../public/pod/c/const.pod') or die;
$/ = undef;

my $a = <$file>;

print $a."\n";
