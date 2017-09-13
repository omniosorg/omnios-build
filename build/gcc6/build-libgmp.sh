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
# Copyright 2017 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh
. $SRCDIR/common.sh

PROG=gmp         # App name
VER=6.1.2        # App version
VERHUMAN=$VER    # Human-readable version
PKG=developer/gcc6/libgmp-gcc6
SUMMARY="$PKGV - private libgmp"
DESC="$SUMMARY" # Longer description

LOGFILE+=".$PROG"

# This stuff is in its own domain
PKGPREFIX=""

[ "$BUILDARCH" = "both" ] && BUILDARCH=32
PREFIX=$OPT
CC=gcc
CONFIGURE_OPTS="--enable-cxx --disable-assembly"
CFLAGS="-fexceptions"
ABI=32
export ABI

reset_configure_opts
init
download_source $PROG $PROG $VER
prep_build
build
make_isa_stub
make_package libgmp.mog depends.mog
clean_up
