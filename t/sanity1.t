#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

{
    my $LOG_FN = '0fc-log.txt';

    # TEST
    is( scalar(`grep -vcE '^(S|Int)\t[1-9][0-9]*\$' "$LOG_FN"`),
        "0\n", "all lines match." );

    my $NUMS = qq%< "$LOG_FN" $^X -lanE 'say \$F[-1]'%;

    # TEST
    is( scalar(`$NUMS`), scalar(`$NUMS | sort -n -u`), "Lines are sorted.", );
}
