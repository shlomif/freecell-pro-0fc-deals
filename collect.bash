#! /bin/bash
#
# collect.bash
# Copyright (C) 2018 shlomif <shlomif@telaviv1.shlomifish.org>
#
# Distributed under terms of the MIT license.
#

l=0fc-log.txt
(
    cat ~/Backup/Arcs/0fc-log.txt
    grep -El '^End' ~/progs/freecell/git/fc-solve/fc-solve/0fc-b/results/* |
        xargs cat |
        grep -vE '^(Start|End)'
) > "$l"
for prefix in `seq 0 99`
do
    export P="$prefix"
    perl -nalE 'BEGIN {$P=$ENV{P}; $s = $P*1e8; $e = ($P+1)*1e8 - 1; } say if $F[1] >= $s && $F[1] <= $e' < "$l" > "$(printf "0fc-logs/%02d.log.txt" "$prefix")"
done
