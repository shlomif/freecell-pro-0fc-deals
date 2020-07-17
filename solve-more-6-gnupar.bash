#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
#

. solve_common.bash

min_required_ram="$((30 * 1000 * 1000))"
if ! perl ./check-for-required-ram.pl "$min_required_ram"
then
    exit 1
fi

# d 58844 ab
# d 96924 ab
# d 99673 ab
# d 100260 ab
back_to_246e7_deals='false'

out='solve-more-11--4e9--log.txt'
export MINSTART="$((40 * 10 ** 8))"
if $back_to_246e7_deals
then
    out='solve-more-12--246e7--log.txt'
    export MINSTART="$((246 * 10 ** 7))"
fi
export START="$(tail -1000 "$out" | grep -E '^(Trying deal =|[0-9]+ =)' | tail-extract '^(?:Trying deal = )?([0-9]+)' -)"
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
    parallel --group -j"${NUM_CPUS:-2}" -k bash run-job-3.bash 2>&1 | \
    log_sink
}
    # perl -E 'while(my $l=<>){chomp$l;system("summary-fc-solve", $l, qw(-- --freecells-num 0 -to 0AB -sp r:tf -mi),$ENV{MAX_ITERS});}' 2>&1 | \
f2()
{
    gen_deals |
    ( while read l; do summary-fc-solve "$l" -- --freecells-num 0 -to 0AB -sp r:tf -mi "$MAX_ITERS"; done ) 2>&1 | \
    log_sink
}
export MAX_ITERS="$((30 * 10 ** 6))"
f1
