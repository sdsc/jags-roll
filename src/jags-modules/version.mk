NAME        = jags-modules
RELEASE     = 2
PKGROOT     = /opt/modulefiles/applications/jags

VERSION_SRC = $(REDHAT.ROOT)/src/jags/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
