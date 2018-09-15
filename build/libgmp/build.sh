#!/usr/bin/bash
#
# {{{ CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END }}}
#
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=gmp
VER=6.1.2
VERHUMAN=$VER
PKG=library/gmp
SUMMARY="GNU MP $VER"
DESC="The GNU Multiple Precision (Bignum) Library"

# Cribbed from upstream, used to set MPN_PATH during configure
MPN32="x86/pentium x86 generic"
MPN64="x86_64/pentium4 x86_64 generic"
export MPN32 MPN64

BUILD_DEPENDS_IPS=developer/build/libtool

CFLAGS+=" -fexceptions"
CONFIGURE_OPTS="
    --includedir=$PREFIX/include/gmp
    --localstatedir=/var
    --enable-shared
    --disable-static
    --disable-libtool-lock
    --disable-alloca
    --enable-cxx
    --enable-fft
    --enable-mpbsd
    --disable-fat
    --with-pic
"

save_function configure32 _configure32
configure32() {
    export ABI=32
    export MPNPATH="$MPN32"
    _configure32
}

save_function configure64 _configure64
configure64() {
    export ABI=64
    export MPNPATH="$MPN64"
    _configure64
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
