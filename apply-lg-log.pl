#! /usr/bin/env perl
#
# Short description for apply-lg-log.pl
#
# Author Shlomi Fish <shlomif@cpan.org>
use strict;
use warnings;

use vars qw/ %h /;

BEGIN
{
    open my $i, '<', '0fc-log.lg-compress.txt';
    while ( my $l = <$i> )
    {
        chomp $l;
        if ( $l =~ /\AS\t([0-9]+)\z/ )
        {
            $h{$1} = 1;
        }
    }
}
s/Int/S/ if /\AInt\t([0-9]+)\z/ && exists $h{$1};
