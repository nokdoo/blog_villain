package BlogVillain::Controller::Authorization;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use feature qw/ say /;

use Authorization::OAuth;
use JSON;
use Crypt::JWT qw(encode_jwt);

# 따로 빼주자.
my $secret = 'temp';

sub login {
    my $self = shift;
    my $state_token = $self->param('state');
    if (!Authorization::OAuth->validate_state_token($state_token)) 
    {
        $self->redirect_to(
            '/error', 
            { message => qq/ state_toke is not validate / }
        );
    }

    my $code = $self->param('code');
    my $auth_tokens_str = 
            Authorization::OAuth->auth_tokens_str(
                $state_token, $code
            );
    my $auth_tokens = decode_json($auth_tokens_str);
    if ( defined $auth_tokens->{error} ) {
        $self->redirect_to(
            '/error', 
            { message => $auth_tokens->{error_description} }
        );
    }

    my $BVID = encode_jwt(
        payload=>$auth_tokens_str, 
        alg=>'HS256', 
        key=>$secret
        );
    $self->cookie( BVID => $BVID );

    $self->redirect_to('/');
}

sub auth_req_url {
    my $self = shift;
    my $service_provider = $self->req->param('service_provider');
    my $auth_req_url = 
        Authorization::OAuth->auth_req_url($service_provider);
    $self->render(text => $auth_req_url, status => 200) 
        if defined $auth_req_url;
    # 에러 페이지로 리다이렉트 추가.
}

1;
