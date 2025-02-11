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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=tcsh
VER=6.24.15
PKG=shell/tcsh
SUMMARY="Tenex C-shell (tcsh)"
DESC="A Unix shell based on and compatible with the C shell (csh)"

UCPROG=${PROG^^}
UVER=${VER//./_}

set_builddir "$PROG-$UCPROG$UVER"
set_standard XPG6
set_arch 64

build_init() {
    export CC_FOR_GETHOST="$GCC"
    export CPPFLAGS_FOR_BUILD="${CPPFLAGS[0]} ${CPPFLAGS[$BUILD_ARCH]}"
    export CFLAGS_FOR_BUILD="${CFLAGS[0]} ${CFLAGS[$BUILD_ARCH]}"
    export LDFLAGS_FOR_BUILD="${LDFLAGS[0]} ${LDFLAGS[$BUILD_ARCH]}"
    MAKEFLAGS+=" -e"
}

init
download_source $PROG "$UCPROG$UVER"
patch_source
prep_build autoconf -autoreconf
build
PATH=$GNUBIN:$USRBIN run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
