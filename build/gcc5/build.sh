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
# Copyright 2017 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PKG=developer/gcc5
PROG=gcc
VER=5.5.0
VERHUMAN=$VER
SUMMARY="gcc ${VER}"
DESC="$SUMMARY"

GCCMAJOR=${VER%%.*}
OPT=/opt/gcc-$GCCMAJOR

XFORM_ARGS="-D MAJOR=$GCCMAJOR -D OPT=$OPT -D GCCVER=$VER"

# Build gcc with itself
export LD_LIBRARY_PATH=$OPT/lib
export PATH=/usr/perl5/$PERLVER/bin:$OPT/bin:$PATH

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

LD=/bin/ld
LD_FOR_HOST=/bin/ld
LD_FOR_TARGET=/bin/ld
export LD LD_FOR_HOST LD_FOR_TARGET

CONFIGURE_OPTS_32="--prefix=$OPT"
CONFIGURE_OPTS="
    --host i386-pc-solaris2.11
    --build i386-pc-solaris2.11
    --target i386-pc-solaris2.11
    --with-boot-ldflags=-R$OPT/lib
    --with-gmp-include=/usr/include/gmp
    --enable-languages=c,c++,fortran,lto
    --enable-__cxa_atexit
    --without-gnu-ld --with-ld=/bin/ld
    --with-as=/usr/bin/gas --with-gnu-as
    --with-build-time-tools=/usr/gnu/i386-pc-solaris2.11/bin"
LDFLAGS32="-R$OPT/lib"
export LD_OPTIONS="-zignore -zcombreloc -i"

# If the selected compiler is the same version as the one we're building
# then the three-stage bootstrap is unecessary and some build time can be
# saved.
[ "`gcc -v 2>&1 | nawk '/^gcc version/ { print $3 }'`" = "$VER" ] \
    && CONFIGURE_OPTS+=" --disable-bootstrap" \
    && logmsg "--- disabling bootstrap"

make_install() {
    logmsg "--- make install"
    logcmd $MAKE DESTDIR=${DESTDIR} install-strip || \
        logerr "--- Make install failed"
}

init
download_source $PROG/releases/$PROG-$VER $PROG $VER
patch_source
prep_build
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
