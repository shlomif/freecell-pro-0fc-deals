#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
#
fcs_wrapper='valgrind '
. solve_common.bash

# d 58844 ab
# d 96924 ab
# d 99673 ab
# d 100260 ab
out='solve-more-3-log.txt'
export START="$(tail-extract '^Trying deal = ([0-9]+)' "$out")"
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 >= $ENV{START}' | \
    (while read deal
    do
        d "$deal" ab_tail
    done) 2>&1 | \
    tee -a "$out"
