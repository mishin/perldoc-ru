#!/usr/bin/perl
#
#
#  Configure basic git settings
#

use Modern::Perl;
use IO::Prompt::Tiny qw( prompt );
use File::HomeDir;
use File::Spec::Functions qw(catdir catfile);

say "Configuration for global work using git";

# print 'Please write your Github user name: ';
my $user = prompt( 'Please write your Github user name:', getlogin() );
chomp $user;
# say $user;

# my $user = readline;


my $email = prompt( 'Please write your Github email address:', '' );
chomp $email;
# say $email;
my $home = home();
# my $home     = File::HomeDir->my_home;
 # my $work_path = File::HomeDir->my_documents;
# say $home;

# print 'Please write your Github email address: ';
# my $email = readline;
# 

system('git', 'config', '--global', 'user.name',	$user		);
system('git', 'config', '--global', 'user.email',	$email		);
system('git', 'config', '--global', 'push.default',	'tracking'	);
system('git', 'config', '--global', 'pack.threads',	0		);
system('git', 'config', '--global', 'core.autocrlf',	'false'		);
system('git', 'config', '--global', 'apply.whitespace',	'nowarn'	);
system('git', 'config', '--global', 'color.ui',		'auto'		);
system('git', 'config', '--global', 'core.excludesfile',catfile($home,'.gitignore'));
system('git', 'config', '--global', 'alias.up',		'pull --rebase'	);
