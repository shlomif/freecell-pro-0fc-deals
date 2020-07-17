#! /usr/bin/env perl
#
# Short description for check-for-required-ram.pl
#
# Author Shlomi Fish <shlomif@cpan.org>
# Version 0.0.1
# Copyright (C) 2020 Shlomi Fish <shlomif@cpan.org>
#
use strict;
use warnings;
use 5.014;
use autodie;

use Path::Tiny qw/ path tempdir tempfile cwd /;

my ($req) = @ARGV;
my $free = `free`;
die "Cannot find \"free\" command" if $?;
if ( my ($ram) = $free =~ /^Mem:\s*([0-9]+)\s/ms )
{
    die "not enough ram: needed $req" if $req > $ram;
    exit 0;
}
else
{
    die "Could not match output of 'free' command";
}
