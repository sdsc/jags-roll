#!/usr/bin/perl -w
# jags roll installation test.  Usage:
# jags.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/jags';
my $output;

my $TESTFILE = 'tmpjags';

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load ROLLCOMPILER lapack jags
mkdir $TESTFILE.dir
cd $TESTFILE.dir
cp /opt/jags/examples/vol2/air/* .
jags notest1.cmd
cat CODA*
END
close(OUT);

# jags-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'jags installed');
} else {
  ok(! $isInstalled, 'jags not installed');
}
SKIP: {

  skip 'jags not installed', 5 if ! $isInstalled;

  SKIP: {
    skip 'jags test not installed', 2 if ! -d '/opt/jags/examples';
    $output = `/bin/bash $TESTFILE.sh 2>&1`;
    ok(-f "$TESTFILE.dir/CODAchain1.txt" &&
       -f "$TESTFILE.dir/CODAchain2.txt" &&
       -f "$TESTFILE.dir/CODAindex.txt", 'jags output files created');
    like($output, qr/theta\[2\] 5001 10000/, 'jags test run');
  }

  `/bin/ls /opt/modulefiles/applications/jags/[0-9]* 2>&1`;
  ok($? == 0, 'jags module installed');
  `/bin/ls /opt/modulefiles/applications/jags/.version.[0-9]* 2>&1`;
  ok($? == 0, 'jags version module installed');
  ok(-l '/opt/modulefiles/applications/jags/.version',
     'jags version module link created');

}
SKIP: {
  skip 'R not installed', 2 if ! -d '/opt/R';
  $ENV{'R_LIBS'} = '/opt/R/local/lib';
  ok(-d $ENV{'R_LIBS'}, 'R library created');
  open(OUTPUT, ">$TESTFILE.sh");
  print OUTPUT <<END;
module load ROLLCOMPILER R
echo 'library()' | R --vanilla
END
  $output = `/bin/bash $TESTFILE.sh 2>&1`;
  ok($output =~ /rjags/, "rjags R module installed");
}

`rm -fr $TESTFILE*`;
