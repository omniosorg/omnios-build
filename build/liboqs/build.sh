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

# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=liboqs
VER=0.10.0
PKG=library/security/liboqs
SUMMARY="$PROG"
DESC="An open source C library for quantum-safe cryptographic algorithms"

CONFIGURE_OPTS="
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DBUILD_SHARED_LIBS=ON
"
CONFIGURE_OPTS[i386]=
CONFIGURE_OPTS[amd64]="
    -DCMAKE_INSTALL_LIBDIR=lib/amd64
"

_run_testsuite() {

    local _site=$PREFIX/lib/$PROG/python$PYTHONVER
    local _pip="$PYTHON -mpip install -Ut $TMPDIR/_deproot/$_site"

    logmsg "--- installing pytest-xdist"
    logcmd mkdir -p $TMPDIR/_deproot/$_site \
        || logerr "mkdir $TMPDIR/_deproot/$_site"
    logcmd $_pip pytest-xdist

    export PYTHONPATH=$TMPDIR/_deproot/$_site

    run_testsuite run_tests
}

init
download_source $PROG $VER
patch_source
prep_build cmake+ninja
build
_run_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
