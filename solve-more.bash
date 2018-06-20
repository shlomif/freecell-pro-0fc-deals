#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
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
    _sol -to 0AB -sp r:tf -mi 32000000
}

lg()
{
    echo "Trying deal = $deal using lg"
    _sol -l lg -mi 4000000 2>/dev/null | verify-solitaire-solution --freecells-num 0
}

rand()
{
    echo "Trying deal = $deal using rand"
    _sol -me random-dfs -seed "$seed" -to '[0AB]' -sp r:tf -mi 8000000 | verify-solitaire-solution --freecells-num 0
}

d()
{
    local mydeal="$1"
    shift
    s "$mydeal"
    local seed_s="$1"
    if [[ "$seed_s" = 'seed='* ]]
    then
        shift
        eval "$seed_s"
    fi
    for method in "$@"
    do
        "$method"
    done
}

# d 58844 ab
# d 96924 ab
# d 99673 ab
d 100260 ab
exit
d 1214065 lg
d 5430607 lg
d 7432951 ab
d 8011868 lg
d 351098357 lg
d 459095946 lg
d 513097572 ab
d 1861387481 seed=1 rand
d 3639995818 ab
# pi-make-microsoft-freecell-board -t 14994542 | fc-solve --freecells-num 0 -sam -p -t -sel -me random-dfs -to '[0AB]' -seed 9 -sp r:tf -mi 2000000 # | verify-solitaire-solution --freecells-num 0
# pi-make-microsoft-freecell-board -t 5666087 | fc-solve -l tfts --freecells-num 0 -sam -p -t -sel -mi 2000000 | verify-solitaire-solution --freecells-num 0
