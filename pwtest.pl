#!/usr/bin/perl -w

use strict;                   # 'strict' insists that all variables be declared
use diagnostics;              # 'diagnostics' expands the cryptic warnings
use Encode;

#use lib $ENV{HOME} . '/public_html/wp/perlwikipedia/trunk'; # path to perl modules
use Perlwikipedia; #Note that the 'p' is capitalized, due to Perl style

use lib $ENV{HOME} . '/public_html/wp/modules'; # path to perl modules

require 'bin/perlwikipedia_utils.pl';
require 'bin/fetch_articles_cats.pl';
require 'bin/html_encode_decode_string.pl';
require 'bin/get_html.pl';
require 'bin/language_definitions.pl';

undef $/;		      # undefines the separator. Can read one whole file in one scalar.
$| = 1; # flush the buffer each line

my %Dictionary   = &language_definitions();
my $Lang         = $Dictionary{'Lang'};
my $Wiki_http    = 'http://' . $Lang . '.wikipedia.org';

MAIN:{

  my ($sleep, $attempts, $cat, @cats, $article, @articles, $text, $edit_summary, $bot_page, %ids, $link, $id, $hold);
  my ($error, $local, $is_minor);

  my $user = 'Mathbot';
  my $editor=&wikipedia_login($user);

  $attempts = 5; $sleep = 1;

  $bot_page = 'User:Mathbot/Page3';
  #$bot_page = 'User:Mathbot/' . $article;
  #$bot_page = 'User:Mathbot/' . 'A&M';
  $bot_page = 'Testing & ampersand issues';
  print "$bot_page\n";

  $text = wikipedia_fetch($editor, $bot_page, $attempts, $sleep);
  $text = $text . "A bot test";

  $is_minor = 0; 
  $edit_summary = "A test";

  #&wikipedia_submit($editor, $bot_page, $edit_summary, $text, $attempts, $sleep);
  $editor->edit($bot_page, $text, $edit_summary, $is_minor);
  exit(0);
  $cat = 'Category:French mathematicians';
  &fetch_articles_cats($cat, \@cats, \@articles);

  $text = "";
  foreach $article (@articles){
    $text .= '* [[' . $article . ']]' . "\n";
    if ($article =~ /claude/i){
      $local = $article;
      last;
    }
  }
  $article = $local;
  print "$article\n";

  #  $text=$editor->get_text($article);
  #  $text = Encode::encode('utf8', $text);

  $text = 'testing4' . '[[' . $article . ']]' . $text;
  print "$text\n";

  
  exit(0);
  
#   ($text, $error) = &get_html ($link);

  #  exit(0);
#  $bot_page = "Texas A%26M articles by quality.wiki";
#  #$bot_page = "User:Mathbot/Page3.wiki";

#  $attempts = 5; $sleep = 1; 
#  $text = &wikipedia_fetch($bot_page, $attempts, $sleep);

#  $text .= "A bot test, will revert right away";
#  $edit_summary = "A bot test";
#  &wikipedia_submit($bot_page, $edit_summary, $text, $attempts, $sleep);
  
}

