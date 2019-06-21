#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

# TEST
like( scalar(`ag -s '[ \\t]\$' . | head -c 1000`),
    qr#\A[\r\n]*\z#, "No trailing space was found." );
