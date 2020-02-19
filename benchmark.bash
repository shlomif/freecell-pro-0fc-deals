#! /bin/bash
#
# benchmark.bash
# Copyright (C) 2020 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#
(
set -e -x
inputfn=0fc-log.txt
sh='shuffled.txt'
if ! test -f "$sh"
then
    src='random_source.txt'
    if ! test -f "$src"
    then
        cat solve-more-[78]*.txt > "$src"
    fi
    gmake "$inputfn"
    cat "$inputfn" | perl -lanE 'say $F[1]' | shuf --random-source "$src" - > "$sh"
fi
cargo_dir=~/.cargo/bin
cargo_sort="$cargo_dir/sort"
cargo_uu="$cargo_dir/uutils"
if ! test -e "$cargo_sort"
then
    ln -s "$cargo_uu" "$cargo_sort"
fi
time "$cargo_sort" -n --head 100 < "$sh"
time sort -n < "$sh" | head -100
)
