#!/usr/bin/perl
use 5.010;
use strict;
use warnings;
use Data::Dumper qw(Dumper);

#POD is the perldoc
#--open using perldoc $filename
=pod

=head1 DESCRIPTION
Basic examples of how to use perl

=over 1

including some random things that could be helpful later

=back

=over

=item *
control

=item *
variables

=item *
documentation

=back

=cut

say "hello world";
#my $name = <STDIN>;
my $name = 'some name';
chomp $name;
say "Hello $name";
my $inc = 0;

if (0) {
  print $inc++ while $inc < 10;
}
$inc = 0;
say "counting";
if (1) {
  print $inc++ until $inc >= 10;
}
# LABEL foreach VAR (LIST) BLOCK continue BLOCK
my $count;
for $count (10,9,8,7,'stuff') {
  print $count, "\n";
}
# Array
my @arr = (1, 23, 30, "names");
push @arr, '33';
push @arr, '101';
foreach my $i (0 .. $#arr) {
  $arr[$i]++;
}
my $sizeofarr = scalar @arr;
say "size of the array: ", $sizeofarr;
say "last index of the array: ", $#arr, " last index-1: ", $arr[$#arr-1];


# Hash
my %persons = (John => 25, Anne =>32, Paul=>22);
foreach $name (reverse sort keys %persons) {
  print "$name is $persons{$name} years old.\n";
}

# printing complicated structures with Dumper
say "trying dumper";
print '%persons: ' . Dumper \%persons;

# reading and writing
my $fnr = 'testfile.txt';
if (open(my $fhr, '<', $fnr)) {
  while (my $row = <$fhr>) {
    chomp $row;
    say $row;
  }
} else {
  warn "could not open file '$fnr' $!";
}

my $fn = 'out.txt';
open(my $fh, '>', $fn) or die "Count not open file '$fn' $!";
say $fh "perl output";
close $fh;

# other styles of read and write, scoped variables close the file pointers when out of scope, yay
open my $in, '<', $fn or die "died...";
open my $out, '>', 'out_copy.txt' or die "died 2";
while (my $row = <$in>) {
  print $out $row
}



