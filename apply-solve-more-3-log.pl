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
    my @lines = split /^/ms, $buf;

LIN:
    for ( my $i = 0 ; $i < @lines ; ++$i )
    {
        my $l = $lines[$i];
        if ( my ($deal) = $l =~ /\ATrying deal = ([0-9]+) using dbm\n?\z/ )
        {
            my $text = $l;
            ++$i;
        INNER:
            while ( $i < @lines )
            {
                $text .= ( $l = $lines[$i] );
                if ( $l =~ /\ATrying deal = [0-9]+\n?\z/ )
                {
                    --$i;
                    if ( $text =~ /^Could not solve successfully\.$/ms )
                    {
                        $imp{$deal} = 1;
                    }
                    last INNER;
                }
            }
            continue
            {
                ++$i;
            }
        }
    }
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
