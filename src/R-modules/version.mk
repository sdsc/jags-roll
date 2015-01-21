NAME          = sdsc-jags-R-modules
VERSION       = 2
RELEASE       = 0
PKGROOT       = /opt/R/local/lib

SRC_SUBDIR    = R-modules

# Ordered with dependent modules after prerequisites
R_MODULES     = coda rjags

CODA_NAME     = coda
CODA_SUFFIX   = tar.gz
CODA_VERSION  = 0.16-1
CODA_PKG      = $(CODA_NAME)_$(CODA_VERSION).$(CODA_SUFFIX)
CODA_DIR      = $(CODA_NAME)

RJAGS_NAME    = rjags
RJAGS_SUFFIX  = tar.gz
RJAGS_VERSION = 3-14
RJAGS_PKG     = $(RJAGS_NAME)_$(RJAGS_VERSION).$(RJAGS_SUFFIX)
RJAGS_DIR     = $(RJAGS_NAME)

TAR_GZ_PKGS   = $(CODA_PKG) $(RJAGS_PKG)

RPM.EXTRAS    = AutoReq:No
