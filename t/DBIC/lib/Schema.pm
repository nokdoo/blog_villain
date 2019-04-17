package Schema;
use base qw/ DBIx::Class::Schema /;
use Data::Dumper;

__PACKAGE__->load_components('Schema::Config');
__PACKAGE__->load_namespaces();

1;
