#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
#
export MAX_ITERS="${MAX_ITERS:-3000000}"

. solve_common.bash

# d 58844 ab
# d 96924 ab
# d 99673 ab
# d 100260 ab
out='solve-more-7--7e9--log.txt'
export START="$(tail -1000 "$out" | grep -E '^Trying deal =' | tail-extract '^Trying deal = ([0-9]+)' -)"
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 > $ENV{START}' | \
    parallel --group -j4 -k bash run-job-2.bash 2>&1 | \
    tee -a "$out"
