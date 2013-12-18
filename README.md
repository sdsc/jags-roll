# SDSC "jags" roll

## Overview

This roll bundles the JAGS Bayesian model analyzer.

For more information about the various packages included in the JAGS roll please
visit the official web page:

- <a href="http://mcmc-jags.sourceforge.net" target="_blank">JAGS</a> is Just Another Gibbs Sampler.  It is a program for analysis of Bayesian hierarchical models using Markov Chain Monte Carlo (MCMC) simulation.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate jags source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

Unknown at this time.


## Building

To build the jags-roll, execute these instructions on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make default 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been
created as... `jags-*.iso`. If you built the roll on a Rocks frontend then
proceed to the installation step. If you built the roll on a Rocks development
appliance you need to copy the roll to your Rocks frontend before continuing
with installation.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll jags
% cd /export/rocks/install
% rocks create distro
% rocks run roll jags | bash
```

In addition to the software itself, the roll installs jags environment
module files in:

```shell
/opt/modulefiles/applications/jags
```


## Testing

The jags-roll includes a test script which can be run to verify proper
installation of the jags-roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/jags.t 
ok 1 - jags is installed
ok 2 - jags test run
ok 3 - jags module installed
ok 4 - jags version module installed
ok 5 - jags version module link created
1..5
```
