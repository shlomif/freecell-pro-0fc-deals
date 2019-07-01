#! /usr/bin/env bash
#
# run-job-1.bash
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

export MAX_ITERS=3000000
__deal="$1"
shift
. solve_common.bash
deal="$__deal"
d "$deal" ab_tail
