#! /bin/bash
#
# solve-more.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under the terms of the MIT license.
#

PATH="$HOME/progs/freecell/git/fc-solve/fc-solve/0fc-b:$PATH"
< 0fc-log.txt perl -lanE 'say $F[1] if $F[0] eq "Int" && $F[1] > 2109026' > ints0fc0.txt
summary-fc-solve slurp ints0fc0.txt -- -l lg --freecells-num 0 -mi 32000000 | tee -a 0fc-log.lg.txt
