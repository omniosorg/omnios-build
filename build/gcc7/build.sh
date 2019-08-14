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
# Copyright 2014 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PKG=developer/gcc7
PROG=gcc
VER=7.4.0
ILVER=il-3
SUMMARY="gcc $VER-$ILVER"
DESC="The GNU Compiler Collection"

GCCMAJOR=${VER%%.*}
OPT=/opt/gcc-$GCCMAJOR

XFORM_ARGS="-D MAJOR=$GCCMAJOR -D OPT=$OPT -D GCCVER=$VER"

# Build gcc with itself
set_gccver $GCCMAJOR
set_arch 32

RUN_DEPENDS_IPS="
    developer/linker
    developer/gnu-binutils
    system/header
    system/library/c-runtime
"

PREFIX=$OPT

CC=gcc

export LD=/bin/ld
export LD_FOR_HOST=$LD
export LD_FOR_TARGET=$LD
export LD_OPTIONS="-zignore -zcombreloc -i"
ARCH=i386-pc-solaris2.11

HARDLINK_TARGETS="
    ${PREFIX/#\/}/bin/$ARCH-gcc-$VER
    ${PREFIX/#\/}/bin/$ARCH-gcc-ar
    ${PREFIX/#\/}/bin/$ARCH-gcc-nm
    ${PREFIX/#\/}/bin/$ARCH-gcc-ranlib
    ${PREFIX/#\/}/bin/$ARCH-c++
    ${PREFIX/#\/}/bin/$ARCH-g++
    ${PREFIX/#\/}/bin/$ARCH-gfortran
"

PKGDIFF_HELPER="
    s^/$GCCMAJOR\\.[0-9]\\.[0-9]([/ ])^/$GCCMAJOR.x.x\\1^
    s^/gcc-$GCCMAJOR\\.[0-9]\\.[0-9]^/gcc-$GCCMAJOR.x.x^
"

CONFIGURE_OPTS_32="--prefix=$OPT"
CONFIGURE_OPTS="
    --host $ARCH
    --build $ARCH
    --target $ARCH
    --with-boot-ldflags=-R$OPT/lib
    --with-gmp-include=/usr/include/gmp
    --with-ld=$LD --without-gnu-ld
    --with-as=/usr/bin/gas --with-gnu-as
    --with-build-time-tools=/usr/gnu/$ARCH/bin
    --enable-languages=c,c++,fortran,lto
    --enable-plugins
    --enable-__cxa_atexit
    --enable-initfini-array
    --disable-libitm
    enable_frame_pointer=yes
"
CONFIGURE_OPTS_WS="
    --with-boot-cflags=\"-g -O2\"
    --with-pkgversion=\"OmniOS $RELVER/$VER-$ILVER\"
    --with-bugurl=https://omniosce.org/about/contact
"
LDFLAGS32="-R$OPT/lib"

# If the selected compiler is the same version as the one we're building
# then the three-stage bootstrap is unecessary and some build time can be
# saved.
[ -z "$FORCE_BOOTSTRAP" ] \
    && [ "`gcc -v 2>&1 | nawk '/^gcc version/ { print $3 }'`" = "$VER" ] \
    && CONFIGURE_OPTS+=" --disable-bootstrap" \
    && logmsg -n "--- disabling bootstrap"

make_install() {
    logmsg "--- make install"
    logcmd $MAKE DESTDIR=${DESTDIR} install-strip || \
        logerr "--- Make install failed"
}

tests() {
    egrep -s gcc_cv_as_eh_frame=yes $TMPDIR/$BUILDDIR/gcc/config.log \
        || logerr "The .eh_frame based unwinder is not enabled"
}

# gcc should be built out-of-tree
OUT_OF_TREE_BUILD=1

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
tests
logcmd cp $TMPDIR/$SRC_BUILDDIR/COPYING* $TMPDIR/$BUILDDIR
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
