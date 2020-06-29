#! /bin/bash
#
# histogram.bash
# Copyright (C) 2020 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

csvfn='files-intractables-histogram.csv'
xlsxfn='files-intractables-histogram.xlsx'

if test -z "$BINSIZE"
then
    export BINSIZE="$((10 ** 8))"
fi

(
    echo '"Bin","Count"'
    grep -E '^Int' 0fc-logs/*.log.txt | perl -Minteger -Mbytes -lanE 'BEGIN{$size=int($ENV{BINSIZE});};++$h{int($F[1] / $size)}; END{foreach my $bin (sort { $a <=> $b} keys%h){say qq#"$bin","$h{$bin}"#;}}'
) | tee "$csvfn"

csv2chart xlsx -o "$xlsxfn" --title "Intractables frequency per bin" --chart-type column --exec gnumeric < "$csvfn"
