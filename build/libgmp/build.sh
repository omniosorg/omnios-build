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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=gmp
VER=6.2.1
PKG=library/gmp
SUMMARY="GNU MP"
DESC="The GNU Multiple Precision (Bignum) Library"

# Build library to use only common CPU features rather than those supported
# on the build machine.
MPN32="x86/pentium x86 generic"
MPN64="x86_64/pentium4 x86_64 generic"
export MPN32 MPN64

BUILD_DEPENDS_IPS=developer/build/libtool

TESTSUITE_SED="
    /^ *[a-z]/d
    /^Making /d
"

CFLAGS+=" -fexceptions"
LDFLAGS+=" $SSPFLAGS"
CONFIGURE_OPTS="
    --includedir=$PREFIX/include/gmp
    --localstatedir=/var
    --enable-shared
    --disable-static
    --disable-libtool-lock
    --disable-alloca
    --enable-cxx
    --enable-fft
    --disable-fat
    --with-pic
    gmp_cv_asm_x86_mulx=no
"

CONFIGURE_OPTS[i386_WS]="
    ABI=32
    MPN_PATH=\"$MPN32\"
"

CONFIGURE_OPTS[amd64_WS]="
    ABI=64
    MPN_PATH=\"$MPN64\"
"

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
