#!/usr/bin/bash
#
# CDDL HEADER START
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
# CDDL HEADER END
#
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2016-2018 Jim Klimov
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=ccache                   # App name
VER=3.3.6                     # App version
PKG=developer/ccache          # Package name (without prefix)
SUMMARY="ccache - cacher of GCC-compiled files to avoid doing the same job twice"
DESC="$SUMMARY ($VER)"

#NO_PARALLEL_MAKE=1
#BUILDARCH=32

BUILD_DEPENDS_IPS="developer/build/autoconf text/gnu-grep"
DEPENDS_IPS="system/library"

# We build backwards here on purpose so that 32bit binaries win (for install collisions).
build() {
    if [[ $BUILDARCH == "64" || $BUILDARCH == "both" ]]; then
        build64
    fi
    if [[ $BUILDARCH == "32" || $BUILDARCH == "both" ]]; then
        build32
    fi
}

CONFIGURE_OPTS="--sysconfdir=/etc"
CFLAGS="-D_GNU_SOURCE -D__EXTENSIONS__ --std=c99"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
