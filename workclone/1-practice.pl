#!/usr/bin/perl
# Generate all primes up to 10000
# This question is calculation for natural number less than 10000.
# Pick up prime numbers at an interval of 100 and count them, after that, output by following
# format.

# 2-100: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 : 25
# 101-200: 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191
# 193 197 199 : 21
# 201-300: 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 : 16
# 301-400: 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 : 16
# ...
# 9801-9900: 9803 9811 9817 9829 9833 9839 9851 9857 9859 9871 9883 9887 : 12
# 9901-10000: 9901 9907 9923 9929 9931 9941 9949 9967 9973 : 9

use 5.8.9;
use strict;
use warnings;

our @all_primes_array = ();
use constant INTERVAL_SIZE => 100; # used for printing intervals

sub round_to_interval($)
{
  return(int($_[0] / INTERVAL_SIZE) * INTERVAL_SIZE);
}

sub is_prime($)
{
  my $num = $_[0];
  foreach my $possible_factor (@all_primes_array) {
    return(1)  if ($possible_factor > sqrt($num));
    return("") if ($num % $possible_factor == 0);
  }
  return(1);
}

# prints without saving any information
sub print_primes_until($)
{
  my %all_primes = ();
  my $current_min = 2;
  my $current_max = 100;
  my @current_range = ();
  foreach my $possible_prime (2 .. $_[0]) {
    if (is_prime($possible_prime)) {
      my $prime_range_min = round_to_interval($possible_prime)+1;
      $prime_range_min = 2 if ($prime_range_min==1); # special beginning case

      # print after collecting this range, much more efficient than
      # printing after every prime
      if ($prime_range_min > $current_min) {
        $current_max = round_to_interval($current_min + 100);
        print "$current_min-$current_max: @current_range : @{[scalar @current_range]}\n";
        @current_range = ($possible_prime);
        $current_min = $prime_range_min
      }
      else {
        push(@current_range,$possible_prime);
      }
      push @all_primes_array, $possible_prime;
    }
  }
  # flush the remainder of the collection
  $current_max = round_to_interval($current_min + 100);
  print "$current_min-$current_max: @current_range : @{[scalar @current_range]}\n";
 
  return(1)
}

# run to the given command-line argument number, or default to run to 10000
($#ARGV == 0) ? print_primes_until($ARGV[0]) : print_primes_until(10000);
