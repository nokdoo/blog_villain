package Directory;

use strict;
use warnings;

use Cwd;
use File::Basename;

sub root {
	my $dir = getcwd;
	return dirname($dir);
}

sub public {
	my $class = shift;
	my $root = $class->root;
	return $root."/public";
}

1;
