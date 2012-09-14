#!/usr/bin/perl
# Create a program that requires users to input data from standard input interactively. The data is “prefectural and city governments in Japan” and “their population”. 
# Pairs of “prefectural and city governments in Japan” and “their population” are to be numbered serially beginning from 1.
# 
# When “quit” is input, the interactive input is quitted, and make the program display the  input data on standard output. Each entry is to be displayed on each line separated by comma.
# 
# Format of output is to be like the following.
# 
# 1,Tokyo,12868000
# 2,Kanagawa,8943000
# 3,Osaka,8801000
# 
# 
# === Example of execution.  After inputing Tokyo, Kanagawa, Osaka, the program is quitted by input of ‘quit’ === 
# 
# [training@centos perl]$ ./2-practice.pl
# 
# input is ended by input of ‘quit’
# 
# input number 1
# Prefecture > Tokyo
# Population > 12868000
# 
# input is ended by input of ‘quit’
# 
# input number 2
# Prefecture > Kanagawa
# Population > 8943000
# 
# input is ended by input of ‘quit’
# 
# input number 3
# Prefecture > Osaka
# Population > 8801000
# 
# input is ended by input of ‘quit’
# 
# input number 4
# Prefecture > quit
# 
# ---- input data ---
# 1,Tokyo,12868000
# 2,Kanagawa,8943000
# 3,Osaka,8801000
# 
# === End of example execution ===

use 5.8.9;
use strict;
use warnings;
use feature qw(say);
use List::Util qw(min);
use File::Compare;
use Digest::MD5 qw(md5 md5_hex);

# global variables for storing user-input data
our @prefectures = ();
our @populations = ();

# global variables for testing and debugging
our $temp_output_file = './temp_output.txt';
our $test_input_file = './2-test_input.txt';
our $test_output_file = './2-test_output.txt';
our $debug = 0;



# determines if the string entered was a terminating string
# in this case, we only use 'quit' as a terminating string
sub was_quit($)
{
  return $_[0] eq 'quit' ? 1 : 0;
}

# continue to add data until the user says 'quit'
# data should be verified after input
sub input_data
{
  my $current_input_number = 0;
  while (1) {
    $current_input_number += 1;
    say "\ninput is ended by input of 'quit'\n";
    say "input number $current_input_number";
    print "Prefecture > ";
    my $prefecture = <stdin>;
    chomp($prefecture);
    return(1) if was_quit($prefecture);
    push(@prefectures, $prefecture);
    print "Population > ";
    my $population = <stdin>;
    chomp($population);
    return(1) if was_quit($population);
    push(@populations, $population);
  }
  return(1);
}

# format the output data and print
sub output_data
{
  say "---- input data ---";
  my $last_index = min($#prefectures, $#populations);
  my $current_input_number;
  for my $i (0 .. $last_index) {
    $current_input_number = $i + 1;
    say "$current_input_number,$prefectures[$i],$populations[$i]";
  }
  return(1);
}

# determine if this output is identical to the expected output
sub check_output
{
  open FILE, ">$temp_output_file";
  select FILE; # choose to print to this file instead of stdout
  output_data;
  close FILE;
  select STDOUT; # reset
  if (compare($temp_output_file, $test_output_file) == 0) {
    say "input matched test file";
  }

  return(1);
}

# checking files using md5 checksums; replaced with compare() which does line-by-line comparison, but this may be useful to know about in the future
sub compare_files
{
    my ( $fileA, $fileB ) = @_;
    open my $file1, '<', $fileA;
    open my $file2, '<', $fileB;
    my @data1 = <$file1>;
    my @data2 = <$file2>;
    close($file1);
    close($file2);
    say md5_hex(@data1);
    say md5_hex(@data2);
    return 1 if md5(@data1) eq md5(@data2);
    return 0;
}

# main run test to see if correct based on test input and output
input_data;
say "";
output_data;

# check this output against the expected output from './2-test_output.txt' if an argument is added to the end of the command line
# run debug mode with
#     2-practice.pl debug < 2-test_input.txt
$debug = 1 if $#ARGV > -1;
check_output if $debug==1;
