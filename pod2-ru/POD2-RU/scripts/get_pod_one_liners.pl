perl -Ilib -MIO::All -E"say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/lre[^fp]/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all"
C:\Perl64\lib\pods\perlreref.pod 408             +
C:\Perl64\lib\pods\perlrequick.pod 519           +
C:\Perl64\lib\pods\perlreapi.pod 706 0           -
C:\Perl64\lib\pods\perlrebackslash.pod 661 0 -
C:\Perl64\lib\pods\perlrecharclass.pod 850 0- 
C:\Perl64\lib\pods\perlreguts.pod 886 20/886     +/-
C:\Perl64\lib\pods\perlre.pod 2585 0 -
C:\Perl64\lib\pods\perlretut.pod 2928 512 17%    +-


perl -MIO::All -E'say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/lre[^f]/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all'
/usr/share/perl/5.18/pod/perlrepository.pod 18
/usr/share/perl/5.18/pod/perlreref.pod 408       +
/usr/share/perl/5.18/pod/perlrequick.pod 519     +
/usr/share/perl/5.18/pod/perlrebackslash.pod 664
/usr/share/perl/5.18/pod/perlreapi.pod 826
/usr/share/perl/5.18/pod/perlreguts.pod 928
/usr/share/perl/5.18/pod/perlrecharclass.pod 1081
/usr/share/perl/5.18/pod/perlre.pod 2614         +-
/usr/share/perl/5.18/pod/perlretut.pod 2928 512 17%   +-




perl -MIO::All -E"say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/lre[^f]/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all"

/usr/share/perl/5.18/pod/perlrepository.pod 18
/usr/share/perl/5.18/pod/perlreref.pod 408   +
/usr/share/perl/5.18/pod/perlrequick.pod 519 + 
/usr/share/perl/5.18/pod/perlreftut.pod 526
/usr/share/perl/5.18/pod/perlrebackslash.pod 664
/usr/share/perl/5.18/pod/perlref.pod 754
/usr/share/perl/5.18/pod/perlreapi.pod 826
/usr/share/perl/5.18/pod/perlreguts.pod 928
/usr/share/perl/5.18/pod/perlrecharclass.pod 1081
/usr/share/perl/5.18/pod/perlre.pod 2614
/usr/share/perl/5.18/pod/perlretut.pod 2928


my @lines = map {chomp; $_} $io->slurp;


perl -MIO::All -E "$p{$_->name}=map{$l++}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

perl -MIO::All -E "$p{$_->name}=map{chomp}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

perl -I"c:\Users\TOSH\Documents\GitHub\io-all-mishin\lib" -MIO::All -e "printf qq{%s %s\n},$_->name,$_->rows for sort {$a->rows<=>$b->rows}grep{$_->name=~/perlre.*\.pod/}io(q(.))->all"

perl -MIO::All -E "$p{$_->name}=map{$l++}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

cd c:\Users\TOSH\Documents\GitHub\perldoc-ru\pod2-ru\target\pods
set path_2_lib=c:\Users\TOSH\Documents\GitHub\io-all-mishin\lib
perl  -I%path_2_lib% -MIO::All -e "printf qq{%s %s\n},$_->name,$_->rows for sort{$a->rows<=>$b->rows}grep{/perlre/}io(q(.))->all"

