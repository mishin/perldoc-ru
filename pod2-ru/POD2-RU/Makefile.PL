use strict;
use warnings;
use ExtUtils::MakeMaker;

my $meta_merge = {
    META_MERGE => {
        resources => {
            repository  => 
                'https://github.com/mishin/perldoc-ru.git',
        },
    }
};

WriteMakefile(
    NAME              => 'POD2::RU',
    AUTHOR            => q{Команда Perl по-русски, Moscow-pm},
    VERSION_FROM      => 'lib/POD2/RU.pm',
    ABSTRACT          => 'Документация Perl по-русски',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'POD2::Base' => 0.043,
        'Pod::Perldoc' => 3.15,
	'Test::More::UTF8' => 0.04,
    },    
    clean               => { FILES => 'POD2-RU-*' },
);
