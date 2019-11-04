#!/usr/bin/env bash
[ -f .bashrc ] && . .bashrc
set -ev
INSTALL_DIR="${1:-/opt}"
# SIRF
git clone https://github.com/CCPPETMR/SIRF-SuperBuild --recursive -b docker-ccache $INSTALL_DIR/SIRF-SuperBuild
pushd $INSTALL_DIR/SIRF-SuperBuild

COMPILER_FLAGS="-D CMAKE_C_COMPILER='$(which gcc)' -D CMAKE_CXX_COMPILER='$(which g++)'"
echo $PATH
echo $COMPILER_FLAGS
echo $BUILD_FLAGS $EXTRA_BUILD_FLAGS
cmake $BUILD_FLAGS $EXTRA_BUILD_FLAGS $COMPILER_FLAGS .

make -j 2

[ -f INSTALL/share/gadgetron/config/gadgetron.xml ] || \
[ -f INSTALL/share/gadgetron/config/gadgetron.xml.example ] && \
  mv INSTALL/share/gadgetron/config/gadgetron.xml.example \
     INSTALL/share/gadgetron/config/gadgetron.xml

popd
