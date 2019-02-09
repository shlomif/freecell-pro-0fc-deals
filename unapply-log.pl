#! /usr/bin/env perl
#
# Author Shlomi Fish <shlomif@cpan.org>
use strict;
use warnings;
use integer;
use Path::Tiny qw/ path /;
use List::Util qw/ uniq /;

use vars qw/ %sol %intractables /;

sub _key
{
    return int( shift() / 1e8 );
}

foreach my $fn ( "bad--solve-more-3-log.txt", "bad--solve-more-4-log.txt" )
{
    my $buf = path($fn)->slurp_utf8;
    $buf =~ s#Trying deal = ([0-9]+) using 0AB\n\n?I could not solve this game.#
        $intractables{_key($1)}{$1} = 1;
        #egms;
}

EDIT:
foreach my $fh ( path('./0fc-logs/')->children(qr/\.log\.txt\z/) )
{
    my $key = $fh->basename =~ s/\.log\.txt\z//r;
    $key = int $key;
    next EDIT if not( exists $intractables{$key} or exists $sol{$key} );
    $fh->edit_utf8(
        sub {
            $_ = join "",
                map  { "$_\n" }
                sort { $a =~ s/.*\t//r <=> $b =~ s/.*\t//r }
                uniq( ( split /\n/, $_ ),
                map { "Int\t$_" } keys( %{ $intractables{$key} } ) );
            return;
        },
    );
}
