# installation script for R packages; pass installation root and jags root
# as arguments.

PKGROOT=${1:-/opt/R}
JAGSROOT=$2
CRANURL=http://cran.stat.ucla.edu

export JAGS_INCLUDE=${JAGSROOT}/include/JAGS
export JAGS_LIB=${JAGSROOT}/lib
R --vanilla << END
# Specify where to pull package source from
repos <- getOption("repos")
repos["CRAN"] = "${CRANURL}"
options(repos = repos)
install.packages('rjags', lib="${PKGROOT}", INSTALL_opts=c("--no-test-load"))
END
