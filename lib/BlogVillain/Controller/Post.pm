package BlogVillain::Controller::Post;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use BlogVillain::Model::Post;
use Data::Dumper;

# This action will render a template
sub get {
	my $self = shift;
	my $title = $self->stash('title');
	my $post = BlogVillain::Model::Post->new_post($title);
	$title =~ s!/!::!g;
	$post->make_idx_and_content();
	$self->stash ( 
				content_of_post => join ('', (map { $_->as_HTML } @{$post->{content}})), 
				index_of_post => $post->{index}->as_HTML,
				title => $title
	);
	$self->render(template => 'post');
}

1;
