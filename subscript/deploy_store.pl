#!/usr/bin/env perl

use strict;
use warnings;

system "perl ./deploy_schema.pl";
system "perl ./storepod.pl";
