package Authorization::OAuth;

use strict;
use warnings;

use Data::Dumper;
use feature qw/ say /;

use Session::Token;
use URL::Encode qw/ url_encode_utf8 /;
use HTTP::Tiny;
use JSON;

our $storage_of_st = {};
our $client_id = 'B4eKBlrEYU5z25BKMXEH';
our $client_secret = 'iVKGOkClmj';

my %auth_url = (
        naver => "https://nid.naver.com/oauth2.0/authorize?",
        );

my %token_url = (
        naver => "https://nid.naver.com/oauth2.0/token?",
        );

sub _state_token {
    my $service_provider = shift;
    my $state_token = Session::Token->new->get;
    $storage_of_st->{$state_token} = $service_provider;
    return $state_token;
}

sub auth_req_url {
    my ($c, $service_provider) = @_;
    my $redirect_uri = url_encode_utf8('http://www.blogvillain.com:3000/auth/login');
    my $state_token = _state_token($service_provider);
    my $auth_req_url = 
        $auth_url{$service_provider}
        ."client_id=$client_id&"
        ."response_type=code&"
        ."redirect_uri=$redirect_uri&"
        ."state=$state_token";
    return $auth_req_url;
}

sub validate_state_token {
    my ($c, $state_token) = @_;
    return defined $storage_of_st->{$state_token};
}

sub auth_tokens_str {
    my ($c, $state_token, $code) = @_;
    my $service_provider = $storage_of_st->{$state_token};
    my $auth_tokens_url = 
        $token_url{$service_provider}
        ."client_id=$client_id&"
        ."client_secret=$client_secret&"
        ."grant_type=authorization_code&"
        ."state=$state_token&"
        ."code=$code";
    my $auth_tokens_str = _request_json($auth_tokens_url); 
    return $auth_tokens_str;
}

sub _request_json {
    my $url = shift;
    my $ua = HTTP::Tiny->new();
    my $response = $ua->get($url);
    return $response->{content};
}

1;
