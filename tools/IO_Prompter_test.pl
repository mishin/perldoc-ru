use Modern::Perl;
use IO::Prompter;
 
# while (prompt -num, 'Enter a number') {
    # say "You entered: $_";
# }
 
my $passwd
    = prompt 'Enter your password', -echo=>'*';