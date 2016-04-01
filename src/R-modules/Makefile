# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

JAGS_CACHE = $(REDHAT.ROOT)/cache/build-jags
JAGS_HOME = /opt/jags
NODE_FILE = $(REDHAT.ROOT)/nodes/jags-common.xml

R_MODULES_CACHE = $(REDHAT.ROOT)/cache/build-rjags

LICENSE_FILES = $(SOURCE_DIR)/LICENSE

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_R); \
	  $(DESCRIBE_LAPACK) \
	) > $@

LICENSE: $(SRC_DIRS)
	#TODO
	#if ! grep -q "GNU GENERAL PUBLIC LICENSE" $(SOURCE_DIR)/COPYING; then \
	#  exit 2; \
	#fi
	echo GPL > $@

build: $(SRC_DIRS)
	@echo "::: Package $(NAME) build complete :::"

# Use R to install R modules and any missing prerequisites into a cache dir.
$(R_MODULES_CACHE):
	mkdir -p -m 755 $(R_MODULES_CACHE)
	mkdir -p -m 755 $(JAGS_HOME) || true
	$(call BIND_MOUNT, $(PKGROOT), $(R_MODULES_CACHE))
	$(call BIND_MOUNT, $(JAGS_HOME), $(JAGS_CACHE))
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_R); \
	  $(MODULE_LOAD_LAPACK); \
	  export JAGS_INCLUDE=$(JAGS_HOME)/include/JAGS; \
	  export JAGS_LIB=$(JAGS_HOME)/lib; \
	  export LD_LIBRARY_PATH=$${JAGS_LIB}:$${LD_LIBRARY_PATH}; \
	  for F in $(R_MODULES); do \
	    opts=""; \
	    R CMD INSTALL $$F*gz --configure-args="$$opts"; \
	  done \
	)
	$(call BIND_UMOUNT, $(JAGS_HOME))
	rmdir -p $(JAGS_HOME) || true
	$(call BIND_UMOUNT, $(PKGROOT))
	for F in $(R_MODULES); do \
	  if test ! -d $(R_MODULES_CACHE)/$$F; then \
	    echo error: module $$F build failed; \
	    exit 2; \
	  fi; \
	done

# Package R modules and each prequisite into individual rpms, using R to
# extract the module version number.  Also have to add each rpm name to the
# roll node file so that Rocks will install it.
install:: $(R_MODULES_CACHE)
	-mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	if test -z "$(R_MODULE)"; then \
	  for module in `ls $(R_MODULES_CACHE)`; do \
	    version=`module load R && export R_LIBS=$(R_MODULES_CACHE) && R -q -e "packageVersion('$${module}')" | grep ^.1 | awk -F"'" '{print $$2}'`; \
	    $(MAKE) NAME=sdsc-R-$${module} VERSION=$${version} R_MODULE=$${module} rpm; \
	    perl -pi -e 'print $$_ and s/$(NAME)/sdsc-R-'$${module}'/ if m/$(NAME)/' $(NODE_FILE); \
	  done; \
	else \
	  cp -r $(R_MODULES_CACHE)/$(R_MODULE) $(ROOT)/$(PKGROOT); \
	fi
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -fr DESCRIPTION LICENSE $(R_MODULES)
