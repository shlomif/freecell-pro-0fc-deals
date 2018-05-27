#
# Makefile
# shlomif, 2018-04-06 18:32
#

all: stats

0fc-log.txt: $(wildcard 0fc-logs/*.log.txt)
	bash concatenate-to-big-log.bash

check: test

test: 0fc-log.txt
	prove t/*.t

total: test put diff

put:
	git add -u .

diff:
	git diff HEAD --stat

stats: 0fc-log.txt
	perl stats.pl $< | commify

# vim:ft=make
#
# collect:
# 	bash collect.bash
#
