package BlogVillain::Schema;
use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_components('Schema::Config');
__PACKAGE__->load_namespaces();

1;
