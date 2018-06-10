#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.

import re
"""

"""

with open('0fc-log.lg.txt', 'rt') as f:
    with open('0fc-log.lg-compress.txt', 'wt') as o:
        for line in f:
            m = re.match(
                    r'^([0-9]+) = Verdict: (Intractable|Solved|Unsolved)' +
                    r' ; Iters: [0-9]+ ; Length: (?:[0-9]+|-1)$',
                    line)
            if not m:
                raise BaseException('match error')
            o.write('%s\t%s\n' % (m.group(2)[0], m.group(1)))
