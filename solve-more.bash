#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@telaviv1.shlomifish.org>
#
# Distributed under terms of the MIT license.
#

pi-make-microsoft-freecell-board -t 14994542 | fc-solve --freecells-num 0 -sam -p -t -sel -me random-dfs -to '[0AB]' -seed 9 -sp r:tf -mi 2000000 # | verify-solitaire-solution --freecells-num 0
pi-make-microsoft-freecell-board -t 1214065 | fc-solve -l lg --freecells-num 0 -sam -p -t -sel | verify-solitaire-solution --freecells-num 0
pi-make-microsoft-freecell-board -t 5430607 | fc-solve -l lg --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
# pi-make-microsoft-freecell-board -t 5666087 | fc-solve -l tfts --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
pi-make-microsoft-freecell-board -t 7432951 | fc-solve --freecells-num 0 -sam -p -t -sel -to 01ABCDE -sp r:tf -mi 6000000 # | verify-solitaire-solution --freecells-num 0
pi-make-microsoft-freecell-board -t 8011868 | fc-solve -l lg --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
