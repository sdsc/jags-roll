NAME               = r-jags
RELEASE            = 3
PKGROOT            = /opt/R/local/lib

SRC_SUBDIR         = r-jags

SOURCE_SUFFIX      = tar.gz

RJAGS_NAME         = rjags
RJAGS_VERSION      = 3-12
RJAGS_PKG          = $(RJAGS_NAME)_$(RJAGS_VERSION).$(SOURCE_SUFFIX)
RJAGS_DIR          = $(RJAGS_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        =

RPM.EXTRAS         = AutoReq:No
