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

# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2020 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=gmp
VER=6.2.0
PKG=library/gmp
SUMMARY="GNU MP"
DESC="The GNU Multiple Precision (Bignum) Library"

BUILD_DEPENDS_IPS=developer/build/libtool

TESTSUITE_SED="
    /^ *[a-z]/d
    /^Making /d
"

# Support for a "fat" binary on i386, with CPU autodetection.
CONFIGURE_OPTS="
    --includedir=$PREFIX/include/gmp
    --localstatedir=/var
    --enable-shared
    --disable-static
    --enable-cxx
    --enable-fat
"

CONFIGURE_OPTS_32+=" ABI=32"
CONFIGURE_OPTS_64+=" ABI=64"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
