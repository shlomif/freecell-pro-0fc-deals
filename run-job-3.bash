#! /usr/bin/env bash
#
# run-job-1.bash
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

__deal="$1"
shift
deal="$__deal"
summary-fc-solve "$deal" -- --freecells-num 0 -to 0AB -sp r:tf -mi "$MAX_ITERS"
