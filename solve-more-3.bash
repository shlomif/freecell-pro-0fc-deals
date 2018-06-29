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

ab_tail()
{
    echo "Trying deal = $deal using 0AB"
    _sol -to 0AB -sp r:tf -mi 32000000 | tail -3
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
# d 100260 ab
out='solve-more-3-log.txt'
export START="$(tail-extract '^Trying deal = ([0-9]+)' "$out")"
< 0fc-log.txt perl -lnE 'say $1 if /\AInt\t([0-9]+)\z/ && $1 >= $ENV{START}' | \
    (while read deal
    do
        d "$deal" ab_tail
    done) 2>&1 | \
    tee -a "$out"
