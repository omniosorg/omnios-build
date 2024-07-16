#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
# Copyright 2023 Richard Lowe <richlowe@richlowe.net>

. ../../lib/build.sh

PROG=binutils
VER=2.39
PKG=developer/gnu-binutils
SUMMARY="GNU binary utilities"
DESC="A set of programming tools for creating and managing binary programs, "
DESC+="object files, libraries, etc."

REPO=$GITHUB/richlowe/binutils-gdb
BRANCH=illumos-arm64
ARCH=aarch64

[ "$CLIBUILDARCH" = $ARCH ] || logerr "Incorrect arch selected, use -a $ARCH"

set_arch 64
set_patchdir patches.$ARCH
CTF_FLAGS+=" -s"

TRIPLET=${TRIPLETS[$ARCH]}
NATIVE_TRIPLET=${TRIPLETS[$BUILD_ARCH]}
clear_archflags

export LD=/bin/ld
export LD_FOR_HOST=/bin/ld
export CC_FOR_BUILD=$GCC
export CXX_FOR_BUILD=$GXX
export LD_FOR_BUILD=/opt/cross/$ARCH/bin/ld
export AS_FOR_BUILD=/opt/cross/$ARCH/bin/$TRIPLET-as
export AR_FOR_BUILD=/opt/cross/$ARCH/bin/$TRIPLET-ar
export LD_FOR_TARGET=/bin/ld
export CFLAGS_FOR_TARGET="-mtls-dialect=trad"
export CXXFLAGS_FOR_TARGET="$CFLAGS_FOR_TARGET"
export STRIP="/usr/bin/strip -x"
export STRIP_FOR_TARGET="$STRIP"

HARDLINK_TARGETS="
    usr/bin/gar
    usr/bin/gas
    usr/bin/gld
    usr/bin/gnm
    usr/bin/gobjcopy
    usr/bin/gobjdump
    usr/bin/granlib
    usr/bin/greadelf
    usr/bin/gstrip
"

CONFIGURE_OPTS="
    --build $NATIVE_TRIPLET
    --host $TRIPLET
    --target $TRIPLET
    --exec-prefix=/usr/gnu
    --program-prefix=g
    --enable-largefile
    --with-system-zlib
"

CFLAGS+=" $CFLAGS_FOR_TARGET"
CXXFLAGS+=" $CFLAGS_FOR_TARGET"

build_init() {
    typeset d=${SYSROOT[$ARCH]}/usr

    CONFIGURE_OPTS+="
        --with-libgmp-prefix=$d
    "
}

# Program header data segments are RWX on illumos for at least 32-bit
CONFIGURE_OPTS+=" --enable-warn-rwx-segments=no"

XFORM_ARGS="-D GNU_ARCH=${TRIPLETS[$ARCH]}"

# stop binutils 2.34 from building info files
MAKE_ARGS="MAKEINFO=/usr/bin/true"
MAKE_INSTALL_ARGS="$MAKE_ARGS"

init
clone_github_source $PROG $REPO $BRANCH
append_builddir $PROG
patch_source
prep_build autoconf -oot
build -noctf
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
