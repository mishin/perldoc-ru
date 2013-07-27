#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'POD2::RU' ) || print "Bail out!\n";
}

diag( "Testing POD2::RU $POD2::RU::VERSION, Perl $], $^X" );
