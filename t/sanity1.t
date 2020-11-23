#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

{
    my @log_fns = glob("0fc-logs/*.log.txt");

    # TEST
    like( scalar(`grep -cvhE '^(S|Int)\t[1-9][0-9]*\$' -- @log_fns`),
        qr#\A(?:0\n?)+\z#ms, "all lines match." );

    # TEST
    is( scalar( system( "./inc.exe", @log_fns ) ), 0, "Lines are sorted.", );
}
