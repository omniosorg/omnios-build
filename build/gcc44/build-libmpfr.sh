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

PROG=mpfr
VER=3.1.0
VERHUMAN=$VER
PKG=developer/gcc44/libmpfr-gcc44
SUMMARY="gcc44 - private libmpfr"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="developer/gcc44/libgmp-gcc44"
DEPENDS_IPS="developer/gcc44/libgmp-gcc44"

# This stuff is in its own domain
PKGPREFIX=""

PATH=/usr/gnu/bin:/opt/gcc-4.4.4/bin:$PATH
export PATH
BUILDARCH=32
GCCVER=4.4.4
PREFIX=/opt/gcc-${GCCVER}
CC=gcc
CONFIGURE_OPTS="--with-gmp=/opt/gcc-${GCCVER}"

make_install32() {
    make_install
    logcmd rm -rf $DESTDIR/opt/gcc-${GCCVER}/share/info
}

reset_configure_opts
init
download_source $PROG $PROG $VER
prep_build
build
make_isa_stub
make_package libmpfr.mog depends.mog
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
