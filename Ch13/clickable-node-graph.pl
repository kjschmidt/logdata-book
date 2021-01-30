#!/usr/bin/perl

#
# Author: Jimmy Alderson
#
use GraphViz::Small;
my%dst_hash = ();
my%edge_hash = ();
my $g = GraphViz::Small->new(layout => ‘neato’, bgcolor => ‘black’);
while ($line = <STDIN>){
 chomp($line);
 undef($sip);
 undef($dst);
 undef($count);
 if(($sip,$dst,$count) = $line =∼ m/^([^ ]+) ([^ ]+) (\d+)/) {
   ($port) = $dst =∼ m/:(\d+)/;
   ($dip) = $dst =∼ m/(\d+):/;
   if(!exists($sip_hash{$sip})) {
    $g->add_node(“$sip”, URL =>   “$sip.html”, tooltip => “$sip”, style => ‘filled’, fillcolor => ‘red’,);
    $sip_hash{$sip} = 1;
   } else {
    $sip_hash{$sip}++;
   }

  if(!exists($dst_hash{$dst})){
    $color = get_fill_color($port);
    $color2 = get_border_color($port);
    $g->add_node(name =>”$dst”, URL => “$dst.html”, tooltip => “$dst”, style => ‘filled’, color => “$color2”, fillcolor => “$color”, cluster => “$port”, rank => “$port”);
    $dst_hash{$dst} = 1;
   } else {
    $dst_hash{$dst}++;
   }
   $edge_hash{“$sip-$count#$dst”} = 1;
  }
 }

 foreach $edge (keys%edge_hash) {
  if(($s, $c, $d) = $edge =∼ m/([^-]+)-(\d+)\#(.+)/) {
   ($port) = $d =∼ m/:(\d+)/;
   ($dip) = $d =∼ m/(\d+):/;
   $color = get_fill_color($port);
   $g->add_edge(“$s” => “$d”, color => “$color”, minlen => “$c”);
  }
 }

 open(FH, ”>map.html”);
 print FH ‘<HTML><BODY BGCOLOR=black><img src=“map.png” usemap=“#map”><map name=“map”>’;
 print FH $g->as_cmap;
 print FH ‘</map></body></html>’;
 close(FH);
 print $g->as_png;
 
 sub get_fill_color {
  my $port = shift;
  my $control = ‘magenta’;
  my $web = ‘white’;
  my $email = ‘yellow’;
  my $encrypted = ‘green’;
  my $ftp = ‘pink’;
  my $netbios = ‘blue’;
  my $console = ‘cyan’;
  my $proxy = ‘orange’;
  my $db = ‘green’;
  my $suspect = ‘red’;
  my $chat = $suspect;
  my%colors = ();

  $colors{’0’} = $control;
  $colors{’21’} = $ftp;
  $colors{’20’} = $ftp;
  $colors{’23’} = $console;
  $colors{’25’} = $email;
  $colors{’53’} = ‘#00FF00’;;
  $colors{’80’} = $web;
  $colors{’443’} = $web;
  $colors{’135’} = $netbios;
  $colors{’139’} = $netbios;
  $colors{’161’} = $control;
  $colors{’1433’} = $db;
  $colors{’1434’} = $db;
  $colors{’1080’} = $proxy;
  $colors{’5190’} = $chat;
  $colors{’8080’} = $proxy;
  $colors{’6000’} = $console;
  $colors{’6667’} = $chat;
  $colors{’31337’} = ‘gold’;
  if(exists($colors{$port})) {
   return $colors{$port};
  }
  return ‘lightblue’;
 }

 sub get_border_color {
  my $port = shift;
  my $encrypted = ‘green’;
  my $unencrypted = ‘yellow’;
  my%colors = ();

  $colors{’0’} = $unencrypted;
  $colors{’22’} = $encrypted;
  $colors{’23’} = $unencrypted;
  $colors{’25’} = $unencrypted;
  $colors{’53’} = $unencrypted;
  $colors{’80’} = $unencrypted;
  $colors{’443’} = $encrypted;
  $colors{’135’} = $unencrypted;
  $colors{’139’} = $unencrypted;
  $colors{’1433’} = $unencrypted;
  $colors{’5190’} = $unencrypted;
  $colors{’6000’} = $unencrypted;
  $colors{’6667’} = $unencrypted;
  if(exists($colors{$port})) {
   return $colors{$port};
  }
 }
