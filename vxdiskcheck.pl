#!/usr/bin/perl
use strict;

# This script runs vxdmpadm and vxdisk to check for errors
# It is designed to be used in conjunction with a montioring tool

my $vxdir="/opt/VRTS/bin";
my $vxdsk="$vxdir/vxdisk";
my $vxdmp="$vxdir/vxdmpadm";
my @vxinf; my @vxerr;
my $vxinf; my $vxerr;

# Check vxdisk list for errors

if (-e "$vxdsk") {
  @vxinf=`$vxdsk list |grep error |awk '{print \$1}'`;
  foreach $vxinf (@vxinf) {
    if ($vxinf=~/[0-9]|[a-z]/) {
      chomp($vxinf);
      push (@vxerr, $vxinf);
    }
  }
}

# Check vxdmpadm for errors

if (-e "$vxdsk") {
  @vxinf=`$vxdmp list dmpnode all |grep disabled |awk '{print \$3}'`;
  foreach $vxinf (@vxinf) {
    if ($vxinf=~/[0-9]|[a-z]/) {
      chomp($vxinf);
      push (@vxerr, $vxinf);
    }
  }
}

# If there are errors print them

if (@vxerr=~/[0-9]|[a-z]/) {
  foreach $vxerr (@vxerr) {
    print "WARNING: $vxerr\n";
  }
}
