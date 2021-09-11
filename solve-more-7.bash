#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
#

export MAX_ITERS="${MAX_ITERS:-30000000}"
. solve_common.bash

# d 58844 ab
# d 96924 ab
# d 99673 ab
# d 100260 ab
out='solve-more-7-log.txt'
export START="$(tail-extract '^Trying deal = ([0-9]+)' "$out")"
# min=1000000000
min=3000000000
if test "$START" -lt "$min"
then
    START="$min"
fi
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 >= $ENV{START}' | \
    (while read deal
    do
        # d "$deal" ab_tail
        d "$deal" dbm_tail
    done) 2>&1 | \
    tee -a "$out"
