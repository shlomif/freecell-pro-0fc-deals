#
# Makefile
# shlomif, 2018-04-06 18:32
#

all:
	@echo "Makefile needs your attention"

check: test

test:
	prove t/*.t

# vim:ft=make
#
