#! /bin/bash
#
# solve_common.bash
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

export MAX_ITERS="${MAX_ITERS:-32000000}"

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
    _sol -to 0AB -sp r:tf -mi "$MAX_ITERS"
}

ab_tail()
{
    echo "Trying deal = $deal using 0AB"
    _sol -to 0AB -sp r:tf -mi "$MAX_ITERS" | tail -3
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
