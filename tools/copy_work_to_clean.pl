use v5.12;
use autodie;
use File::Copy;
use File::Spec::Functions qw(catdir catfile);
 copy( 
 "c:/Users/ira/Documents/GitHub/perldoc-ru/pod2-ru/tm/mishin.tmx", "c:/Users/ira/Documents/GitHub/perldoc-ru/memory/clean/omegat_clean-omegat.tmx" );
 
 
 #c:\Users\ira\Documents\GitHub\perldoc-ru\pod2-ru\tm\mishin.tmx 
 # dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
     # 'add_to_cleanup'          => 'POD2-RU-*',