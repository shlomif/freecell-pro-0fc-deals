#! /usr/bin/env perl
#
# Author Shlomi Fish <shlomif@cpan.org>
use strict;
use warnings;
use integer;
use autodie;
use 5.014;

use Path::Tiny qw/ path /;

use vars qw/ %sol %imp /;

sub _key
{
    return int( shift() / 1e8 );
}

# "solve-more-7-log.txt", "solve-more-7--4e9--log.txt",
# "solve-more-7--6e9--log.txt",
# "solve-more-7--7e9--log.txt", "solve-more-7--8e9--log.txt",
# "solve-more-3-log.txt", "solve-more-3--1e9--log.txt",
# "solve-more-4-log.txt", )
# foreach my $fn ( "solve-more-8--5e9--log.txt", "solve-more-8--6e9--log.txt", )
foreach my $fn ( "solve-more-9--0e9--log.txt", )
{
    my $buf = path($fn)->slurp_utf8;
    $buf =~ s#Trying deal = ([0-9]+) using 0AB\n\n?I could not solve this game.#
        $imp{_key($1)}{$1} = 1;
        #egms;
    $buf =~ s#Trying deal = ([0-9]+) using 0AB\n\n?This game is solveable.#
        $sol{_key($1)}{$1} = 1;
        #egms;
    my @lines = split /^/ms, $buf;

LIN:
    for ( my $i = 0 ; $i < @lines ; ++$i )
    {
        my $l = $lines[$i];
        if ( my ( $deal, $verdict ) =
            $l =~
/\A([0-9]+) = Verdict: (Unsolved|Solved) ; Iters: [0-9]+ ; Length: -?[0-9]*\s*\n?\z/
            )
        {

            if ( $verdict eq "Unsolved" )
            {
                $imp{ _key($deal) }{$deal} = 1;
            }
            else
            {
                $sol{ _key($deal) }{$deal} = 1;
            }
            next LIN;
        }
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
                        $imp{ _key($deal) }{$deal} = 1;
                    }
                    elsif ( $text =~ /^END$/ms )
                    {
                        $sol{ _key($deal) }{$deal} = 1;
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

EDIT:
foreach my $fh ( path('./0fc-logs/')->children(qr/\.log\.txt\z/) )
{
    my $key = $fh->basename =~ s/\.log\.txt\z//r;
    $key = int $key;
    next EDIT if not( exists $imp{$key} or exists $sol{$key} );
    $fh->edit_lines_utf8(
        sub {
            if ( my ($n) = /\AInt\t([0-9]+)\n\z/ )
            {
                if ( exists $sol{$key}{$n} )
                {
                    s/Int/S/;
                }
                elsif ( exists $imp{$key}{$n} )
                {
                    $_ = '';
                }
            }
            return;
        },
    );
}
