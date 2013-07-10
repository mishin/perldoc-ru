use Modern::Perl;
use File::Spec::Functions qw(catdir splitdir);
use DDP;
my $cmd = q{perldoc -l perldoc};
use IPC::Open3;
my @pod_path        = splitdir( run_shell($cmd) );
my @pod_path_splice = @pod_path[ 0 .. $#pod_path - 1 ];
my $pod_path        = catdir(@pod_path_splice);
say $pod_path;

sub run_shell {
    my $cmd = shift;
    my ( $HIS_IN, $HIS_OUT, $HIS_ERR ) = ( q{}, q{}, q{} );
    my $pid = eval { open3( $HIS_IN, $HIS_OUT, $HIS_ERR, $cmd, () ); };
    if ($@) {
        warn($@);
    }
    waitpid( $pid, 0 );
    my $child_exit_status = $? >> 8;
    my $path              = <$HIS_OUT>;
    return $path;
}
