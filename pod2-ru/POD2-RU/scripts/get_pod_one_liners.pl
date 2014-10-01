my @lines = map {chomp; $_} $io->slurp;


perl -MIO::All -E "$p{$_->name}=map{$l++}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

perl -MIO::All -E "$p{$_->name}=map{chomp}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

perl -I"c:\Users\TOSH\Documents\GitHub\io-all-mishin\lib" -MIO::All -e "printf qq{%s %s\n},$_->name,$_->rows for sort {$a->rows<=>$b->rows}grep{$_->name=~/perlre.*\.pod/}io(q(.))->all"

perl -MIO::All -E "$p{$_->name}=map{$l++}$_->slurp for grep{/perlre/}io('.')->all;for $k(sort {$p{$a}<=>$p{$b}} keys %p){say qq{$k $p{$k}}}"

cd c:\Users\TOSH\Documents\GitHub\perldoc-ru\pod2-ru\target\pods
set path_2_lib=c:\Users\TOSH\Documents\GitHub\io-all-mishin\lib
perl  -I%path_2_lib% -MIO::All -e "printf qq{%s %s\n},$_->name,$_->rows for sort{$a->rows<=>$b->rows}grep{/perlre/}io(q(.))->all"

