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

. ../../../lib/build.sh

PKG=library/python-3/maturin-313
PROG=maturin
VER=1.14.1
SUMMARY="Build backend for rust-based python packages"
DESC="Build and publish crates with pyo3, cffi and uniffi bindings as well "
DESC+="as rust binaries as python packages"

. $SRCDIR/../common.sh

# maturin is a build-time tool which always runs on the native system, even
# when the module being built is being cross-compiled. It is not built for
# other architectures.

BUILD_DEPENDS_IPS+="
    library/python-$PYMVER/setuptools-rust-$SPYVER
"

# cargo is required to build the maturin binary
PATH+=:$OOCEBIN

# rust binaries contain BMI instructions, guarded by runtime CPU detection
BMI_EXPECTED=1

# Build using the packaged setuptools/setuptools-rust rather than having pip
# download the build dependencies from PyPI.
PEP518OPTS+=" --no-build-isolation"

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package $SRCDIR/../common.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
