#! /bin/bash
#
# time-zero-fc-mode.bash
# Copyright (C) 2020 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

(
    set -e -x
    set -o pipefail
    time bash solve-more-6-gnupar.bash | timestamper
) 2>&1 | tee -a ~/log1.txt
