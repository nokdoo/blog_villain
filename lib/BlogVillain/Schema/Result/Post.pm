package BlogVillain::Schema::Result::Post;
use strict;
use warnings;

use base qw/ DBIx::Class::Core /;

__PACKAGE__->table('post');
__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->position_column('path');
__PACKAGE__->add_columns(
						number => 
							{
								data_type => 'integer',
								is_auto_increment => 1,
							},
						title => 
							{
								data_type => 'varchar',
								size => 50,
								is_nullable => 0,
							},
						path =>
							{
								data_type => 'varchar',
								size => 100,
								is_nullable => 0,
							},
						pod =>
							{
								data_type => 'text',
								is_nullable => 0,
							},
						time =>
							{
								data_type => 'timestamp',
							},
						);
__PACKAGE__->set_primary_key(qw/ number /);
__PACKAGE__->add_unique_constraints( post_ukey_path => ['path'] );

sub sqlt_deploy_hook {
   my ($self, $sqlt_table) = @_;
   #$sqlt_table->add_index(name=>'post_title_idx', fields=>['path']);
}
1;
