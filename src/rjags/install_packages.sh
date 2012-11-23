# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
CRANURL=http://cran.stat.ucla.edu
# R_LIBS might be needed for package dependencies
export R_LIBS=${PKGROOT}/local/lib
${PKGROOT}/bin/R --vanilla << END
# Specify where to pull package source from
repos <- getOption("repos")
repos["CRAN"] = "${CRANURL}"
options(repos = repos)
install.packages('rjags', lib="${R_LIBS}")
END
