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

  $r->get('about')->to(template => 'about');

  
  
  $r->post('post/checksyntax')->to('post#check_syntax');

  $r->get('post/categories')->to('post#get_categories');
  $r->get('post/:category')->to('post#get_fulltitles');
  $r->get('post/write')->to(template=>'post/write');
  $r->get('post/:category/*fulltitle')->to('post#get');

}

1;
