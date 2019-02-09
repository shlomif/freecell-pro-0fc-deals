# freecell-pro-0fc-deals

Finding 8 column deals in the fc-pro range which are solvable with zero
freecells. The interesting file is `0fc-log.txt` which can be generated using
the instructions below. "S" there means the following deal is solvable. "Int"
means that it is intractable and that the solver ran out of resources before
determining its solvability. If a deal does not appear in the list and is below
the latest one, then it is impossible.

* [What are the MS Freecell deals?](http://fc-solve.shlomifish.org/faq.html#what_are_ms_deals)
* [The Freecell FAQ](http://www.solitairelaboratory.com/fcfaq.html)

# Instructions:

```
shlomif[0fc]:$this$ pwd
/home/shlomif/Download/unpack/games/freecell/freecell-pro-0fc-deals
shlomif[0fc]:$this$ gmake
perl stats.pl 0fc-log.txt | perl commify.pl
Solved: 18,402,275 ( 0.21 %)
Intractable: 999,907 ( 0.01 %)
Impossible: 8,570,532,409 ( 99.77 %)
shlomif[0fc]:$this$ ls -l 0fc-log.txt
-rw-r--r-- 1 shlomif shlomif 251772325 Feb  9 18:02 0fc-log.txt
```

# Credits

## GNU Parallel

Generating the results here made use of
[GNU Parallel](https://www.gnu.org/software/parallel/), so here is the citation
for it:

```
@book{tange_ole_2018_1146014,
      author       = {Tange, Ole},
      title        = {GNU Parallel 2018},
      publisher    = {Ole Tange},
      month        = Mar,
      year         = 2018,
      ISBN         = {9781387509881},
      doi          = {10.5281/zenodo.1146014},
      url          = {https://doi.org/10.5281/zenodo.1146014}
}
```

## pypy

We also made use of [pypy](http://pypy.org/) .

## perl5

We made use of [perl 5](https://dev.perl.org/perl5/) .

## Freecell Solver

We made use of [Freecell Solver](http://fc-solve.shlomifish.org/) .

# Related repositories and links

* [Freecell Solver](https://github.com/shlomif/fc-solve) - the readme contains links to other repositories .
