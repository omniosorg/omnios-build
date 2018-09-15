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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
#
. ../../lib/functions.sh

GCCVER=4.4.4
PATH=/usr/gnu/bin:/opt/gcc-${GCCVER}/bin:$PATH
export LD_LIBRARY_PATH=/opt/gcc-${GCCVER}/lib

PROG=gmp
VER=5.0.2
VERHUMAN=$VER
PKG=developer/gcc44/libgmp-gcc44
SUMMARY="gcc44 - private libgmp"
DESC="$SUMMARY"

# This stuff is in its own domain
PKGPREFIX=""
BUILDARCH=32
PREFIX=/opt/gcc-${GCCVER}
CC=gcc
CONFIGURE_OPTS="--enable-cxx"
CFLAGS="-fexceptions"
ABI=32
export ABI

make_install32() {
    logcmd mkdir -p $DESTDIR/opt/gcc-${GCCVER}/share/info
    make_install
    logcmd rm -rf $DESTDIR/opt/gcc-${GCCVER}/share/info
}

reset_configure_opts
init
download_source $PROG $PROG $VER
prep_build
build
make_isa_stub
make_package libgmp.mog depends.mog
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
