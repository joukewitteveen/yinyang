#! /usr/bin/perl

my $open	= '([{';
my $close	= ')]}';
my @stack;
my @lines;

while (<>) {
  while (/([\Q$open$close\E])/g) {
    if ((index $close, $1) < 0) {
      push @lines, $.;
      push @stack, $1;
    } elsif (pop @lines, pop @stack ne substr $open, (index $close, $1), 1) {
      chomp;
      print "Unmatched $1 on line $.:\n> $_\n";
      exit 1;
    }
  }
}

foreach (@stack) {
  print "Unmatched $_ on line ", shift @lines, "\n";
}
exit 1 if @stack;

