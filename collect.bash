#! /bin/bash
#
# collect.bash
# Copyright (C) 2018 shlomif <shlomif@telaviv1.shlomifish.org>
#
# Distributed under terms of the MIT license.
#

(
    cat ~/Backup/Arcs/0fc-log.txt
    grep -El '^End' ~/progs/freecell/git/fc-solve/fc-solve/0fc-b/results/* |
        xargs cat |
        grep -vE '^(Start|End)'
) | \
perl -nalE 'BEGIN { sub f {$s = $P*1e8; $e = ($P+1)*1e8 - 1; $fn=(sprintf "0fc-logs/%02d.log.txt", $P); warn $fn; open $o, ">", $fn; } $P=0;f; } if ($F[1] >= $s && $F[1] <= $e) { $o->say($_); } else { ++$P;f;redo;} ; END { close$o;}'
