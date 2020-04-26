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
    $r->get('login')->to(template => 'login');

    $r->get('auth/login')->to('authorization#login');
    $r->get('auth/auth_req_url')->to('authorization#auth_req_url');

    $r->post('post/checksyntax')->to('post#check_syntax');

    $r->get('post/write')->to(template=>'post/write');
    $r->get('post/categories')->to('post#categories');
    $r->get('post/:category')->to('post#fulltitles');
    $r->get('post/:category/*fulltitle')->to('post#get');

    $r->get('test')->to('test#oauth');

}

1;
