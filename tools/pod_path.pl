use File::Spec::Functions qw(catdir splitdir);
my @perl_exe_path =splitdir($^X);
my @head_perl_path = @perl_exe_path[0..$#perl_exe_path-2];
my $pod_path=catdir(@head_perl_path,'lib','pods');
print $pod_path;
