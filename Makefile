#
# Makefile
# shlomif, 2018-04-06 18:32
#

all: inc.exe stats

CXXFLAGS = -std=c++11 -Wall -Wextra -O3 -march=native -flto -fwhole-program

colstat.exe: collect-stats.cpp
	g++ -o $@ $(CXXFLAGS) $<

inc.exe: inc-nums.cpp
	g++ -o $@ $(CXXFLAGS) $<

0fc-log.txt: $(wildcard 0fc-logs/*.log.txt)
	bash concatenate-to-big-log.bash

check: test

test: all 0fc-log.txt
	prove t/*.t

total: test put diff

put:
	git add -u .

diff:
	git diff HEAD --stat

PERL = perl

stats: 0fc-log.txt colstat.exe
	$(PERL) stats.pl $< | $(PERL) commify.pl

# vim:ft=make
#
# collect:
# 	bash collect.bash
#
