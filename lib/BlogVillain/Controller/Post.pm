package BlogVillain::Controller::Post;
use Mojo::Base 'Mojolicious::Controller';
use BlogVillain::Mojo::Post;

# This action will render a template
sub post {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(template => 'post');
}

1;
