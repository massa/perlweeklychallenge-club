# CAN BE IMPROVED

#!/usr/bin/perl
# The Weekly Challenge 168
# Task 2 Home Prime 
# Usage: ch-2.pl [integer > 1]
use v5.24.0;
use warnings;
use List::Util qw/reduce/;
use Math::BigInt::GMP;          # [remark]
use Math::BigInt::Pari;         # [remark]
use Math::Prime::Util::GMP qw/is_prime next_prime/;
use bigint try => 'GMP,Pari';   # [remark]
# remark: follow suggestions on POD of Math::Prime::Util


say hp($ARGV[0]) if defined($ARGV[0]);



sub hp {
    my_hp($_[0],0);
}



sub my_hp {
    my $recur_depth = $_[1];

    die "Walk so far but still cannot get result. :(\n" if $recur_depth > 20;
    my $num = Math::BigInt->new($_[0]);
    if (is_prime($num) == 2) {
        return $num;
    }

    my @factors = ();
    my $p = 2;
    while ($num != 1) {
        my $temp_num = $num;
        if ( $num->bmod($p) == 0 ) {
            say $p;
            push @factors, $p;
            $num = $num->bdiv($p);
        }
        else {
            $p = next_prime($p);
        }
        if ($p > $temp_num->bsqrt()) {
            push @factors, $num;
            last;
        }
    }
    my $nxt = join "", @factors;
    say "  $nxt";
    return my_hp($nxt, ++$recur_depth);
}


=pod
use Test::More tests => 8;
# test data from OEIS
ok hp(10) == 773;
ok hp(24) == 331_319;
ok hp(32) == 241_271;
ok hp(40) == 3314192745739;  
ok hp(44) == 22815088913;  
ok hp(45) == 3_411_949;
ok hp( 8) == 3331113965338635107;
ok hp(48) == 6161791591356884791277;

# time without the last hp(48) test case:
# real	0m1.963s
# user	0m1.946s
# sys	0m0.016s
#
# time without the last hp(48) test case and use simply Math::Prime::Util :
# real	0m0.133s
# user	0m0.115s
# sys	0m0.011s

