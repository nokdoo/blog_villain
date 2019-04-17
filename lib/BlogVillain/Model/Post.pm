package BlogVillain::Model::Post;

use strict;
use warnings;
use Pod::Simple::HTML;
use BlogVillain::Schema;
use BlogVillain::Post;
use Data::Dumper;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');

sub new_post {
	my ($class, $category, $fulltitle) = @_;
	my $post_result = $schema->resultset('Post')->find({
		category => $category,
		fulltitle => $fulltitle,
	}) or die "Error: on [Model::Post]\t$fulltitle\n";
	return BlogVillain::Post->new( { $post_result->get_columns } );
}

1;
