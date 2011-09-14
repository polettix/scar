#!/usr/bin/env perl 
use strict;
use warnings;
use English qw( -no_match_vars );
use 5.012;
use autodie;
use Encode qw( encode decode );
use File::Basename qw( basename dirname );

sub urlencode_b {
   (my $bytes = shift) =~ s{([^-\w.~/])}{'%' . unpack('H*', $1)}gemxs;   
   return $bytes;
}

sub urldecode_b {
   (my $bytes = shift) =~ s{%([[:xdigit:]]{2})}{pack('C0H*', $1)}gemxs;
   return $bytes;
}

sub urlencode {
   my ($uri, $encoding) = @_;
   $encoding ||= 'utf8';
   return urlencode_b(encode($encoding => $uri));
}

sub urldecode {
   my ($euri, $encoding) = @_;
   $encoding ||= 'utf8';
   return decode($encoding => urldecode_b($euri));
}

{
   my ($chars, %entity_for);
   sub html_text {
      my ($text) = @_;

      if (! defined $chars) {
         my $entities = <<'END_OF_ENTITIES';
& amp
> gt
< lt
" quot
' apos
END_OF_ENTITIES
         %entity_for = map {
            my ($char, $entity) = split /\s+/;
            $char => "&$entity;";
         } split /\n/, $entities;
         $chars = '[' . join('', keys %entity_for) . ']';
      }

      $text =~ s{($chars)}{$entity_for{$1}}gemxs;

      return $text;
   }
}

my $smiley = "\x{263a}";
$smiley = pack 'U', 0x263a;

binmode STDOUT, ':utf8';

my $path = "/path/to/t\x{263a}w<";
say $path;
say urlencode($path);
say urldecode(urlencode($path));
say "done";

say basename($path);
say html_text(basename($path));


opendir my $dh, '.';
for my $item (readdir $dh) {
   say "item: [$item] - length ", length($item), '/', length(encode(utf8 => $item));
}
