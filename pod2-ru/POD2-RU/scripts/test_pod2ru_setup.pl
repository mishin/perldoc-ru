#!/usr/bin/env perl
#
# Check POD2::RU setup
#
use utf8;
use Modern::Perl;
use POD2::RU;
use Encode::Locale qw(decode_argv);
if (-t) {
    binmode( STDIN,  ":encoding(console_in)" );
    binmode( STDOUT, ":encoding(console_out)" );
    binmode( STDERR, ":encoding(console_out)" );
}
Encode::Locale::decode_argv();
my $pod_ru = POD2::RU->new();

say 'Setup directories';
say "\t", join( "\n\t", $pod_ru->pod_dirs() ), "\n";

say 'Title of alphabetic list of Perl functions:';
my $text = $pod_ru->search_perlfunc_re();
say "\t$text\n";

say "List of translated pods:";
$pod_ru->print_pods();
say '';

say 'perlintro status:';
$pod_ru->print_pod('perlintro');
say '';

# http://xpoint.ru/forums/programming/perl/windows/thread/34816.xhtml