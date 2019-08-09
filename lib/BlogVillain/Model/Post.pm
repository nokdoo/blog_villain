package BlogVillain::Model::Post;

use strict;
use warnings;
use Pod::Simple::HTML;
use BlogVillain::Schema;
use BlogVillain::Post;
use Data::Dumper;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');

sub search_categories {
	my $class = shift;
	my @rs = $schema->resultset('Category')->search( 
        undef, 
        { order_by => 'category' } 
    );
	my @categories = map { $_->get_column('category') } @rs; 	
	return \@categories;
}

sub search_fulltitles_of {
	my ($class, $category) = @_;
	my @posts = $schema->resultset('Post')->search(
		{ 'category.category' => $category },
		{ join => 'category' }
	);
    my @fulltitles = sort { $a cmp $b } 
                     map { $_->get_column('fulltitle') } @posts;
	return \@fulltitles;
}

sub find {
	my ($class, $category, $fulltitle) = @_;
	my $post = $schema->resultset('Post')->find(
		{
            category => $category,
    		fulltitle => $fulltitle,
        }
	) or die "Error: on [Model::Post]\t$fulltitle\n";
	return BlogVillain::Post->new( { $post->get_columns } );
}

1;
