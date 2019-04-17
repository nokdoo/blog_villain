package BlogVillain::Schema::Result::Category;
use strict;
use warnings;

use base qw/ DBIx::Class::Core /;

__PACKAGE__->table('category');
__PACKAGE__->add_columns(
						category =>
							{
								data_type => 'varchar',
								size => 10,
								is_nullable => 0,
							},
						);
__PACKAGE__->set_primary_key(qw/ category /);

__PACKAGE__->has_many(
						posts =>
							'BlogVillain::Schema::Result::Post',
							{ 'foreign.category' => 'self.category' }
			         );

1;
