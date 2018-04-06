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
) > 0fc-log.txt
