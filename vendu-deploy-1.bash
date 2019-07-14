#! /bin/bash
#
# vendu-deploy-1.bash
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

set -e
set -x

export FREECELL_SOLVER_QUIET=1
base="`pwd`"
shlomif_set="$base/shlomif-computer-settings"
fcs_repo="$base/fc-solve"
export MAX_ITERS='32000000'
export MAX_ITERS='6500000'

if ! test -e "$shlomif_set"
then
    git clone https://github.com/shlomif/shlomif-computer-settings
fi

PATH="$PATH:$shlomif_set/shlomif-settings/home-bin-executables/bin"

if ! test -e "$fcs_repo"
then
    git clone https://github.com/shlomif/fc-solve
fi

fcs_src="$fcs_repo/fc-solve/source"
fcs_b="$base/build"
fcs_i="$base/fcs-inst"

mkdir -p "$fcs_b"

if ! test -e "$fcs_i"
then
    cd "$fcs_b"
    "$fcs_src/Tatzer" -l zerofc --prefix="$fcs_i"
    make
    make install
    cd "$base"
fi

PATH="$fcs_i/bin:$PATH"

make 0fc-log.txt

bash solve-more-3.bash
