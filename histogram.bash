#! /bin/bash
#
# histogram.bash
# Copyright (C) 2020 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

csvfn='files-intractables-histogram.csv'
xlsxfn='files-intractables-histogram.xlsx'
(
    echo '"Bin","Count"'
    grep -cE '^Int' 0fc-logs/*.log.txt | perl -lanE 'say qq#"$1","$2"# if m#0fc-logs/([0-9]+)\.log\.txt:([0-9]+)#'
) | tee "$csvfn"


csv2chart xlsx -o "$xlsxfn" --title "Intractables frequency per bin" --chart-type column --exec gnumeric < "$csvfn"
