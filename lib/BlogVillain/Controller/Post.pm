package BlogVillain::Controller::Post;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use BlogVillain::Model::Post;
use Data::Dumper;

# This action will render a template
sub post {
	my $self = shift;
	my $fulltitle = $self->stash('fulltitle');
	my $post = BlogVillain::Model::Post->new_post($fulltitle);
	$post->make_idx_and_content();
	$self->stash ( 
				content_of_post => join ( '', ( map { $_->as_HTML } @{$post->{content}} ) ), 
				index_of_post => $post->{index}->as_HTML,
				title_of_post => $post->{title}
	);
	$self->render(template => 'post/post');
}

sub checksyntax {
	my $self = shift;
	my $post = BlogVillain::Post->new({pod => $self->req->body});
	$post->make_idx_and_content();
	if ( $post->validate() ) {
		$self->render(text => join ('', (map { $_->as_HTML } @{$post->{content}})));
	} else {
		$self->render(json => $post->{all_errata});
	}
}

1;
