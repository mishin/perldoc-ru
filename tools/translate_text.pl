#!perl
use 5.14.0;
use Win32::GuiTest qw(:ALL);
use win32::Clipboard;
use Modern::Perl;
use strict;
use warnings;
require LWP::UserAgent;
use Getopt::Long qw(:config pass_through);
use URI::Escape;
use HTML::Entities;

# use Encode 'from_to';
use Convert::Cyrillic;

my %languages = (
    'french'               => 'fr',
    'spanish'              => 'es',
    'afrikaans'            => 'af',
    'albanian'             => 'sq',
    'arabic'               => 'ar',
    'belarusian'           => 'be',
    'bulgarian'            => 'bg',
    'catalan'              => 'ca',
    'chinese'              => 'zh-cn',
    'croatian'             => 'hr',
    'czech'                => 'cs',
    'danish'               => 'da',
    'dutch'                => 'nl',
    'english'              => 'en',
    'estonian'             => 'et',
    'filipino'             => 'tl',
    'finnish'              => 'fi',
    'french'               => 'fr',
    'galician'             => 'gl',
    'german'               => 'de',
    'greek'                => 'el',
    'haitian creole alpha' => 'ht',
    'hebrew'               => 'iw',
    'hindi'                => 'hi',
    'hungarian'            => 'hu',
    'icelandic'            => 'is',
    'indonesian'           => 'id',
    'irish'                => 'ga',
    'italian'              => 'it',
    'japanese'             => 'ja',
    'korean'               => 'ko',
    'latvian'              => 'lv',
    'lithuanian'           => 'lt',
    'macedonian'           => 'mk',
    'malay'                => 'ms',
    'maltese'              => 'mt',
    'norwegian'            => 'no',
    'persian'              => 'fa',
    'polish'               => 'pl',
    'portuguese'           => 'pt',
    'romanian'             => 'ro',
    'russian'              => 'ru',
    'serbian'              => 'sr',
    'slovak'               => 'sk',
    'slovenian'            => 'sl',
    'spanish'              => 'es',
    'swahili'              => 'sw',
    'swedish'              => 'sv',
    'thai'                 => 'th',
    'turkish'              => 'tr',
    'ukrainian'            => 'uk',
    'vietnamese'           => 'vi',
    'welsh'                => 'cy',
    'yiddish'              => 'yi',
);


# &get_informatica_win_and_activate();
# &put_key_mouse();
&past_changed_text();

sub get_informatica_win_and_activate {
    my @windows =
      FindWindowLike( undef, "Omega", "" );

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
    # SendKeys("^c");
    my $text = $CLIP->GetText;
    # $CLIP->Set(translate_sentence($text));
    say translate_sentence($text);
    # SendKeys("^v");
}

sub translate_sentence {
    my $help;
    my $to   = 'ru';
    my $from = 'en';

    GetOptions(
        'help!'  => \$help,
        'to=s'   => \$to,
        'from=s' => \$from
    );
    # if ( $help || $#ARGV == -1 ) {
        # usage();
        # exit(0);
    # }
    if ( $languages{ lc $from } ) {
        $from = $languages{ lc $from };
    }
    if ( $languages{ lc $to } ) {
        $to = $languages{ lc $to };
    }
    my @words = @ARGV;
    map uri_escape, @words;
    my $url = "http://translate.google.com/translate_t?langpair=$from|$to&text="
      . join( '+', @words );
    my $ua = LWP::UserAgent->new;
    $ua->agent('');
    my $res = $ua->get($url);
    if ( $res->is_success ) {
        my $sentence = join( ' ', @words );

        # my $translated = decode_entities($res->content);
        if ( $res->content =~
/<span title="$sentence" onmouseover="this.style.backgroundColor='#ebeff9'" onmouseout="this.style.backgroundColor='#fff'">(.*?)<\/span>/
          )
        {
            my $translated = decode_entities($1);
            return Convert::Cyrillic::cstocs('KOI8', 'UTF8', $translated);
            # print "$koi8_text\n";
        }
    }
    else {
        die $res->status_line;
    }
	
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