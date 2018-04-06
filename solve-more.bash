#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@telaviv1.shlomifish.org>
#
# Distributed under terms of the MIT license.
#

deal=1
s()
{
    deal="$1"
    shift

    echo "Trying deal = $deal"
}

ab()
{
    echo "Trying deal = $deal using 0AB"
    pi-make-microsoft-freecell-board -t "$deal" | fc-solve --freecells-num 0 -sam -p -t -sel -to 0AB -sp r:tf -mi 6000000
}

lg()
{
    echo "Trying deal = $deal using lg"
    pi-make-microsoft-freecell-board -t "$deal" | fc-solve -l lg --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
}

s 5430607 ; lg
s 1214065 ; lg
s 8011868 ; lg
s 7432951 ; ab
# pi-make-microsoft-freecell-board -t 14994542 | fc-solve --freecells-num 0 -sam -p -t -sel -me random-dfs -to '[0AB]' -seed 9 -sp r:tf -mi 2000000 # | verify-solitaire-solution --freecells-num 0
# pi-make-microsoft-freecell-board -t 5666087 | fc-solve -l tfts --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
