#!perl
use 5.14.0;
use Win32::GuiTest qw(:ALL);
use win32::Clipboard;

# &get_informatica_win_and_activate();
# &put_key_mouse();
&past_changed_text();

sub get_informatica_win_and_activate {
    my @windows =
      FindWindowLike( undef, "Informatica PowerCenter Designer ", "" );

    for (@windows) {
        print "$_>\t'", GetWindowText($_), "'\n";
        SetForegroundWindow($_);
    }
}

sub put_key_mouse {
    SendRawKey( VK_LMENU, KEYEVENTF_EXTENDEDKEY );
    SendKeys('{TAB}');
    SendRawKey( VK_LMENU, KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP );
    MouseMoveAbsPix( 747, 560 );
    SendMouse('{LEFTCLICK}');
    MouseMoveAbsPix( 749, 560 );
    SendMouse('{LEFTCLICK}');
    MouseMoveAbsPix( 749, 560 );
    SendMouse('{LEFTCLICK}');
    MouseMoveAbsPix( 749, 560 );
    SendMouse('{RIGHTCLICK}');
    MouseMoveAbsPix( 819, 629 );
    SendMouse('{LEFTCLICK}');

}

sub past_changed_text {
    my $CLIP = Win32::Clipboard();
    SendKeys("^c");
    my $text = $CLIP->GetText;
# Shortcut_to_m_S01_STG_REF_EMPL
    $text =~ s|Shortcut_to_|SC_|g;
    # $text =~ s|DPRL|OPERATION_TYPE|g;    
    # $text =~ s|CCINF|PROD|g;
    $CLIP->Set($text);
    SendKeys("^v");
}



sub usage {
    my $usage_str = <<END;
Valid command line arguments are:
   $0  [--to <language>] [--from <language>] text...
Optional arguments controlling translation languages:
   --to     Sets the language to translate to
The default value is English (en)
   --from   Sets the language to translate from
The default value is French (fr)
Languages can be specified by name (i.e. French) or by their abbreviation (i.e. fr).
Valid languages are:
END
    print $usage_str;
    my $curLine = '';

    for my $key ( sort keys %languages ) {
        $curLine = sprintf( '%s %20s %7s  ',
            $curLine, $key, '(' . $languages{$key} . ')' );
        if ( length($curLine) > 100 ) {
            print "$curLine\n";
            $curLine = '';
        }
    }
    print "$curLine\n";
}