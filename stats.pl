#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw/ sum /;

my @log_fns = ( @ARGV ? @ARGV : glob("0fc-logs/*.log.txt") );
my %stats   = split /\s+/, `./colstat.exe @log_fns`;

# my %stats = split /\s+/, `perl collect-stats.pl @log_fns`;
# my %stats  = split /\s+/, `pypy collect-stats.py @log_fns`;
# my %stats  = split /\s+/, `python2 collect-stats.py @log_fns`;
my $tot    = ( ( 1 << 33 ) - 1 );
my $remain = $tot - sum values %stats;
$stats{Imp} = $remain;
foreach my $rec ( [ 'Solved', 'S' ], [ 'Intractable', 'Int' ],
    [ 'Impossible', 'Imp' ] )
{
    my ( $txt, $key ) = @$rec;
    my $val   = $stats{$key};
    my $ratio = $val / $tot;
    my $pct   = 100 * $ratio;
    printf "%s: %d ( %.4f %%)\n", $txt, $val, $pct;
}
