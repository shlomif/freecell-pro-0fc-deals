#! /bin/bash
#
# solve_common.bash
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

export MAX_ITERS="${MAX_ITERS:-3200000000000}"

deal=1
should_notify="true"
use_filter="true"
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

dbm()
{
    echo "Trying deal = $deal using dbm"
    depth-dbm-fc-solver --do-not-yield-solution 1 --iters-delta-limit "$MAX_ITERS" --offload-dir-path $PWD/offload/ <(pi-make-microsoft-freecell-board -t "$deal")
}

dbm_tail()
{
    echo "Trying deal = $deal using dbm"
    local offd="$PWD/offload/deal$deal"
    mkdir -p "$offd"
    depth-dbm-fc-solver --iters-delta-limit "$MAX_ITERS" --offload-dir-path "$offd" <(pi-make-microsoft-freecell-board -t "$deal") | tail -10
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

if test -z "$out_dir"
then
    out_dir="$HOME"
fi

filter()
{
    out_fn="${out_dir}/depth-dbm-freecell-solver--0freecells--ms${deal}--clang--ts=$(date "+%s").log.txt"
    # See https://metacpan.org/dist/App-Timestamper-WithElapsed
    timestamper-with-elapsed --from-start --output="${out_fn}"
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
        if test "${use_filter}" = "true"
        then
            "$method" | filter
        else
            "$method"
        fi
    done
    if test "${should_notify}" = "true"
    then
        # See https://www.shlomifish.org/open-source/projects/notifier-apps/
        notifier notify --msg "freecell process for deal ${deal} has completed" || true
    fi
}
