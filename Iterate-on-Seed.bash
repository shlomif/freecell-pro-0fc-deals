#!/bin/bash

board_num=25512826
iters_limit=2300000
board_file="$board_num.board"

if ! test -e "$board_file" ; then
    pi-make-microsoft-freecell-board -t "$board_num" > "$board_file"
fi

let seed=1
while true ; do
    echo "Checking seed $seed"
    if fc-solve --freecells-num 0 --method random-dfs -to '[0AB]' -seed "$seed" -mi "$iters_limit" "$board_file" | grep -P '^This game is solveable' ; then
        echo "Seed '$seed' is successful."
        exit 0
    fi
    let seed++
done
