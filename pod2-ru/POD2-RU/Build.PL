use strict;
use Module::Build;

#created by eumm-migrate.pl

my $build = Module::Build->new(
    'dist_abstract' => 'Russian Perl documentation',
    'auto_configure_requires' => 0,
    'license'                 => 'perl',
    'dist_author' => 'Russian Perl Team, Moscow-pm',
    'module_name' => 'POD2::RU',
    'requires'    => {
        'Test::More'       => 0,
        'Pod::Perldoc'     => '3.15',
        'POD2::Base'       => '0.043',
        'Test::More::UTF8' => '0.04'
    },
    'dist_version_from' => 'lib/POD2/RU.pm',
    'dist'              => { TAR => 'ptar', TARFLAGS => '-c -C -f', },
);

$build->create_build_script();
