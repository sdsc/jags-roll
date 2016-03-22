ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME                    = sdsc-jags
VERSION                 = 3.4.0
RELEASE                 = 3
PKGROOT                 = /opt/jags

SRC_SUBDIR              = jags

SOURCE_NAME             = JAGS
SOURCE_SUFFIX           = tar.gz
SOURCE_VERSION          = $(VERSION)
SOURCE_PKG              = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR              = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

CLASSIC_BUGS_NAME       = classic-bugs
CLASSIC_BUGS_SUFFIX     = tar.gz
CLASSIC_BUGS_VERSION    = ''
CLASSIC_BUGS_PKG        = $(CLASSIC_BUGS_NAME).$(CLASSIC_BUGS_SUFFIX)
CLASSIC_BUGS_SOURCE_DIR = $(CLASSIC_BUGS_PKG:%.$(CLASSIC_BUGS_SUFFIX)=%)

TAR_GZ_PKGS             = $(SOURCE_PKG) $(CLASSIC_BUGS_PKG)

RPM.EXTRAS              = AutoReq:No
