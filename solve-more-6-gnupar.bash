#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
#

. solve_common.bash

# d 58844 ab
# d 96924 ab
# d 99673 ab
# d 100260 ab
out='solve-more-8--3e9--log.txt'
export START="$(tail -1000 "$out" | grep -E '^(Trying deal =|[0-9]+ =)' | tail-extract '^(?:Trying deal = )?([0-9]+)' -)"
START="${START:-3000060774}"
f1()
{
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 > $ENV{START}' | \
    parallel --group -j4 -k bash run-job-3.bash 2>&1 | \
    tee -a "$out"
}
    # perl -E 'while(my $l=<>){chomp$l;system("summary-fc-solve", $l, qw(-- --freecells-num 0 -to 0AB -sp r:tf -mi),$ENV{MAX_ITERS});}' 2>&1 | \
f2()
{
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 > $ENV{START}' | \
    ( while read l; do summary-fc-solve "$l" -- --freecells-num 0 -to 0AB -sp r:tf -mi "$MAX_ITERS"; done ) 2>&1 | \
    tee -a "$out"
}
export MAX_ITERS=10000000
f1
