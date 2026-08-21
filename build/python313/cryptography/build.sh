#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}
#
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.
#
. ../../../lib/build.sh

PKG=library/python-3/cryptography-313
PROG=cryptography
VER=50.0.0
SUMMARY="Cryptographic recipes and primitives"
DESC="$SUMMARY"

. $SRCDIR/../common.sh

RUN_DEPENDS_IPS+="
    library/python-$PYMVER/cffi-$SPYVER
"

# The cryptography module includes rust code and is built with maturin
BUILD_DEPENDS_IPS+="
    library/python-$PYMVER/cffi-$SPYVER
    library/python-$PYMVER/maturin-$SPYVER
    library/python-$PYMVER/setuptools-$SPYVER
"

# For cargo, and the maturin build tool which is delivered under the python
# bin directory.
PATH+=:$OOCEBIN:$PREFIX/lib/python$PYVER/bin

# Use the packaged maturin build backend rather than having pip download and
# build one from PyPI. This is particularly important when cross-compiling
# since a maturin built inside the isolated build environment would be built
# for the target architecture and could not run on the build machine.
PEP518OPTS+=" --no-build-isolation"

python_build_aarch64() {
    typeset arch=aarch64

    python_pyo3_cross_setup $arch

    CFLAGS[$arch]+=" -mtls-dialect=trad"

    DESTDIR+=".$arch" \
        python_build_arch $arch
}

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
