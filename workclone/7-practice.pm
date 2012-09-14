package Validate;

use strict; use warnings;

sub mail
{


  if ($_[0] =~ m/^[\S^@]+@[\S^.][\S]*\.[\S^.]+$/i) { return 1; }
  else { return -1; }

}

return 1;
