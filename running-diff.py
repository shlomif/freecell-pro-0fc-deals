#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.

"""

"""

import sys

prev = None
for line in sys.stdin:
    nxt = int(line)
    if prev is not None:
        print("%d\t%d\t%d" % (nxt - prev, prev, nxt))
    prev = nxt
