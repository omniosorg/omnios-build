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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=tuntap
VER=1.3.3
PKG=driver/tuntap
SUMMARY="TUN/TAP driver for OmniOS"
DESC="TUN/TAP driver for OmniOS based on the Universal TUN/TAP Driver"

# do not build 64bit objects when compiling for 32bit objects
CONFIGURE_OPTS_32="--disable-64bit"

# Re-define make_clean() to always run 'make clean' due to there because
# 'make distclean' in tun/tap's Makefile does not run 'make clean', and
# thus keeps 32bit objects around when we try to compile 64bit ones.
make_clean() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logcmd $MAKE clean
    logcmd $MAKE distclean
    popd > /dev/null
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
