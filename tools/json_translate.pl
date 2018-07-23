use utf8;   # このスクリプトはutf8。
use JSON;   # 基本の4つの関数がインポートされる
use Encode;
use File::Basename;
use File::Path;
use File::Find;

my $cddadir = $ARGV[0];

my @files;


    #
    # 日本語ファイルの読み込み
    #
    my %translate;
    my $id;
    my $str;
    my $mode = 0;

    open ($in, "<$cddadir/lang/po/ja.po");
    foreach my $line (<$in>) {
      if ($line =~ /^msgid\s+\"(.*)\"$/) {
        $id = $1;
        $mode = 1;
      }
      elsif ($line =~ /^msgstr(.*)\s+\"(.*)\"$/) {
        $str = $2;
        $mode = 2;
      }
      elsif ($line =~ /^\"(.*)\"$/ && $mode == 1) {
        $id .= $1;
      }
      elsif ($line =~ /^\"(.*)\"$/ && $mode == 2) {
        $str .= $1;
      }
      elsif ($id && $str) {
        $translate{$id} = $str;
        $id = "";
        $str = "";
        $mode = 0;
      }
    }
    close ($in);


find sub {
    my $file = $_;
    my $path = $File::Find::name;
    push (@files, $path);
}, "$cddadir/data/json";

foreach my $file (@files) {
    if (-d $file) {
      print "skip : $file\n";
      next;
    }
    if ($file =~ /\.([^\.]*)$/) {
      if ($1 ne "json") {
        print "skip : $file\n";
        next;
      }
    }
    else {
      print "skip : $file\n";
      next;
    }
    print "$file\n";
    
    my $all_lines;
    open ($in, "<$file");
    {
      # 読み込む際のレコードセパレータをundefにすると
      # ファイルのすべての内容を一度に読み取ることができます。
      local $/ = undef; 
                          
      $all_lines = readline $in;
    }
    close ($in);

    my $json_text = $all_lines;
    my $json2ref = decode_json( encode('utf-8', $json_text) ); # リファレンスに変換

    if (ref($json2ref) eq "ARRAY") {
      foreach $elem (@$json2ref) {
          my $name = $elem->{"name"};
          my $description = $elem->{"description"};
          if ($name) {
              if ($translate{$name}) {
                $elem->{"name"} = $translate{$name};
                #print $translate{$name};
              }
          }
          if ($description) {
              if ($translate{$description}) {
                $elem->{"description"} = $translate{$description};
                #print $translate{$description};
              }
          }
      }
    }
    elsif (ref($json2ref) eq "HASH") {
          my $name = $elem->{"name"};
          my $description = $elem->{"description"};
          if ($name) {
              if ($translate{$name}) {
                $elem->{"name"} = $translate{$name};
                #print $translate{$name};
              }
          }
          if ($description) {
              if ($translate{$description}) {
                $elem->{"description"} = $translate{$description};
                #print $translate{$description};
              }
          }
    }

    my $j = JSON->new->pretty(1); 
    my $json_text = $j->encode( $json2ref ) ;
    mkpath(dirname("$file"));
    open ($out, ">$file");
    print $out $json_text;
    close $out;
}

