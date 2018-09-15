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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=libtool
VER=2.4.6
PKG=developer/build/libtool  ##IGNORE##
SUMMARY="unused; replaced below"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="autoconf automake"

# The "binaries" here are just shell scripts so arch doesn't matter
# The includes also are not arch-dependent
CONFIGURE_OPTS="
    --bindir=$PREFIX/bin
    --includedir=$PREFIX/include
    --disable-static
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub

PKG=developer/build/libtool
SUMMARY="GNU libtool utility"
DESC="GNU libtool - library support utility"
make_package libtool.mog

PKG=library/libtool/libltdl
SUMMARY="GNU libtool dlopen wrapper"
DESC="GNU libtool dlopen wrapper - libltdl"
make_package libltdl.mog

clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
