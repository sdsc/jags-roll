NAME          = sdsc-jags-R-modules
VERSION       = 5
RELEASE       = 4
PKGROOT       = /opt/R/local/lib

SRC_SUBDIR    = R-modules

# Ordered with dependent modules after prerequisites
R_MODULES     = rjags

RJAGS_NAME    = rjags
RJAGS_SUFFIX  = tar.gz
RJAGS_VERSION = 4-6
RJAGS_PKG     = $(RJAGS_NAME)_$(RJAGS_VERSION).$(RJAGS_SUFFIX)
RJAGS_DIR     = $(RJAGS_NAME)

TAR_GZ_PKGS   = $(RJAGS_PKG)

RPM.EXTRAS    = AutoReq:No\nAutoProv:No
RPM.PREFIX    = $(PKGROOT)
