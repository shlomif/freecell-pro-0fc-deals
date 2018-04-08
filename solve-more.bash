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

_sol()
{
    pi-make-microsoft-freecell-board -t "$deal" | fc-solve --freecells-num 0 -sam -p -t -sel "$@"
}

ab()
{
    echo "Trying deal = $deal using 0AB"
    _sol -to 0AB -sp r:tf -mi 6000000
}

lg()
{
    echo "Trying deal = $deal using lg"
    _sol -l lg -mi 2000000 | verify-solitaire-solution --freecells-num 0
}

d()
{
    local mydeal="$1"
    shift
    s "$mydeal"
    for method in "$@"
    do
        "$method"
    done
}

d 1214065 lg
d 5430607 lg
d 7432951 ab
d 8011868 lg
d 351098357 lg
d 459095946 lg
# pi-make-microsoft-freecell-board -t 14994542 | fc-solve --freecells-num 0 -sam -p -t -sel -me random-dfs -to '[0AB]' -seed 9 -sp r:tf -mi 2000000 # | verify-solitaire-solution --freecells-num 0
# pi-make-microsoft-freecell-board -t 5666087 | fc-solve -l tfts --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
