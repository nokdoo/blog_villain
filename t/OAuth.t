use Mojolicious::Lite;
 
plugin "OAuth2" => {
  facebook => {
    key    => "some-public-app-id",
    secret => $ENV{OAUTH2_FACEBOOK_SECRET},
  },
};
 
get "/connect" => sub {
  my $c = shift;
  my $get_token_args = {redirect_uri => $c->url_for("connect")->userinfo(undef)->to_abs};
 
  $c->oauth2->get_token_p(facebook => $get_token_args)->then(sub {
    return unless my $provider_res = shift; # Redirct to Facebook
    $c->session(token => $provider_res->{access_token});
    $c->redirect_to("profile");
  })->catch(sub {
    $c->render("connect", error => shift);
  });
};
