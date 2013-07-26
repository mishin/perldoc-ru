use Modern::Perl;
use IO::Prompt::Tiny qw( prompt );
my $input = prompt( 'Proceed? (y/n)', 'n' );
say $input;