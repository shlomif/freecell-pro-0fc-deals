#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@telaviv1.shlomifish.org>
#
# Distributed under terms of the MIT license.
#

pi-make-microsoft-freecell-board -t 1214065 | fc-solve -l lg --freecells-num 0 -sam -p -t -sel | verify-solitaire-solution --freecells-num 0
pi-make-microsoft-freecell-board -t 5430607 | fc-solve -l lg --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
# pi-make-microsoft-freecell-board -t 5666087 | fc-solve -l tfts --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
pi-make-microsoft-freecell-board -t 7432951 | fc-solve --freecells-num 0 -sam -p -t -sel -to 01ABCDE -mi 6000000 # | verify-solitaire-solution --freecells-num 0
