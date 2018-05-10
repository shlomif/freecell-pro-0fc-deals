#
# Makefile
# shlomif, 2018-04-06 18:32
#

all:
	@echo "Makefile needs your attention"

0fc-log.txt: $(wildcard 0fc-logs/*.log.txt)
	bash concatenate-to-big-log.bash

collect:
	bash collect.bash

check: test

test: 0fc-log.txt
	prove t/*.t

total: collect test put diff

put:
	git add -u .

diff:
	git diff HEAD --stat

# vim:ft=make
#
