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
out='solve-more-4-log.txt'
export START="$(tail-extract '^Trying deal = ([0-9]+)' "$out")"
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 >= $ENV{START} && $1 >= 1e9' | \
    (while read deal
    do
        d "$deal" ab_tail
        # d "$deal" dbm_tail
    done) 2>&1 | \
    tee -a "$out"
