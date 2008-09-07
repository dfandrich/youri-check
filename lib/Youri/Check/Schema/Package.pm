# $Id$
package Youri::Check::Schema::Package;

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('packages');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1,
    },
    name => {
        data_type         => 'varchar',
        is_auto_increment => 0,
    },
    version => {
        data_type         => 'varchar',
        is_auto_increment => 0,
    },
    release => {
        data_type         => 'varchar',
        is_auto_increment => 0,
    },
    section => {
        data_type         => 'varchar',
        is_auto_increment => 0,
    },
    maintainer => {
        data_type         => 'varchar',
        is_auto_increment => 0,
    }
);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many(
    'files' => 'Youri::Check::Schema::PackageFile', 'package_id'
);

1;
