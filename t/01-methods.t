#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Iterator::Breathe';

my $iter = new_ok 'Iterator::Breathe' => [
#    verbose => 1,
];

#is $iter->verbose, 1, 'verbose';

my $got;

for my $i ( 0 .. 99 ) {
  $got = $iter->iterate;
  is $got, $i + 1, 'ith iteration up';
}

for (my $i = 99; $i >= 0; $i-- ) {
  $got = $iter->iterate;
  is $got, $i, 'ith iteration down';
}

done_testing();
