#!/usr/bin/env perl
#
# Copy files from Perl distribution to source/ directory in OmegaT project.
#
use v5.12;
use autodie;
use File::Copy;
use File::Spec::Functions qw(catdir catfile);
use File::Path qw(make_path);
use File::Slurp;
use DDP;

### Configuration ###
my $SOURCE_DIR =
  'c:\Users\ira\Downloads\strawberry-perl-5.18.0.1-32bit-portable\perl'
  ;    # Distribution directory
my $POD_DIR = catdir( $SOURCE_DIR, 'lib', 'pods' );
my $POD_FAQS_DIR = catdir( $SOURCE_DIR, 'lib' );

my $TARGET_DIR = 'c:\Users\ira\Documents\GitHub\perldoc-ru\pod2-ru\source\pods'
  ;    # source/ OmegaT directory

#####################

### Check ###
make_path($TARGET_DIR);    # if !-d $TARGET_DIR;

my @files = read_dir($TARGET_DIR);

# Check dirs.
if ( scalar @files ) {
    die "ERROR: $TARGET_DIR contains files! I need a clean bedroom.\n";
}
if ( !-d $SOURCE_DIR ) {
    die "ERROR: The source distribution directory does not exist.\n";
}
if ( !-d $POD_DIR ) {
    die "ERROR: Couldn't find the pod/ directory in $SOURCE_DIR directory.\n";
}

&copy_pods( $POD_DIR, $POD_FAQS_DIR, $TARGET_DIR );

### Copy pods
sub copy_pods {
    my ( $pod_dir, $pod_faqs_dir, $target_dir ) = @_;
    my $pods_regex = qr/[.]pod$/;
    my $faqs_regex = qr/^perl.+\.pod$/;

### Vars ###
    my $number_files = 0;
#####################

### Copy pods
    $number_files =
      copy_pods_dir( $pod_dir, $pods_regex, $target_dir, $number_files );

### Copy faqs & additional pods
    $number_files =
      copy_pods_dir( $pod_faqs_dir, $faqs_regex, $target_dir, $number_files );

### End
    say "Files copied: $number_files";

}

sub copy_pods_dir {
    my ( $source_dir, $regexp, $target_dir, $number_files ) = @_;
    my @source_dir = read_dir($source_dir);           #, prefix => 1 );
    my @pod_files = grep { /$regexp/ } @source_dir;
    foreach my $file (@pod_files) {
        my ( $atime, $mtime ) = ( stat($file) )[ 8, 9 ];
        copy( "$source_dir/$file", $target_dir );
        utime $atime, $mtime, "$target_dir/$file";
        $number_files++;
    }
    return $number_files;
}    

__END__
