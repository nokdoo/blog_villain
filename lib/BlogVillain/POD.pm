package BlogVillain::POD;

use strict;
use warnings;
use BlogVillain::Schema;
use HTML::TreeBuilder;
use Data::Dumper;

my $schema = BlogVillain::Schema->connect('BLOGVILLAIN_DATABASE');

sub new {
	my ($class, $title) = @_;
	my $self;
	my $post_row = $schema->resultset('Post')->find({
                    title => $title,
	});
	bless $self, $class;
}

sub htmlbody {
	my $self = shift;
	# croak "not object of BlogVillain::POD" 
    #  unless ref($self) eq 'BlogVillain::POD';

	pod2html($self->{content});
	my $html = HTML::TreeBuilder->new_from_content(
                $self->{content});

	return $html;
}

sub pod2html {
	my $pod = shift;
}

1;
