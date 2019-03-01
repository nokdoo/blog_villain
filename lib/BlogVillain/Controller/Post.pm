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
	$post->makehtml();
	print Dumper($post->{html});
	$self->stash( body => $post->{html} );
	$self->render(template => 'post');
}

1;
