#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw/ sum /;
my %stats;
while (<>)
{
    ++$stats{ substr( $_, 0, 1 ) };
}
$stats{Int} = delete $stats{I};
my $tot    = ( 1 << 33 ) - 1;
my $remain = $tot - sum values %stats;
$stats{Imp} = $remain;
foreach my $rec ( [ 'Solved', 'S' ], [ 'Intractable', 'Int' ],
    [ 'Impossible', 'Imp' ] )
{
    my ( $txt, $key ) = @$rec;
    my $val   = $stats{$key};
    my $ratio = $val / $tot;
    my $pct   = 100 * $ratio;
    printf "%s: %d ( %.2f %%)\n", $txt, $val, $pct;
}
