#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
#

PATH="$HOME/progs/freecell/git/0fc-b:$PATH"
out='0fc-log.lg.txt'
list=ints0fc0.txt
export START="$(tail-extract '^([0-9]+) = ' "$out")"
< 0fc-log.txt perl -lanE 'say $F[1] if $F[0] eq "Int" && $F[1] > $ENV{START} ' > "$list"
summary-fc-solve slurp "$list" -- -l lg --freecells-num 0 -mi 1000000 | tee -a "$out"
