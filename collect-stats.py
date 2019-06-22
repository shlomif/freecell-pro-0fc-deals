#
# inc-nums.cpp
# Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

import sys
with open(sys.argv[1], "r") as f:
    S = J = 0
    for line in f:
        if line[0] == 'S':
            S += 1
        else:
            J += 1
    print("S\t{}\nInt\t{}".format(S, J))
