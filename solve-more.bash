#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@telaviv1.shlomifish.org>
#
# Distributed under terms of the MIT license.
#

pi-make-microsoft-freecell-board -t 1214065 | fc-solve -l lg --freecells-num 0 -sam -p -t -sel | verify-solitaire-solution
--freecells-num 0
