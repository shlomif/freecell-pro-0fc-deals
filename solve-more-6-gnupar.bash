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
out='solve-more-8--1e9--log.txt'
export START="$(tail -1000 "$out" | grep -E '^(Trying deal =|[0-9]+ =)' | tail-extract '^(?:Trying deal = )?([0-9]+)' -)"
START="${START:-1200000000}"
if test "$START" -lt 1200000000
then
    START=1200000000
fi
f1()
{
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 > $ENV{START}' | \
    parallel --group -j8 -k bash run-job-1.bash 2>&1 | \
    tee -a "$out"
}
# f1
    # perl -E 'while(my $l=<>){chomp$l;system("summary-fc-solve", $l, qw(-- --freecells-num 0 -to 0AB -sp r:tf -mi),$ENV{MAX_ITERS});}' 2>&1 | \
f2()
{
export MAX_ITERS=6000000
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 > $ENV{START}' | \
    ( while read l; do summary-fc-solve "$l" -- --freecells-num 0 -to 0AB -sp r:tf -mi "$MAX_ITERS"; done ) 2>&1 | \
    tee -a "$out"
}
f1
