#! /usr/bin/env perl6
# vim:fenc=utf-8
#
# Copyright © 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.

my $o = open '0fc-log.lg-compress.txt', :w;
for '0fc-log.lg.txt'.IO.lines -> $line {
    if $line ~~ m:P5/^([0-9]+) = Verdict: (Intractable|Solved|Unsolved) ; Iters: [0-9]+ ; Length: (?:[0-9]+|-1)$/ {
            $o.say([ $1.substr(0,1), $0 ].join("\t"));
        }
    }
