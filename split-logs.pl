#!/usr/bin/env perl

use strict;
use warnings;

use vars qw/ $s $e $o $P /;

BEGIN
{

    sub f
    {
        $s = $P * 1e8;
        $e = ( $P + 1 ) * 1e8 - 1;
        my $fn = ( sprintf "0fc-logs/%02d.log.txt", $P );
        warn $fn;
        open $o, ">", $fn;
    }
    $P = 0;
    f;
}
if ( $F[1] >= $s && $F[1] <= $e )
{
    $o->say($_);
}
else
{
    ++$P;
    f;
    redo;
}

END
{
    close $o;
}
