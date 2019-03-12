package BlogVillain::Controller::Post;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use BlogVillain::Model::Post;
use Data::Dumper;

# This action will render a template
sub post {
	my $self = shift;
	my $path = $self->stash('path');
	my $post = BlogVillain::Model::Post->new_post($path);
	$post->make_idx_and_content();
	$self->stash ( 
				content_of_post => join ('', (map { $_->as_HTML } @{$post->{content}})), 
				index_of_post => $post->{index}->as_HTML,
				title => $post->{title}
	);
	print Dumper($self->stash);
	$self->render(template => 'post');
}

1;
