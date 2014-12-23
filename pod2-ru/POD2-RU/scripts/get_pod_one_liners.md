```perl
perl -Ilib -MIO::All -E"say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/lre[^fp]/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all"  
```
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlreguts.pod 886 112/886     +/-  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlre.pod 2585 108 +/-  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlretut.pod 2928 2102 72%    +/-  

https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perldebtut.pod 730 130 18%             +/-  

https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlrebackslash.pod 661 22 +/-  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlrecharclass.pod 851 30 +/-   

view https://github.com/mishin/perldoc-ru/blob/master/pod2-ru/POD2-RU/scripts/get_pod_one_liners.md  
edit https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/POD2-RU/scripts/get_pod_one_liners.md  
edit https://github.com/mishin/parse_datastage_dsx/edit/master/Dsx_parse/Tools.pm  
https://github.com/mishin/perlsecret/edit/master/lib/perlsecret.ru.pod  

https://github.com/mishin/perldoc-ru/blob/master/pod2-ru/target/pods/perlperf.pod  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlunicode.pod 1857 23 +/-  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlreapi.pod 706 57           +/-  

https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perldebguts.pod 10             +/-  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perldebug.pod 10             +/-  


ready
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlreref.pod 408             +  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlrequick.pod 519           +  


C:\Perl64\lib\pods\perlreref.pod 408             +  
C:\Perl64\lib\pods\perlrequick.pod 519           +  
C:\Perl64\lib\pods\perlreapi.pod 706 57         +/-  
C:\Perl64\lib\pods\perlrebackslash.pod 661 131    +/-  
C:\Perl64\lib\pods\perlrecharclass.pod 850 78    +/-   
C:\Perl64\lib\pods\perlreguts.pod 886 20/886     +/-  
C:\Perl64\lib\pods\perlre.pod 2585 107           +/-  
C:\Perl64\lib\pods\perlretut.pod 2928 512 17%    +-  
perlsecret.ru.pod 959 959 +  
C:\Perl64\lib\pods\perlunicode.pod 1857 49 +/-  

perlunicode.pod  


```perl
perl -MIO::All -E'say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/lre[^f]/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all'
```,
/usr/share/perl/5.18/pod/perlrepository.pod 18  
/usr/share/perl/5.18/pod/perlreref.pod 408       +  
/usr/share/perl/5.18/pod/perlrequick.pod 519     +  
/usr/share/perl/5.18/pod/perlrebackslash.pod 664  
/usr/share/perl/5.18/pod/perlreapi.pod 826  
/usr/share/perl/5.18/pod/perlreguts.pod 928  
/usr/share/perl/5.18/pod/perlrecharclass.pod 1081  
/usr/share/perl/5.18/pod/perlre.pod 2614         +-  
/usr/share/perl/5.18/pod/perlretut.pod 2928 512 17%   +-  



```perl
perl -MIO::All -E"say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/lre[^f]/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all"
```
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

```perl
my @lines = map {chomp; $_} $io->slurp;


perl -MIO::All -E "$p{$_->name}=map{$l++}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

perl -MIO::All -E "$p{$_->name}=map{chomp}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

perl -I"c:\Users\TOSH\Documents\GitHub\io-all-mishin\lib" -MIO::All -e "printf qq{%s %s\n},$_->name,$_->rows for sort {$a->rows<=>$b->rows}grep{$_->name=~/perlre.*\.pod/}io(q(.))->all"

perl -MIO::All -E "$p{$_->name}=map{$l++}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"


cd c:\Users\TOSH\Documents\GitHub\perldoc-ru\pod2-ru\target\pods
set path_2_lib=c:\Users\TOSH\Documents\GitHub\io-all-mishin\lib
perl  -I%path_2_lib% -MIO::All -e "printf qq{%s %s\n},$_->name,$_->rows for sort{$a->rows<=>$b->rows}grep{/perlre/}io(q(.))->all"

```
