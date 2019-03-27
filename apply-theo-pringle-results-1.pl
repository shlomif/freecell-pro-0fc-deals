#! /usr/bin/env perl
#
# Author Shlomi Fish <shlomif@cpan.org>
use strict;
use warnings;
use integer;
use Path::Tiny qw/ path /;

use vars qw/ %sol %intr /;

sub _key
{
    return int( shift() / 1e8 );
}

foreach my $l (
    path("freecell-pro-0fc-deals/intractable-deals-up-to-100-million.txt")
    ->lines_raw )
{
    chomp $l;
    $intr{ _key($l) }{$l} = 1;
}
foreach
    my $l ( path("freecell-pro-0fc-deals/winnable-deals-up-to-100-million.txt")
    ->lines_raw )
{
    chomp $l;
    $sol{ _key($l) }{$l} = 1;
}

EDIT:
foreach my $fh ( path('./0fc-logs/')->children(qr/\.log\.txt\z/) )
{
    my $key = $fh->basename =~ s/\.log\.txt\z//r;
    $key = int $key;
    next EDIT if not( exists $intr{$key} or exists $sol{$key} );
    $fh->edit_lines_utf8(
        sub {
            if ( my ($n) = /\AInt\t([0-9]+)\n\z/ )
            {
                if ( exists $sol{$key}{$n} )
                {
                    s/Int/S/;
                }
                elsif ( $n < 1e8 and ( !exists $intr{$key}{$n} ) )
                {
                    $_ = '';
                }
            }
            return;
        },
    );
}
