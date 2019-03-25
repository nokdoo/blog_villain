package BlogVillain;
use Mojo::Base 'Mojolicious';
use Data::Dumper;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to(template => 'home');


  $r->post('/post/checksyntax')->to('post#checksyntax');
  $r->get('/post/write')->to(template=>'post/write');
  $r->get('/post/*fulltitle')->to('post#post');

}

1;
