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
	$p->parse_string_document($self->{content});
	#$self->{html} = $html;
	
	my $root = HTML::TreeBuilder->new_from_content($html);
	$self->{html} = $root->{_body}->as_HTML;
	#my $html2 = Mojo::DOM::HTML->new;
	#$self->{html} = $html2->parse($root->{_body}->as_HTML);


}

sub makehtml2 {
	my $self = shift;

}


1;
