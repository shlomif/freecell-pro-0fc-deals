#! /bin/bash
#
# collect.bash
# Copyright (C) 2018 shlomif <shlomif@telaviv1.shlomifish.org>
#
# Distributed under terms of the MIT license.
#

(
    cat ~/Backup/Arcs/0fc-log.txt
    grep -rEl '^End' ~/progs/freecell/git/fc-solve/fc-solve/0fc-b/results/ |
        (LC_ALL=C sort) |
        xargs cat |
        grep -vE '^(Start|End)'
) | \
perl -nal split-logs.pl
