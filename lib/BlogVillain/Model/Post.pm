package BlogVillain::Model::Post;

use strict;
use warnings;
use Pod::Simple::HTML;
use BlogVillain::Schema;
use BlogVillain::Post;
use Data::Dumper;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');

sub new_post {
	my ($class, $title) = @_;
	my $post_result = $schema->resultset('Post')->find({
		title => $title
	}) or die ;
	return BlogVillain::Post->new($post_result->{_column_data});
}

1;
