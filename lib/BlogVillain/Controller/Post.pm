package BlogVillain::Controller::Post;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use BlogVillain::Model::Post;
use Data::Dumper;
use feature qw/ say /;

# This action will render a template
sub post {
	my $self = shift;
	my $category = $self->stash('category');
	my $fulltitle = $self->stash('fulltitle');
	say $category;
	say $fulltitle;
	my $post = BlogVillain::Model::Post->new_post($category, $fulltitle);
	$post->make_idx_and_content;
	$self->stash( 
					content => join ( '', ( map { $_->as_HTML } @{ $post->{content} } ) ), 
					index => $post->{index}->as_HTML,
					title => $post->{title}
				);
	$self->render(template => 'post/post');
}

sub checksyntax {
	my $self = shift;
	my $post = BlogVillain::Post->new( { pod => $self->req->body } );
	$post->make_idx_and_content();
	if ( $post->validate() ) {
		$self->render( text => join ( '', ( map { $_->as_HTML } @{ $post->{content} } ) ) );
	} else {
		$self->render( json => $post->{ all_errata } );
	}
}

1;
