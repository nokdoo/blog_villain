package BlogVillain::Controller::Post;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use BlogVillain::Model::Post;
use Data::Dumper;
use feature qw/ say /;

# This action will render a template
sub get_categories {
    my $self = shift;
    $self->stash(categories => BlogVillain::Model::Post->search_categories());
    $self->render(template => 'post/categories');
}

sub get_fulltitles {
    my $self = shift;
    my $category = $self->stash('category');
    $self->stash(fulltitles => BlogVillain::Model::Post->search_fulltitles_of($category));
    $self->render(template => 'post/category');
}

sub get {
    my $self      = shift;
    my $category  = $self->stash('category');
    my $fulltitle = $self->stash('fulltitle');
    my $post      = BlogVillain::Model::Post->find( $category, $fulltitle );
    $post->make_idx_and_content;
    
    my @content   = join q{}, map { $_->as_HTML } @{ $post->{content} };
    my $index     = $post->{index}->as_HTML if $post->{index};
    my $title     = $post->{title};
    $self->stash(
        content => @content,
        index   => $index,
        title   => $title,
    );
    
    $self->render( template => 'post/post' );
}

sub check_syntax {
    my $self = shift;
    my $pod  = { pod => $self->req->body };
    my $post = BlogVillain::Post->new($pod);
    $post->make_idx_and_content();

    if ( $post->validate() ) {
        my @content = join q{}, map { $_->as_HTML } @{ $post->{content} }; 
        $self->render(text => @content);
    }
    else {
        $self->render(json => $post->{all_errata});
    }
}

1;
