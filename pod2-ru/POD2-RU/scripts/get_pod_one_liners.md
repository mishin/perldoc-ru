```perl
perl -Ilib -MIO::All -E"say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/lre[^fp]/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all"  

perl -Ilib -MIO::All -E 'say$_->name.q{ }.$_->getlines for sort {$a->size<=>$b->size}grep{/perlre/}io->dir((`perldoc -l perl`=~/(.+?)[\w.]+$/))->all'  

```
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlreguts.pod 886 112/886     +/-  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlre.pod 2585 108 +/-  
https://github.com/mishin/perldoc-ru/edit/master/pod2-ru/target/pods/perlretut.pod 2928 2607  93%    +/-  

https://github.com/mishin/POD-to-RU/edit/master/lib/POD2/RU/perlre.pod
perl -E "say 1/(2928/2746)"

__NUMBER3__
lc is aliased to `git commit -a -m "a bit"

perl -pi -e 's/8/9/ if $. == 9' ./pod2-ru/POD2-RU/scripts/get_pod_one_liners.md;lc;git commit --amend --date="Sat Jan 10 14:00 2015 +0300"

perl -pi -e 's/10/11/ if $. == 9' ./pod2-ru/POD2-RU/scripts/get_pod_one_liners.md;lc;git commit --amend --date="Sat Jan 24 14:00 2015 +0300"

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


http://habrahabr.ru/company/luxoft/blog/215345/

```
git filter-branch --env-filter \
    'if [ $GIT_COMMIT = 119f9ecf58069b265ab22f1f97d2b648faf932e0 ]
     then
         export GIT_AUTHOR_DATE="Fri Jan 2 21:38:53 2009 -0800"
         export GIT_COMMITTER_DATE="Sat May 19 01:01:01 2007 -0700"
     fi'
	 
git commit --amend --date="Wed Feb 16 14:00 2011 +0100"
GIT_COMMITTER_DATE="Wed Feb 16 14:00 2011 +0100" git commit --amend
```
Here is a convenient alias that changes both commit and author times of the last commit to a time accepted by date --date:

```
[alias]
    cd = "!d=\"$(date -d \"$1\")\" && shift && GIT_COMMITTER_DATE=\"$d\" \
            git commit --amend --date \"$d\""
Usage: git cd <date_arg>
```
Examples:
```
git cd now  # update the last commit time to current time
git cd '1 hour ago'  # set time to 1 hour ago
```
Edit: Here is a more-automated version which checks that the index is clean (no uncommitted changes) and reuses the last commit message, or fails otherwise (fool-proof):
```
[alias]
    cd = "!d=\"$(date -d \"$1\")\" && shift && \
        git diff-index --cached --quiet HEAD --ignore-submodules -- && \
        GIT_COMMITTER_DATE=\"$d\" git commit --amend -C HEAD --date \"$d\"" \
        || echo >&2 "error: date change failed: index not clean!"	 
```		
The following bash function will change the time of any commit on the current branch.

Be careful not to use if you already pushed the commit or if you use the commit in another branch.
```
# rewrite_commit_date(commit, date_timestamp)
#
# !! Commit has to be on the current branch, and only on the current branch !!
# 
# Usage example:
#
# 1. Set commit 0c935403 date to now:
#
#   rewrite_commit_date 0c935403
#
# 2. Set commit 0c935403 date to 1402221655:
#
#   rewrite_commit_date 0c935403 1402221655
#
rewrite_commit_date () {
    local commit="$1" date_timestamp="$2"
    local date temp_branch="temp-rebasing-branch"
    local current_branch="$(git rev-parse --abbrev-ref HEAD)"

    if [[ -z "$commit" ]]; then
        date="$(date -R)"
    else
        date="$(date -R --date "@$date_timestamp")"
    fi

    git checkout -b "$temp_branch" "$commit"
    GIT_COMMITTER_DATE="$date" git commit --amend --date "$date"
    git checkout "$current_branch"
    git rebase "$commit" --onto "$temp_branch"
    git branch -d "$temp_branch"
}		
```
1
