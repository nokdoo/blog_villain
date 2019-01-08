package BlogVillain::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => '<p>
  This page was generated from the template "templates/example/welcome.html.ep"
  and the layout "templates/layouts/default.html.ep",
</p>');
}

1;
