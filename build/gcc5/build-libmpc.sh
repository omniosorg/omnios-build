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

PROG=mpc
VER=1.0.3
VERHUMAN=$VER
PKG=developer/gcc5/libmpc-gcc5
SUMMARY="$PKGV - private libmpc"
DESC="$SUMMARY"

LOGFILE+=".$PROG"

DEPENDS_IPS="developer/$PKGV/libgmp-$PKGV developer/$PKGV/libmpfr-$PKGV"

# This stuff is in its own domain
PKGPREFIX=""

[ "$BUILDARCH" = "both" ] && BUILDARCH=32
PREFIX=$OPT
CC=gcc
CONFIGURE_OPTS="--with-gmp=$OPT --with-mpfr=$OPT"
LDFLAGS="-R$OPT/lib -L$OPT/lib"

reset_configure_opts
init
download_source $PROG $PROG $VER
prep_build
build
make_isa_stub
make_package libmpc.mog depends.mog
clean_up
