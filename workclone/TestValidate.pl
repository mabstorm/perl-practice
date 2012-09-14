#!/usr/bin/perl
# tests Validate::mail to validate email addresses
# Validate is found in 7-practice.pm

use strict;
use Validate;

my @right = ( 'yamazaki.yuki@knowd.co.jp',
                'yamazaki_yuki@knowd.com',
                '920810@9999.com' );

my @bad = ( 'yamazaki@com', 'yamazaki@jp.',
                'yamazaki.yuki-knowd.com',
                'yamazaki yuki@knowd.co.jp',
                '@knowd.co.jp' );

my $num_passed = 0;
my $num_total = scalar @bad + scalar @right;

for my $mail ( @right ) {
        if( Validate::mail( $mail ) == 1 ) {
                print $mail, " ... PASS\n";
                $num_passed += 1;
        }
        else {
          print $mail, " ... FAIL\n";
        }

}


for my $mail ( @bad ) {
        if( Validate::mail( $mail ) == -1 ) {
                print $mail, " ... PASS\n";
                $num_passed += 1;
        }
        else {
          print $mail, " ... FAIL\n";
        }
}
print "passed $num_passed / $num_total\n";
