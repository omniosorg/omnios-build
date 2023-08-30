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
# Copyright 2014 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
# Copyright 2023 Richard Lowe <richlowe@richlowe.net>

. ../../lib/build.sh

PKG=developer/gcc10
PROG=gcc
VER=10.4.0
ILVER=il-1
SUMMARY="gcc $VER-$ILVER"
DESC="The GNU Compiler Collection"

REPO=$GITHUB/richlowe/$PROG
BRANCH=il-${VER//./_}-arm64
ARCH=aarch64

GCCMAJOR=${VER%%.*}
OPT=/opt/gcc-$GCCMAJOR

XFORM_ARGS="-D MAJOR=$GCCMAJOR -D OPT=$OPT -D GCCVER=$VER"
BMI_EXPECTED=1
NO_SONAME_EXPECTED=1

PREFIX=$OPT

[ "$CLIBUILDARCH" = $ARCH ] || logerr "Incorrect arch selected, use -a $ARCH"

# Build gcc with itself
set_gccver $GCCMAJOR

set_arch 64
set_ssp none
set_patchdir patches.$ARCH
TRIPLET=${TRIPLETS[$ARCH]}
NATIVE_TRIPLET=${TRIPLETS[$BUILD_ARCH]}
clear_archflags

# Use bash for all shells - some corruption occurs in libstdc++-v3/config.status
# otherwise.
export CONFIG_SHELL=$SHELL
export MAKESHELL=$SHELL
# Place the GNU utilities first in the path
export PATH=$GNUBIN:$PATH

LANGUAGES="c,c++"

RUN_DEPENDS_IPS="
    developer/linker
    developer/gnu-binutils
    system/header
    system/library/c-runtime
    system/library/g++-runtime
    system/library/gcc-runtime
"

export CC_FOR_BUILD=$GCC
export CXX_FOR_BUILD=$GXX
export LD=/bin/ld
export LD_FOR_HOST=/bin/ld
export LD_FOR_BUILD=/opt/cross/$ARCH/bin/ld
export LD_FOR_TARGET=/bin/ld
export AS_FOR_BUILD=/opt/cross/$ARCH/bin/$TRIPLET-as
export CFLAGS_FOR_TARGET="-mno-outline-atomics -mtls-dialect=trad"
export CXXFLAGS_FOR_TARGET="-mno-outline-atomics -mtls-dialect=trad"
export STRIP="/usr/bin/strip -x"
export STRIP_FOR_TARGET="$STRIP"

HARDLINK_TARGETS="
    ${PREFIX/#\/}/bin/$TRIPLET-gcc-$VER
    ${PREFIX/#\/}/bin/$TRIPLET-gcc-ar
    ${PREFIX/#\/}/bin/$TRIPLET-gcc-nm
    ${PREFIX/#\/}/bin/$TRIPLET-gcc-ranlib
    ${PREFIX/#\/}/bin/$TRIPLET-c++
    ${PREFIX/#\/}/bin/$TRIPLET-g++
"

PKGDIFF_HELPER="
    s^/$GCCMAJOR\\.[0-9]\\.[0-9]([/ ])^/$GCCMAJOR.x.x\\1^
    s^/gcc-$GCCMAJOR\\.[0-9]\\.[0-9]^/gcc-$GCCMAJOR.x.x^
"

CONFIGURE_OPTS="
    --prefix=$OPT
    --build $NATIVE_TRIPLET
    --host $TRIPLET
    --target $TRIPLET
    --with-gmp-include=/usr/include/gmp
    --with-ld=$LD --without-gnu-ld
    --with-as=/usr/bin/gas --with-gnu-as
    --with-build-config=no
    --enable-languages=$LANGUAGES
    --enable-shared
    --with-system-zlib
    --enable-plugins
    --enable-__cxa_atexit
    --enable-initfini-array
    --disable-libitm
    --with-diagnostics-urls=auto-if-env
    --disable-bootstrap
    --disable-decimal-float
    --disable-nls
    --enable-c99
    --enable-long-long
    --enable-tls
    gcc_cv_have_tls=yes
    enable_frame_pointer=yes
"
CONFIGURE_OPTS[WS]="
    --with-boot-ldflags=\"-R$OPT/lib\"
    --with-boot-cflags=\"-O2\"
    --with-pkgversion=\"$DISTRO $RELVER/$VER-$ILVER\"
    --with-bugurl=$HOMEURL/about/contact
"
LDFLAGS="-R$OPT/lib"
CPPFLAGS+=" -D_TS_ERRNO"

export glibcxx_cv_math11_int_overload=no
export glibcxx_cv_math11_fp_overload=no

make_install() {
    logmsg "--- make install"
    logcmd $MAKE DESTDIR=${DESTDIR} install-strip || \
        logerr "--- Make install failed"
}

tests() {
    # Specific tests to ensure that certain features are properly detected
    $EGREP -s gcc_cv_as_eh_frame=yes $TMPDIR/$BUILDDIR/gcc/config.log \
        || logerr "The .eh_frame based unwinder is not enabled"

    $EGREP -s gcc_cv_use_emutls=no \
        $TMPDIR/$BUILDDIR/$TRIPLET/libgcc/config.log \
        || logerr "Emulated TLS is enabled"

    $EGREP -s gcc_cv_libc_provides_ssp=yes $TMPDIR/$BUILDDIR/gcc/config.log \
        || logerr "libc support for SSP was not detected"
}

init
clone_github_source $PROG $REPO $BRANCH
append_builddir $PROG
patch_source
# gcc should be built out-of-tree
prep_build autoconf -oot
build -noctf
tests
logcmd cp $TMPDIR/$SRC_BUILDDIR/COPYING* $TMPDIR/$BUILDDIR
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
