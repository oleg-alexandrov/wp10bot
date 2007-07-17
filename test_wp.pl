#!/usr/bin/perl -w
use strict;		      # 'strict' insists that all variables be declared
use diagnostics;	      # 'diagnostics' expands the cryptic warnings

# Some Wikipedia articles are categorized by quality.  Go through those categories, get a list of all such articles,
# and print them out in tables, sectioned by category. Also write a log of what happened, and this is the hardest. 
# See http://en.wikipedia.org/wiki/Wikipedia:Version_1.0_Editorial_Team/Index for more details.

# All the code is actually in wp10_routines.pl which we load and call below.
# It is convenient to keep things that way so that those routines can also be called from a CGI script.
require $ENV{HOME} . '/public_html/cgi-bin/wp/wp10/wp10_routines.pl'; 

$| = 1; # flush the buffer each line

MAIN:{

  my $subject_category = 'Category:Musical Theatre articles by quality';
  my $file = $subject_category; $file =~ s/^Category:(.*?)$/Wikipedia:Version 1.0 Editorial Team\/$1 log/g;
  my $todays_log = "";
  my $list = "";

  print "$file\n";
  print "$subject_category\n";
  &process_log ($file, $todays_log, $subject_category, $list);
}



