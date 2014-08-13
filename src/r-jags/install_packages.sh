# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
CRANURL=http://cran.stat.ucla.edu

if test -e /etc/profile.d/modules.sh; then
  . /etc/profile.d/modules.sh
  module load gnu lapack R
fi

R --vanilla << END
# Specify where to pull package source from
repos <- getOption("repos")
repos["CRAN"] = "${CRANURL}"
options(repos = repos)
install.packages('rjags', lib="${PKGROOT}")
END
