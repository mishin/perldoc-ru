use Encode::Locale qw(decode_argv);
if (-t) {
    binmode( STDIN,  ":encoding(console_in)" );
    binmode( STDOUT, ":encoding(console_out)" );
    binmode( STDERR, ":encoding(console_out)" );
}
Encode::Locale::decode_argv();


            my @layers = PerlIO::get_layers ($$self{output_fh});
            if (grep { $_ eq 'utf8' } @layers) {
                $$self{ENCODE} = 0;
            }
			
			что это за код?