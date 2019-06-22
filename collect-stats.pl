#
# inc-nums.cpp
# Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

use strict;
use warnings;

my $S = 0;
my $J = 0;
while (<>)
{
    ++( substr( $_, 0, 1 ) eq 'S' ? $S : $J );
}
print "S\t$S\nInt\t$J\n";
