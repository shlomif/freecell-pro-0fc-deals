#! /bin/bash
#
# run.bash
# Copyright (C) 2018 shlomif <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#


./freecell-solver-range-parallel-solve 1 8600000000 1000 --freecells-num 0 -to 0AB -sp r:tf -mi 2000000 | perl -lnE 'BEGIN { STDOUT->autoflush(1); }; if (/(Unsolved|Intractable) Board No\. ([0-9]+)/) { $last = $2 if not $last; while ($last < $2) { say "S\t$last"; ++$last; } $last = $2+1; if ($1 eq "Intractable") { say "Int\t$2"; } } STDERR->print($_) if /Reached/' | tee -a 0fc-log.txt ~/Backup/Arcs/0fc-log.txt
