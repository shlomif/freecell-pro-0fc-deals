#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw/ sum /;
my %stats;
while ( my $l = <> )
{
    chomp $l;
    my @f = split /\t/, $l;
    ++$stats{ $f[0] };
}
print "Solved: $stats{S}\nIntractable: $stats{Int}\nImpossible: ",
    ( ( 1 << 33 ) - 1 - sum values %stats ), "\n";

