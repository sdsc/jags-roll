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
if test -f /etc/profile.d/modules.sh; then
  . /etc/profile.d/modules.sh
  module load gnu lapack jags
fi
mkdir $TESTFILE.dir
cd $TESTFILE.dir
cp /opt/jags/examples/vol2/air/* .
jags notest1.cmd
cat CODA*
END
close(OUT);

open(OUT, ">$TESTFILE.R.sh");
print OUT <<END;
#!/bin/bash
if test -f /etc/profile.d/modules.sh; then
  . /etc/profile.d/modules.sh
  module load gnu lapack jags ROLLMPI_ROLLNETWORK R
fi
echo 'library()' | R --vanilla
END
close(OUT);

# abyss-common.xml
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
    $output = `/bin/bash $TESTFILE.R.sh 2>&1`;
    like($output, qr/rjags/, 'rjags module installed');
  }

  skip 'modules not installed', 3 if ! -f '/etc/profile.d/modules.sh';
  `/bin/ls /opt/modulefiles/applications/jags/[0-9]* 2>&1`;
  ok($? == 0, 'jags module installed');
  `/bin/ls /opt/modulefiles/applications/jags/.version.[0-9]* 2>&1`;
  ok($? == 0, 'jags version module installed');
  ok(-l '/opt/modulefiles/applications/jags/.version',
     'jags version module link created');

}

`rm -fr $TESTFILE*`;
