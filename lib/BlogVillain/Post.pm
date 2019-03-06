package BlogVillain::Post;

use strict;
use warnings;
use Data::Dumper;
use Pod::Simple::HTML;
use HTML::TreeBuilder;
use Mojo::DOM::HTML;

sub new {
	my ($class, $self) = @_;
	bless $self, $class;
}

sub validate {
	my ($self) = @_;
}

sub makehtml {
	my $self = shift;
	$Pod::Simple::HTML::Computerese =  ' class="some_class_name"'; # 동작안함...흠...
	my $p = Pod::Simple::HTML->new;
	$p->index(1);
	$p->output_string(\my $html);
	$p->parse_string_document($self->{pod});
	$self->{html} = HTML::TreeBuilder->new_from_content($html);
}

sub make_idx_and_content {
	my $self = shift;
	$self->makehtml unless defined $self->{content};
	$self->{index} = $self->{html}->look_down(_tag=>'div', class=>'indexgroup');
	$self->{index}->detach;
	$self->{content} = $self->{html}->look_down(_tag=>'body')->content;
}

1;
