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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PKG=developer/gcc7
PROG=gcc
VER=7.3.0
VERHUMAN=$VER
SUMMARY="gcc $VER"
DESC="The GNU Compiler Collection"

GCCMAJOR=${VER%%.*}
OPT=/opt/gcc-$GCCMAJOR

XFORM_ARGS="-D MAJOR=$GCCMAJOR -D OPT=$OPT -D GCCVER=$VER"

# Build gcc with itself
export LD_LIBRARY_PATH=$OPT/lib
set_gccver $GCCMAJOR

RUN_DEPENDS_IPS="
    developer/library/lint
    developer/linker
    developer/gnu-binutils
    system/header
"

[ "$BUILDARCH" = "both" ] && BUILDARCH=32
PREFIX=$OPT

reset_configure_opts
CC=gcc

export LD=/bin/ld
export LD_FOR_HOST=$LD
export LD_FOR_TARGET=$LD
export LD_OPTIONS="-zignore -zcombreloc -i"
ARCH=i386-pc-solaris2.11

# Strip binaries but preserve the symbol table
export STRIP="/bin/strip -x"

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
    --with-pkgversion=\"OmniOS $RELVER\"
    --with-bugurl=https://omniosce.org/about/contact
"
LDFLAGS32="-R$OPT/lib"

# If the selected compiler is the same version as the one we're building
# then the three-stage bootstrap is unecessary and some build time can be
# saved.
[ -z "$FORCE_BOOTSTRAP" ] \
    && [ "`gcc -v 2>&1 | nawk '/^gcc version/ { print $3 }'`" = "$VER" ] \
    && CONFIGURE_OPTS+=" --disable-bootstrap" \
    && logmsg "--- disabling bootstrap"

make_install() {
    logmsg "--- make install"
    logcmd $MAKE DESTDIR=${DESTDIR} install-strip || \
        logerr "--- Make install failed"
}

# gcc should be built out-of-tree
OUT_OF_TREE_BUILD=1

init
download_source $PROG/releases/$PROG-$VER $PROG $VER
patch_source
prep_build
build
logcmd cp $TMPDIR/$SRC_BUILDDIR/COPYING* $TMPDIR/$BUILDDIR
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
