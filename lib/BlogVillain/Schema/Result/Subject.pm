package BlogVillain::Schema::Result::Subject;
use strict;
use warnings;

use base qw/ DBIx::Class::Core /;

__PACKAGE__->table('subject');
__PACKAGE__->add_columns(
						subject => 
							{
								data_type => 'varchar',
								size => 20,
								is_nullable => 0,
							},
						);
__PACKAGE__->set_primary_key(qw/ subject /);

1;
