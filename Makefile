all: inc.exe stats

CXX ?= clang++
CXXFLAGS = -std=c++11 -Wall -Wextra -O3 -march=native -flto -fwhole-program

colstat.exe: collect-stats.cpp
	$(CXX) -o $@ $(CXXFLAGS) $<

inc.exe: inc-nums.cpp
	$(CXX) -o $@ $(CXXFLAGS) $<

CONCATENATED_LOG := 0fc-log.txt
SUBLOGS = $(wildcard 0fc-logs/*.log.txt)

$(CONCATENATED_LOG): $(SUBLOGS)
	bash concatenate-to-big-log.bash

log: $(CONCATENATED_LOG)

check: test

test: all
	prove t/*.t

total: test put diff

put:
	git add -u .

diff:
	git diff HEAD --stat

PERL = perl

stats: colstat.exe
	$(PERL) stats.pl | $(PERL) commify.pl

# vim:ft=make
#
# collect:
# 	bash collect.bash
#
