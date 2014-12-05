package Dsx_parse::Parse_fields;

#!/usr/bin/perl
use v5.10;

use FindBin '$RealBin';
use utf8;
use strict;
use warnings;
use Encode::Locale;
use Text::ASCIITable;
use File::Slurp;
use Data::Printer {
    output         => 'stdout',
    hash_separator => ':  ',
    return_value   => 'pass',
};
use Data::TreeDumper;
use Hash::Merge qw( merge );

# use Carp::Always;
use Data::Dumper;

# use Dsx_parse::Tools qw(dd);

use version; our $VERSION = qv('0.0.1');
use Sub::Exporter -setup => {
    exports => [
        qw/
          parse_link_fields
          /
    ],
};

# main(shift);

sub parse_records {
    my $data = shift;
    local $/ = '';    # Paragraph mode
    my @records =
      ($data =~ / ( BEGIN[ ]DSRECORD[\n]   .*?  END[ ]DSRECORD ) /xsg);
    return \@records;
}

sub split_by_subrecords {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my @dssubrecords = ($curr_record
          =~ / ( BEGIN[ ]DSSUBRECORD[\n]   .*?  END[ ]DSSUBRECORD ) /xsg);
    return \@dssubrecords;
}

sub split_fields_by_new_line {
    my ($curr_record) = @_;

    #удаляем ненужные begin end
    $curr_record
      =~ s/BEGIN[ ]DSSUBRECORD[\n]  (.*?) END[ ]DSSUBRECORD /$1/xsg;
    my @records = split(/\n/, $curr_record);
    my %big_hash = ();
    for my $line (@records) {
        while ($line =~ m/(?<name>\w+)[ ]"(?<value>.*?)(?<!\\)"/xsg) {
            my $value = '';
            if (defined $+{value}) {
                $value = clear_from_back_slash($+{value});
            }
            $big_hash{$+{name}} = $value;
        }
    }
    return \%big_hash;
}


sub clear_from_back_slash {
    my $string = shift;
    $string =~ s#\\(['"])#$1#g;
    return $string;
}

sub extract_fields_from_ccustomoutput {
    my $ref_array_dssubrecords = shift;
    local $/ = '';    # Paragraph mode
    my @reacher_records = ();
    for my $curr_field (@{$ref_array_dssubrecords}) {
        my %multi_values = ();
        if ($curr_field =~ /
        BEGIN[ ]DSSUBRECORD[\n]
        .*?
        Name[ ]"(?<name>\w+)"
        .*?
        SqlType[ ]"(?<sql_type>\w+)"
        .*?
        END[ ]DSSUBRECORD
        /xsg
          )
        {
            $multi_values{'name'} = $+{name};
            $multi_values{'sql'}  = 'yes';
            $multi_values{'property'} =
              split_fields_by_new_line($curr_field);    #\%fields;
            push @reacher_records, \%multi_values;
        }
        # %multi_values=();

        # if ($curr_field =~ /
      # BEGIN[ ]DSSUBRECORD[\n]
        # .*?
        # Name[ ]"(?<name>\w+)"
        # .*?
        # Value[ ]"(?<value>.*?)(?<!\\)"
        # .*?
     # END[ ]DSSUBRECORD
        # /xsg
          # )
        # {
            # $multi_values{'name' . 'nosql'} = $+{name};
            # $multi_values{'sql'}            = 'no';
            # $multi_values{'nosql_property'} = $+{value};

            # # split_fields_by_new_line($curr_field);    #\%fields;
            # push @reacher_records, \%multi_values;
        # }

    }
    return \@reacher_records;

}


sub parse_names {
    my $ref_array_dsrecords = shift;
    local $/ = '';    # Paragraph mode
    my @rich_records     = ();
    my $ref_needed_types = get_stage_types();
    for my $curr_record (@{$ref_array_dsrecords}) {
        if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
.*?
 END[ ]DSRECORD
 /xsg
          )
        {

            my %multi_values = ();
            @multi_values{'identifier', 'oletype', 'name'} =
              ($+{identifier}, $+{oletype}, $+{name});
            my $sub_recods = split_by_subrecords($curr_record);
            my $ref_reacher_fields =
              extract_fields_from_ccustomoutput($sub_recods);
            $multi_values{'fields'} = $ref_reacher_fields;
            push @rich_records, \%multi_values;
        }
    }
    return \@rich_records;
}

sub parse_link_fields {

    #enc_terminal();
    my $file_name = shift or die "Usage: $0 file_4_transform\n";

# my $file_name  = 'orchestrate_code_body.xml'  or die "Usage: $0 file_4_transform\n";;
    my $data                           = read_file($file_name);
    my $ref_array_dsrecords            = parse_records($data);
    my $ref_array_dsrecords_with_names = parse_names($ref_array_dsrecords);

    #print DumpTree($ref_array_dsrecords, '$parsed_dsx');
    # print DumpTree($ref_array_dsrecords_with_names,
    # '$ref_array_dsrecords_with_names');

    # #p $parsed_dsx;
    # my $only_links = reformat_links($parsed_dsx);

#        show_dsx_content( $parsed_dsx, $file_name );
    return $ref_array_dsrecords_with_names;
}


sub reformat_links {
    my $parsed_dsx = shift;

    my @only_links = ();

    foreach my $stage (@{$parsed_dsx}) {
        if ($stage->{ins}->{in} eq 'yes') {
            for (@{$stage->{ins}->{inputs}}) {
                if ($_->{is_param} eq 'yes') {
                    my %in_links = ();
                    $in_links{link_name}        = $_->{link_name};
                    $in_links{params}           = $_->{params};
                    $in_links{link_keep_fields} = $_->{link_keep_fields};
                    $in_links{trans_name}       = $_->{trans_name};
                    push @only_links, \%in_links;
                }
            }
        }

        if ($stage->{ins}->{out} eq 'yes') {
            for (@{$stage->{ins}->{outputs}}) {
                if ($_->{is_param} eq 'yes') {
                    my %out_links = ();
                    $out_links{link_name}        = $_->{link_name};
                    $out_links{params}           = $_->{params};
                    $out_links{link_keep_fields} = $_->{link_keep_fields};
                    $out_links{trans_name}       = $_->{trans_name};
                    push @only_links, \%out_links;
                }
            }

        }

    }

    p @only_links;
}

sub make_regexp {
    my $operator_rx      = qr{\Q#### STAGE: \E(?<stage_name>\w+)};
    my $operator_name_rx = qr{\Q## Operator\E\n(?<operator_name>\w+)\n\#};
    my $header_rx        = qr{
                  $operator_rx \n
				  $operator_name_rx
                }sx;

    my $ORCHESTRATE_BODY_RX = qr{
       (?<stage_body>
		$header_rx
		.*?
		^;
		)
		}sxm;
    return $ORCHESTRATE_BODY_RX;
}

#
# New subroutine "head_of_stage" extracted - Mon Nov 17 10:15:21 2014.
#
sub show_head_of_stage {
    my ($t, $i, $stage) = @_;

    my ($in, $in_type, $out, $out_type) = ('', '', '', '');
    if ($stage->{ins}->{in} eq 'yes') {
        for (@{$stage->{ins}->{inputs}}) {
            $in = $in . $_->{link_name} . "\n";
        }
    }
    if ($stage->{ins}->{out} eq 'yes') {
        for (@{$stage->{ins}->{outputs}}) {
            $out = $out . $_->{link_name} . "\n";
        }
    }
    $t->addRow($i, $stage->{stage_name}, $stage->{operator_name},
        $in, '', '', '', '', $out, '', '', '', '');
    return $t;
}

#
# New subroutine "show_in_fields" extracted - Mon Nov 17 10:20:07 2014.
#
sub show_in_fields {
    my $t     = shift;
    my $stage = shift;

    if ($stage->{ins}->{in} eq 'yes'
        && ${$stage->{ins}->{inputs}}[0]->{is_param} eq 'yes')
    {
        $t->addRowLine();
        my $j = 1;
        for my $f (@{${$stage->{ins}->{inputs}}[0]->{params}}) {
            $t->addRow('', '', '', '', $j, $f->{field_name}, $f->{field_type},
                $f->{is_null}, '', '', '', '', '');
            $t->addRowLine();
            $j++;
        }
    }

    return $t;
}

#
# New subroutine "show_out_fields" extracted - Mon Nov 17 10:20:53 2014.
#
sub show_out_fields {
    my $t     = shift;
    my $stage = shift;

    if ($stage->{ins}->{out} eq 'yes'
        && ${$stage->{ins}->{outputs}}[0]->{is_param} eq 'yes')
    {
        $t->addRowLine();
        my $y = 1;
        for my $f (@{${$stage->{ins}->{outputs}}[0]->{params}}) {
            $t->addRow('', '', '', '', '', '', '', '', '', $y,
                $f->{field_name}, $f->{field_type}, $f->{is_null});
            $t->addRowLine();
            $y++;
        }
    }
    return $t;
}

#
# New subroutine "display_main_header" extracted - Mon Nov 17 10:30:17 2014.
#
sub show_main_header {
    my $file_name = shift;

    my $t = Text::ASCIITable->new(
        {headingText => 'Parsing ORCHESTRATE of ' . $file_name});
    $t->setCols(
        'Id',      'stage_name', 'op_name',    'inputs',
        'num',     'field_name', 'field_type', 'is_null',
        'outputs', 'num',        'field_name', 'field_type',
        'is_null'
    );
    return $t;
}

sub show_dsx_content {
    my ($parsed_dsx, $file_name) = @_;

    my $t = show_main_header($file_name);

    my $i = 1;
    foreach my $stage (@{$parsed_dsx}) {

        # if ($stage->{stage_name} eq 'LJ108') {

        # p $stage;
        $t = show_head_of_stage($t, $i, $stage);
        $t = show_in_fields($t, $stage);
        $t = show_out_fields($t, $stage);

        $t->addRowLine();
        $i++;

        # }
    }
    print $t;
}


sub get_stage_types {
    my %needed_types = map { $_ => 1 } qw(
      CCustomInput
      CCustomOutput
      CCustomStage
      CTransformerStage
      CTrxInput
      CTrxOutput
    );
    return \%needed_types;
}


sub my_debug {
    my ($name, @vars) = @_;
    if ($name eq 'LRead') {
        say '16:44 04.12.2014';
        for my $cur_var (@vars) {
            p $cur_var;
        }
    }
}

sub parse_subrecords {
    my $curr_record = shift;
    my $oletype     = shift;

    #say '$oletype:' . $oletype;
    local $/ = '';    # Paragraph mode

    my @dssubrecords = (
        $curr_record =~ /
 (
 BEGIN[ ]DSSUBRECORD[\n]
  
 .*?
 
 END[ ]DSSUBRECORD
 )
 /xsg
    );                # отлично, нашли все DSRECORD!! ок, поехали дальше
    my $ref_reacher_fields;
    if ($oletype eq 'CCustomOutput') {
        $ref_reacher_fields =
          extract_fields_from_subrecords_output(\@dssubrecords);
    }
    else {
        $ref_reacher_fields = extract_fields_from_subrecords(\@dssubrecords);
    }
    return $ref_reacher_fields;
}

=pod
для каждого типа стейджа
свой набор полей
BEGIN[ ]DSSUBRECORD[\n]
  \s*?
 Name[ ]"(?<name>\w+)"
  .*? 
         SqlType[ ]"(?<sqltype>\w+)"
  .*? 
         Precision[ ]"(?<precision>\w+)"
  .*? 
         Scale[ ]"(?<scale>\w+)"
  .*? 
         Nullable[ ]"(?<nullable>\w+)"
  .*? 
         KeyPosition[ ]"(?<keyposition>\w+)"
  .*? 
         DisplaySize[ ]"(?<displaysize>\w+)"
  .*? 
         Group[ ]"(?<group>\w+)"
  .*? 
         SortKey[ ]"(?<sortkey>\d+)"
  .*? 
         SortType[ ]"(?<sorttype>\d+)"
  .*? 
         AllowCRLF[ ]"(?<allowcrlf>\w+)"
  .*? 
         LevelNo[ ]"(?<levelno>\w+)"
  .*? 
         Occurs[ ]"(?<occurs>\w+)"
  .*? 
         PadNulls[ ]"(?<padnulls>.*?)"
  .*? 
         SignOption[ ]"(?<signoptions>\w+)"
  .*? 
         SortingOrder[ ]"(?<sortingorder>\w+)"
  .*? 
         ArrayHandling[ ]"(?<arrayhandling>\w+)"
  .*? 
         SyncIndicator[ ]"(?<syncindicator>\w+)"
  .*? 
         PadChar[ ]""
  .*? 
         ExtendedPrecision[ ]"(?<extendedprecision>\w+)"
  .*? 
         TaggedSubrec[ ]"(?<taggedsubrec>\w+)"
  .*? 
         OccursVarying[ ]"(?<occursvarying>\w+)"
  .*? 
         PKeyIsCaseless[ ]"(?<pkeyiscaseless>\w+)"
  .*? 
         SCDPurpose[ ]"(?<scdpurpose>\w+)"
.*?
 END[ ]DSSUBRECORD
 в итоге нужно просто пройтись по полям и забрать их значения
 без сложных регулярных выражений или регекспов!!!
 
 
 (?<name>\w+)[ ]"(?<value>.*?)(?<!\\)" 
 
   ParsedDerivation[ ]"(?<parsedderivation>.*?)(?<!\\)"
=cut

sub extract_fields_from_subrecords_output {
    my $ref_array_dssubrecords = shift;
    local $/ = '';    # Paragraph mode

    # my $dispatch         = create_dispatch();
    my @reacher_records = ();

    # my $ref_needed_types = get_stage_types();
    for my $curr_field (@{$ref_array_dssubrecords}) {
        if ($curr_field =~ /
  BEGIN[ ]DSSUBRECORD[\n]
  \s*?
 Name[ ]"(?<name>\w+)"
  \s*?
 Description[ ]"(?<description>.*?)"
  .*? 
         SqlType[ ]"(?<sqltype>\w+)"
  .*? 
         Precision[ ]"(?<precision>\w+)"
  .*? 
         Scale[ ]"(?<scale>\w+)"
  .*? 
         Nullable[ ]"(?<nullable>\w+)"
  .*? 
         KeyPosition[ ]"(?<keyposition>\w+)"
  .*? 
         DisplaySize[ ]"(?<displaysize>\w+)"
  .*? 
         Group[ ]"(?<group>\w+)"
  .*? 
         SortKey[ ]"(?<sortkey>\d+)"
  .*? 
         SortType[ ]"(?<sorttype>\d+)"
  .*? 
         TableDef[ ]"(?<tabledef>.*?)"

  .*? 
         AllowCRLF[ ]"(?<allowcrlf>\w+)"
  .*? 
         LevelNo[ ]"(?<levelno>\w+)"
  .*? 
         Occurs[ ]"(?<occurs>\w+)"
  .*? 
         PadNulls[ ]"(?<padnulls>.*?)"
  .*? 
         SignOption[ ]"(?<signoptions>\w+)"
  .*? 
         SortingOrder[ ]"(?<sortingorder>\w+)"
  .*? 
         ArrayHandling[ ]"(?<arrayhandling>\w+)"
  .*? 
         SyncIndicator[ ]"(?<syncindicator>\w+)"
  .*? 
         PadChar[ ]""
  .*? 
         ColumnReference[ ]"(?<columnreference>\w+)"
  .*? 
         ExtendedPrecision[ ]"(?<extendedprecision>\w+)"
  .*? 
         TaggedSubrec[ ]"(?<taggedsubrec>\w+)"
  .*? 
         OccursVarying[ ]"(?<occursvarying>\w+)"
  .*? 
         PKeyIsCaseless[ ]"(?<pkeyiscaseless>\w+)"
  .*? 
         SCDPurpose[ ]"(?<scdpurpose>\w+)"
.*?
 END[ ]DSSUBRECORD
 /xsg
          )
        {
            my %multi_values = ();
            $multi_values{'name'} = $+{name};
            my %fields = %+;
            $multi_values{'property'} = \%fields;
            push @reacher_records, \%multi_values;
        }
    }
    return \@reacher_records;

}

sub extract_fields_from_subrecords {
    my $ref_array_dssubrecords = shift;
    local $/ = '';    # Paragraph mode

    # my $dispatch         = create_dispatch();
    my @reacher_records = ();

    # my $ref_needed_types = get_stage_types();
    for my $curr_field (@{$ref_array_dssubrecords}) {
        if ($curr_field =~ /
 BEGIN[ ]DSSUBRECORD[\n]
  \s*?
 Name[ ]"(?<name>\w+)"
  \s*?
 Description[ ]"(?<description>.*?)"
  .*? 
         SqlType[ ]"(?<sqltype>\w+)"
  .*? 
         Precision[ ]"(?<precision>\w+)"
  .*? 
         Scale[ ]"(?<scale>\w+)"
  .*? 
         Nullable[ ]"(?<nullable>\w+)"
  .*? 
         KeyPosition[ ]"(?<keyposition>\w+)"
  .*? 
         DisplaySize[ ]"(?<displaysize>\w+)"
  .*? 
         Derivation[ ]"(?<derivation>.*?)"
  .*? 
         Group[ ]"(?<group>\w+)"
  .*? 
         ParsedDerivation[ ]"(?<parsedderivation>.*?)(?<!\\)"
 .*? 
         SourceColumn[ ]"(?<sourcecolumn>.*?)"
  .*? 
         SortKey[ ]"(?<sortkey>\d+)"
  .*? 
         SortType[ ]"(?<sorttype>\d+)"
  .*? 
         TableDef[ ]"(?<tabledef>.*?)"

  .*? 
         AllowCRLF[ ]"(?<allowcrlf>\w+)"
  .*? 
         LevelNo[ ]"(?<levelno>\w+)"
  .*? 
         Occurs[ ]"(?<occurs>\w+)"
  .*? 
         PadNulls[ ]"(?<padnulls>.*?)"
  .*? 
         SignOption[ ]"(?<signoptions>\w+)"
  .*? 
         SortingOrder[ ]"(?<sortingorder>\w+)"
  .*? 
         ArrayHandling[ ]"(?<arrayhandling>\w+)"
  .*? 
         SyncIndicator[ ]"(?<syncindicator>\w+)"
  .*? 
         PadChar[ ]""
  .*? 
         ColumnReference[ ]"(?<columnreference>\w+)"
  .*? 
         ExtendedPrecision[ ]"(?<extendedprecision>\w+)"
  .*? 
         TaggedSubrec[ ]"(?<taggedsubrec>\w+)"
  .*? 
         OccursVarying[ ]"(?<occursvarying>\w+)"
  .*? 
         PKeyIsCaseless[ ]"(?<pkeyiscaseless>\w+)"
  .*? 
         SCDPurpose[ ]"(?<scdpurpose>\w+)"
.*?
 END[ ]DSSUBRECORD
 /xsg
          )
        {
            my %multi_values = ();
            $multi_values{'name'} = $+{name};
            my %fields = %+;
            $multi_values{'property'} = \%fields;
            push @reacher_records, \%multi_values;
        }
    }
    return \@reacher_records;

}

sub create_dispatch {

# Dispatch table (hash of subroutine references)
    # my %dispatch = (
    # CCustomInput      => \&parse_CCustomInput,
    # CCustomOutput     => \&parse_CCustomOutput,
    # CCustomStage      => \&parse_CCustomStage,
    # CTransformerStage => \&parse_CTransformerStage,
    # CTrxInput         => \&parse_CTrxInput,
    # CTrxOutput        => \&parse_CTrxOutput,
    # );
    my %dispatch = (
        CCustomInput      => \&parse_CCustomOutput,
        CCustomOutput     => \&parse_CCustomOutput,
        CCustomStage      => \&parse_CCustomOutput,
        CTransformerStage => \&parse_CCustomOutput,
        CTrxInput         => \&parse_CCustomOutput,
        CTrxOutput        => \&parse_CCustomOutput,
    );
    return \%dispatch;
}


# CCustomInput
# CCustomOutput
# CCustomStage
# CTransformerStage
# CTrxInput
# CTrxOutput
sub parse_CCustomOutput {
    my $curr_record = shift;
    my $oletype     = shift;
    my $name        = shift;

    # say 'deb_deb: '.$curr_record.' $oletype: '.$oletype;
    #my $subrecords = parse_subrecords($curr_record, $oletype);
    #1)split records!!!
    my $sub_recods = split_by_subrecords($curr_record);


    my $ref_reacher_fields = extract_fields_from_ccustomoutput($sub_recods);

    # my_debug($name,$ref_reacher_fields,$sub_recods);

    # say 'deb_deb2:  $name: ';
    # print Dumper $name;
    # Dsx_parse::Tools::dd($ref_reacher_fields);
    return $ref_reacher_fields;
}


=pod
 elsif (
            $curr_field =~ /
              BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
.*?
 StageType[ ]"(?<stagetype>\w+)"
  .*? 
 END[ ]DSRECORD
              /xsg
          )
        {
            $multi_values{'name'}      = $+{name};
            $multi_values{'stagetype'} = $+{stagetype};
            $multi_values{'property'} =
              split_fields_by_new_line($curr_field);    #\%fields;
            push @reacher_records, \%multi_values;

        }
=cut        


sub parse_CCustomStage {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my $dispatch_customstage = create_dispatch_customstage();

    my %multi_values = ();
    if ($curr_record =~ /
  BEGIN[ ]DSRECORD[\n]
  \s*?
  Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (?<pinstype>InputPins|OutputPins)[ ]"(?<pins>[\w|]+)"
  \s*?
 StageType[ ]"(?<stagetype>[\w|]+)"
 .*?
 END[ ]DSRECORD
 /xsg
      )
    {

# say '11:50';
# p %+;
        # identifier:  "V8S0",
        # name      :  "SQBceNrRestructHistInsert",
        # oletype   :  "CCustomStage",
        # pins      :  "V8S0P1",
        # pinstype  :  "OutputPins",
        # stagetype :  "PxSequentialFile"
        %multi_values = %+;
        if (defined $dispatch_customstage->{$+{stagetype}}) {
            $multi_values{'record'} =
              $dispatch_customstage->{$+{stagetype}}->($curr_record)
              or die 'new stagetype: ' . $+{stagetype};
        }
        else {
            die 'ERROR invoke $dispatch_customstage code:0100 new stagetype: '
              . $+{stagetype};
        }
    }


    return \%multi_values;

}

sub create_dispatch_customstage {

# Dispatch table (hash of subroutine references)
    my %dispatch = (
        PxJoin           => \&parse_customstage_pxjoin,
        ODBCConnectorPX  => \&parse_customstage_odbcconnectorpx,
        PxFunnel         => \&parse_customstage_pxfunnel,
        PxSequentialFile => \&parse_customstage_pxsequentialfile,
        DB2ConnectorPX   => \&parse_customstage_odbcconnectorpx,
        PxChangeCapture  => \&parse_customstage_odbcconnectorpx,
        PxSwitch         => \&parse_customstage_odbcconnectorpx,
        PxCopy           => \&parse_customstage_odbcconnectorpx,
        PxDataSet        => \&parse_customstage_odbcconnectorpx,
    );
    return \%dispatch;
}


sub parse_customstage_pxfunnel {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (Partner[ ]"(?<partner>[\w|]+)")
  .*? 
 END[ ]DSRECORD
 /xsg
      )
    {
        @multi_values{'identifier', 'oletype', 'name', 'partner'} =
          ($+{identifier}, $+{oletype}, $+{name}, $+{partner});
    }

    return \%multi_values;

}


sub parse_customstage_pxsequentialfile {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
  Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (?<pinstype>InputPins|OutputPins)[ ]"(?<pins>[\w|]+)"
  \s*?
 StageType[ ]"ODBCConnectorPX"
 .*?
 END[ ]DSRECORD
 /xsg
      )
    {
        %multi_values = %+;
        $multi_values{property} =
          parse_subrecords_odbcconnectorpx($curr_record);
    }

    return \%multi_values;

}

sub parse_customstage_odbcconnectorpx {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
  Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (?<pinstype>InputPins|OutputPins)[ ]"(?<pins>[\w|]+)"
  \s*?
 StageType[ ]"ODBCConnectorPX"
 .*?
 END[ ]DSRECORD
 /xsg
      )
    {
        %multi_values = %+;
        $multi_values{property} =
          parse_subrecords_odbcconnectorpx($curr_record);
    }

    return \%multi_values;

}

sub parse_subrecords_odbcconnectorpx {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode

    my @dssubrecords = (
        $curr_record =~ /
 ( BEGIN[ ]DSSUBRECORD[\n]  
 .*? 
 END[ ]DSSUBRECORD
 )
 /xsg
    );                # отлично, нашли все DSRECORD!! ок, поехали дальше

    my $ref_reacher_fields = extract_fields_odbcconnectorpx(\@dssubrecords);
    return $ref_reacher_fields;
}

sub extract_fields_odbcconnectorpx {
    my $ref_array_dssubrecords = shift;
    local $/ = '';    # Paragraph mode
    my %fields = ();

    for my $curr_field (@{$ref_array_dssubrecords}) {
        if ($curr_field =~ /
 BEGIN[ ]DSSUBRECORD[\n]
  \s*?
 Name[ ]"(?<name>\w+)"
  .*?
Value[ ]
   "
.*?
<Connection>
<DataSource.*?>
<!\[CDATA\[(?<datasource>[\w#.]+)\]\]>
<\/DataSource>
<Username.*?>
<!\[CDATA\[(?<username>[\w#.]+)\]\]>
<\/Username>
<Password.*?>
<!\[CDATA\[(?<password>[\w#.]+)\]\]>
<\/Password>
<\/Connection>
.*?
   "
  .*?
END[ ]DSSUBRECORD
 /xsg
          )
        {
            %fields = %+;
        }
    }
    return \%fields;
}

=pod
 my $CONNECT_PROPERTIES_RX =
      qr{BEGIN DSSUBRECORD.*?Name "XMLProperties".*?<Database .*?\Q![CDATA[\E(?<database_name>#.*?#)\Q]]\E.*?<Username .*?\Q![CDATA[\E(?<user_name>#.*?#)\Q]]\E.*?<SelectStatement .*?\Q![CDATA[\E(?<select_statement>.*?)\Q]]\E}s;
  
=cut


sub parse_customstage_pxjoin {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (Partner[ ]"(?<partner>[\w|]+)")
  .*? 
 END[ ]DSRECORD
 /xsg
      )
    {
        @multi_values{'identifier', 'oletype', 'name', 'partner'} =
          ($+{identifier}, $+{oletype}, $+{name}, $+{partner});
    }

    return \%multi_values;

}


=pod
 InputPins[ ]"(?<inputpins>[\w|]+)"
  .*?
 OutputPins[ ]"(?<outputpins>[\w|]+)"
  .*?
=cut

sub parse_CTransformerStage {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (Partner[ ]"(?<partner>[\w|]+)")
  .*? 
 END[ ]DSRECORD
 /xsg
      )
    {
        @multi_values{'identifier', 'oletype', 'name', 'partner'} =
          ($+{identifier}, $+{oletype}, $+{name}, $+{partner});
    }

    return \%multi_values;

}

sub parse_CTrxInput {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (Partner[ ]"(?<partner>[\w|]+)")
  .*? 
 END[ ]DSRECORD
 /xsg
      )
    {
        %multi_values = %+;
        $multi_values{property} =
          parse_subrecords_odbcconnectorpx($curr_record);

# @multi_values{'identifier', 'oletype', 'name', 'partner'} =          ($+{identifier}, $+{oletype}, $+{name}, $+{partner});
    }

    return \%multi_values;

}

sub parse_CTrxOutput {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (Partner[ ]"(?<partner>[\w|]+)")
  .*? 
 (Constraint[ ]"(?<constraint>.*?)(?<!\\)")
  .*? 
 (ParsedConstraint[ ]"(?<parsedconstraint>.*?)(?<!\\)")
  .*?
 (SourceColumns[ ]"(?<sourcecolumns>.*?)(?<!\\)")
  .*? 
 END[ ]DSRECORD
 /xsg
      )
    {
        %multi_values = %+;
        $multi_values{property} =
          parse_subrecords_odbcconnectorpx($curr_record);

        # @multi_values{'identifier', 'oletype', 'name', 'partner'} =
        # ($+{identifier}, $+{oletype}, $+{name}, $+{partner});
    }

    return \%multi_values;

}

sub parse_CCustomInput {
    my $curr_record = shift;
    local $/ = '';    # Paragraph mode
    my %multi_values = ();
    if ($curr_record =~ /
 BEGIN[ ]DSRECORD[\n]
  \s*?
 Identifier[ ]"(?<identifier>\w+)"
  \s*?
 OLEType[ ]"(?<oletype>\w+)"
  .*?
 Name[ ]"(?<name>\w+)"
  .*?
 (Partner[ ]"(?<partner>[\w|]+)")
  .*? 
 END[ ]DSRECORD
 /xsg
      )
    {
        @multi_values{'identifier', 'oletype', 'name', 'partner'} =
          ($+{identifier}, $+{oletype}, $+{name}, $+{partner});
    }

    return \%multi_values;

}

# my   ($identifier, $oletype) = (
# $curr_record =~ /
# BEGIN[ ]DSRECORD[\n]
# \s+
# Identifier "(?<identifier>\w+)"
# \s+
# OLEType "(?<oletype>\w+)"
# .*?
# END[ ]DSRECORD
# /xsg
# )
# ; # отлично, нашли все DSRECORD!! ок, поехали дальше


sub parse_orchestrate_body {
    my $data                = shift;
    my $ORCHESTRATE_BODY_RX = make_regexp();
    local $/ = '';
    my @parsed_dsx = ();
    while ($data =~ m/$ORCHESTRATE_BODY_RX/xsg) {
        my %stage = ();
        my $ins   = parse_stage_body($+{stage_body});
        $stage{ins}           = $ins;
        $stage{stage_name}    = $+{stage_name};
        $stage{operator_name} = $+{operator_name};
        push @parsed_dsx, \%stage;
    }
    return \@parsed_dsx;
}

sub parse_stage_body {
    my ($stage_body) = @_;
    my %outs;
    my $inputs_rx  = qr{## Inputs\n(?<inputs_body>.*?)(?:#|^;$)}sm;
    my $outputs_rx = qr{## Outputs\n(?<outputs_body>.*?)^;$}sm;

    my ($inputs, $outputs) = ('', '');
    $outs{in}   = 'no';
    $outs{out}  = 'no';
    $outs{body} = $stage_body;
    if ($stage_body =~ $inputs_rx) {
        $outs{inputs} = parse_out_links($+{inputs_body});
        $outs{in}     = 'yes';
    }
    if ($stage_body =~ $outputs_rx) {
        $outs{outputs} = parse_in_links($+{outputs_body});
        $outs{out}     = 'yes';
    }
    return \%outs;
}

sub parse_in_links {
    my ($body) = @_;
    my @links = ();

    my $link = qr{\d+
    (?:<|>)
    (?:\||)
    \s
         \[
        (?<link_type>
        (?:
        modify\s\(
          (?:
         (?<link_fields>
         .*?;|.*?
         )
         )\n
         keep
         (?<link_keep_fields>
         .*?
         )
         ;
         .*?
          \)
         )
	     |.*
	     )
         \]
                   \s 
         '
         (?:
         			 (?<trans_name>\w+):
					 (?<link_name>\w+)
					 .v
		 
					 |
					 \[.*?\]			 
		(?<link_name>
					 \w+.ds
		)
		)' 
		      }xs;

    while ($body =~ m/$link/g) {
        my %link_param = ();
        $link_param{link_name} = $+{link_name};
        $link_param{link_type} = $+{link_fields};

        #$link_param{link_type} = $+{link_type};
        $link_param{trans_name} = $+{trans_name} if defined $+{trans_name};
        $link_param{is_param} = 'no';
        if (defined $+{link_fields})

          #if ( length( $link_param{link_type} ) >= 6
          #&& substr( $link_param{link_type}, 0, 6 ) eq 'modify' )
        {
            $link_param{is_param} = 'yes';
            $link_param{params}   = parse_fields($+{link_fields});
            $link_param{link_keep_fields} =
              parse_keep_fields($+{link_keep_fields})
              if defined $+{link_keep_fields};
        }
        push @links, \%link_param;
    }

    #p @links;
    return \@links;

}

sub parse_out_links {
    my ($body) = @_;
    my @links = ();

    my $link = qr{\d+
    (?:<|>)
    (?:\||)
    \s
         \[
        (?<link_type>
        (?:
        modify\s\(
          (?:
         (?<link_fields>
         .*?;|.*?
         )
         )\n
         keep
         (?<link_keep_fields>
         .*?
         )
         ;
         .*?
          \)
         )
	     |.*
	     )
         \]
                   \s 
         '
         (?:
         			 (?<trans_name>\w+):
					 (?<link_name>\w+)
					 .v
		 
					 |
					 \[.*?\]			 
		(?<link_name>
					 \w+.ds
		)
		)' 
		      }xs;

    while ($body =~ m/$link/g) {
        my %link_param = ();
        $link_param{link_name} = $+{link_name};
        $link_param{link_type} = $+{link_fields};

        #$link_param{link_type} = $+{link_type};
        $link_param{trans_name} = $+{trans_name} if defined $+{trans_name};
        $link_param{is_param} = 'no';
        if (defined $+{link_fields})

          #if ( length( $link_param{link_type} ) >= 6
          #&& substr( $link_param{link_type}, 0, 6 ) eq 'modify' )
        {
            $link_param{is_param} = 'yes';
            $link_param{params}   = parse_fields($+{link_fields});
            $link_param{link_keep_fields} =
              parse_keep_fields($+{link_keep_fields})
              if defined $+{link_keep_fields};
        }
        push @links, \%link_param;
    }

    #p @links;
    return \@links;

}

sub parse_keep_fields {
    my $body_for_keep_fields = shift;
    $body_for_keep_fields =~ s/^\s+|\s+$//g;

    #p $body_for_keep_fields;
    my @fields = split /\s*,\s*/s, $body_for_keep_fields;
    return \@fields;
}

sub parse_fields {
    my $body_for_fields = shift;

    #p $body_for_fields;
    my @fields = ();
    my $field  = qr{
    (?<field_name>\w+)
    :
    (?<is_null>not_nullable|nullable)\s
    (?<field_type>.*?)
    =
    \g{field_name}
    ;
     }xs;

    while ($body_for_fields =~ m/$field/g) {
        my %field_param = ();
        $field_param{field_name} = $+{field_name};
        $field_param{is_null}    = $+{is_null};
        $field_param{field_type} = $+{field_type};
        push @fields, \%field_param;
    }
    return \@fields;

}

sub enc_terminal {

    if (-t) {
        binmode(STDIN,  ":encoding(console_in)");
        binmode(STDOUT, ":encoding(console_out)");
        binmode(STDERR, ":encoding(console_out)");
    }
}

__DATA__
  
