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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=bmake
VER=20171028
VERHUMAN=$VER
PKG=developer/bmake
SUMMARY="portable version of NetBSD make(1)"
DESC="$SUMMARY"

CONFIGURE_OPTS64="--prefix=$PREFIX"
# prefix doesn't get built into the binary correctly for some reason with just
# configure
export MAKEFLAGS="prefix=$PREFIX"
BUILDARCH=64
# bmake is apparently called with "-j observer-fds=3,4" or something if -j was
# given to gmake, which makes no sense. just build non-parallel
NO_PARALLEL_MAKE=1
REMOVE_PREVIOUS=1

init
BUILDDIR="bmake"
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
