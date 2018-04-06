#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

{
    my $LOG_FN = '0fc-log.txt';

    # TEST
    is( scalar(`grep -vcE '^(S|Int)\t[1-9][0-9]*\$' "$LOG_FN"`),
        "0\n", "all lines match." );
}
