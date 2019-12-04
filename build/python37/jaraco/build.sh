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
#
# }}}

# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.

. ../../../lib/functions.sh

PKG=library/python-3/jaraco-37
PROG=jaraco
VER=1.0.0
SUMMARY="jaraco"
DESC="A bundle of jaraco python modules"

. $SRCDIR/../common.sh

typeset -A packages
packages[classes]=2.0
packages[collections]=2.1
packages[functools]=2.0
packages[text]=3.2.0

# jaraco.functools is obsoleted and replaced by this combined jaraco package.
# However, in order to allow for a seamless upgrade, we have to list
# jaraco.functools as a dependency so that it will be updated to the obsoleted
# version and have its files removed. Failing to do this causes pkg to complain
# about conflicting actions.
RUN_DEPENDS_IPS+=" library/python-$PYVER/jaraco.functools-$SPYVER@2.0-$RELVER.1"

init
prep_build

for pkg in "${!packages[@]}"; do
    ver=${packages[$pkg]}
    BUILDDIR=$PROG.$pkg-$ver

    note -n "Building $PROG.$pkg"
    download_source pymodules/$PROG.$pkg $PROG.$pkg $ver
    python_build
done

strip_install
EXTRACTED_SRC=$BUILDDIR make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
