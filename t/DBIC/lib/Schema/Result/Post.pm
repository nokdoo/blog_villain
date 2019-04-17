package Schema::Result::Post;
use strict;
use warnings;
use Data::Dumper;

use base qw/ DBIx::Class::Core /;

__PACKAGE__->table('post');
# __PACKAGE__->load_components(qw/ Ordered /);
# __PACKAGE__->position_column('fulltitle');
__PACKAGE__->add_columns(
						number => 
							{
								data_type => 'integer',
								is_auto_increment => 1,
							},
						title => 
							{
								data_type => 'varchar',
								size => 20,
								is_nullable => 0,
							},
						category =>
							{
								data_type => 'varchar',
								size => 10,
								is_nullable => 0,
							},
						fulltitle =>
							{
								data_type => 'varchar',
								size => 60,
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
__PACKAGE__->add_unique_constraints( post_ukey_fulltitle => ['fulltitle'] );
__PACKAGE__->belongs_to(
						'category' => 
							'Schema::Result::Category', 
							{ 'foreign.category' => 'self.category' } 
					   );

sub sqlt_deploy_hook {
	my ($self, $sqlt_table) = @_;
  	$sqlt_table->add_index(name=>'post_idx_fulltitle', fields=>['fulltitle']);
  	$sqlt_table->add_index(name=>'post_idx_category', fields=>['category']);
	
	my $sqlt_schema = $sqlt_table->schema;
	$sqlt_schema->add_trigger(
								name =>
									'post_trig_insert_new_category',
								perform_action_when =>
									'BEFORE',
								database_events =>
									[qw/ INSERT /],
								fields =>
									'category',
								on_table =>
									'post',
								action =>
									q [
										BEGIN
											INSERT OR IGNORE INTO category VALUES (new.category);
										END
									],
							 );

	$sqlt_schema->add_trigger(
								name =>
									'post_trig_modify_category',
								perform_action_when =>
									'AFTER',
								database_events =>
									[qw/ UPDATE DELETE /],
								fields =>
									'category',
								on_table =>
									'post',
								action =>
									q [
										BEGIN
											DELETE FROM category
											WHERE category = old.category
											AND NOT EXISTS ( SELECT category FROM post WHERE category = old.category );
										END
									],
							 );
}

1;
