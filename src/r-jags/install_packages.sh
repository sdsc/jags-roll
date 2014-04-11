# installation script for R packages; pass installation root and openmpi root
# as arguments.

BUILD_PATH=$1
RJAGS_VERSION=$2
. /etc/profile.d/modules.sh
module load gnu
module load lapack
export LD_LIBRARY_PATH=${BUILD_PATH}/lib:${LD_LIBRARY_PATH}
/opt/R/bin/R CMD INSTALL --configure-args="--with-jags-lib=${BUILD_PATH}/lib --with-jags-include=${BUILD_PATH}/include/JAGS" rjags_${RJAGS_VERSION}.tar.gz -l /opt/R/local/lib 
