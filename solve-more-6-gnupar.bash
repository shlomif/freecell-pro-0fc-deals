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
out='solve-more-10--0e9--log.txt'
export START="$(tail -1000 "$out" | grep -E '^(Trying deal =|[0-9]+ =)' | tail-extract '^(?:Trying deal = )?([0-9]+)' -)"
export MINSTART=600000000
START="${START:-$MINSTART}"
if test "$START" -lt "$MINSTART"
then
    START="$MINSTART"
fi
gen_deals()
{
    < 0fc-log.txt perl -lnE 'if (my ($deal) = /\AInt\t([0-9]+)\z/){ if ($deal > $ENV{START}) { say $deal;} }'
}
log_sink()
{
    tee -a "$out"
}
f1()
{
    gen_deals |
    parallel --group -j"${NUM_CPUS:-4}" -k bash run-job-3.bash 2>&1 | \
    log_sink
}
    # perl -E 'while(my $l=<>){chomp$l;system("summary-fc-solve", $l, qw(-- --freecells-num 0 -to 0AB -sp r:tf -mi),$ENV{MAX_ITERS});}' 2>&1 | \
f2()
{
    gen_deals |
    ( while read l; do summary-fc-solve "$l" -- --freecells-num 0 -to 0AB -sp r:tf -mi "$MAX_ITERS"; done ) 2>&1 | \
    log_sink
}
export MAX_ITERS=10000000
f1
