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
# Copyright 2014 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2017 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh
. $SRCDIR/common.sh

PROG=gcc
VER=$GCCVER
VERHUMAN=$VER
PKG=developer/gcc5
SUMMARY="gcc ${VER}"
DESC="$SUMMARY"

DEPENDS_IPS="
	developer/$PKGV/libgmp-$PKGV
	developer/$PKGV/libmpfr-$PKGV
	developer/$PKGV/libmpc-$PKGV
	developer/gnu-binutils
	developer/library/lint
	developer/linker
	system/library/gcc-$GCCMAJOR-runtime
"

# This stuff is in its own domain
PKGPREFIX=""

[ "$BUILDARCH" = "both" ] && BUILDARCH=32
PREFIX=$OPT

reset_configure_opts
CC=gcc

LD_FOR_TARGET=/bin/ld
export LD_FOR_TARGET
LD_FOR_HOST=/bin/ld
export LD_FOR_HOST
LD=/bin/ld
export LD

CONFIGURE_OPTS_32="--prefix=$OPT"
CONFIGURE_OPTS="\
	--host i386-pc-solaris2.11 \
	--build i386-pc-solaris2.11 \
	--target i386-pc-solaris2.11 \
	--with-boot-ldflags=-R$OPT/lib \
	--with-gmp=$OPT \
	--with-mpfr=$OPT \
	--with-mpc=$OPT \
	--enable-languages=c,c++,fortran,lto \
	--enable-__cxa_atexit \
	--without-gnu-ld --with-ld=/bin/ld \
	--with-as=/usr/bin/gas --with-gnu-as \
	--with-build-time-tools=/usr/gnu/i386-pc-solaris2.11/bin"
LDFLAGS32="-R$OPT/lib"
export LD_OPTIONS="-zignore -zcombreloc -i"

init
download_source $PROG/releases/$PROG-$VER $PROG $VER
patch_source
prep_build
build
make_package gcc.mog depends.mog
clean_up

