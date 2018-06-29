#! /usr/bin/env perl
#
# Author Shlomi Fish <shlomif@cpan.org>
use strict;
use warnings;
use Path::Tiny qw/ path /;

use vars qw/ %sol %imp /;

BEGIN
{
    my $buf = path("solve-more-3-log.txt")->slurp_utf8;
    $buf =~ s#Trying deal = ([0-9]+) using 0AB\n\n?I could not solve this game.#
        $imp{$1} = 1;
        #egms;
    $buf =~ s#Trying deal = ([0-9]+) using 0AB\n\n?This game is solveable.#
        $sol{$1} = 1;
        #egms;
}
if ( my ($n) = /\AInt\t([0-9]+)\n\z/ )
{
    if ( exists $sol{$n} )
    {
        s/Int/S/;
    }
    elsif ( exists $imp{$n} )
    {
        $_ = '';
    }
}
