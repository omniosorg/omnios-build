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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PKG=developer/gcc7
PROG=gcc
VER=7.5.0
ILVER=il-1
SUMMARY="gcc $VER-$ILVER"
DESC="The GNU Compiler Collection"

GCCMAJOR=${VER%%.*}
OPT=/opt/gcc-$GCCMAJOR

XFORM_ARGS="-D MAJOR=$GCCMAJOR -D OPT=$OPT -D GCCVER=$VER"
BMI_EXPECTED=1

# Build gcc with itself
set_gccver $GCCMAJOR
set_ssp none
set_arch 32

# Although we're building a 32-bit version of the compiler, gcc will take
# care of building 32 and 64-bit objects to support its toolchain. We need
# to unset the build flags and leave it to the gcc build system.
clear_archflags

RUN_DEPENDS_IPS="
    developer/linker
    developer/gnu-binutils
    system/header
    system/library/c-runtime
"

BUILD_DEPENDS_IPS="
    ooce/developer/autogen
    ooce/developer/dejagnu
"

PREFIX=$OPT

CC=gcc

export LD=/bin/ld
export LD_FOR_HOST=$LD
export LD_FOR_TARGET=$LD
export STRIP="/usr/bin/strip -x"
export STRIP_FOR_TARGET="$STRIP"
ARCH=$TRIPLET32

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

CONFIGURE_OPTS[i386]="--prefix=$OPT"
CONFIGURE_OPTS="
    --host $ARCH
    --build $ARCH
    --target $ARCH
    --with-boot-ldflags=-R$OPT/lib
    --with-gmp-include=/usr/include/gmp
    --with-ld=$LD --without-gnu-ld
    --with-as=/usr/bin/gas --with-gnu-as
    --with-build-time-tools=/usr/gnu/$TRIPLET64/bin
    --enable-languages=c,c++,fortran,lto
    --enable-plugins
    --enable-__cxa_atexit
    --enable-initfini-array
    --disable-libitm
    enable_frame_pointer=yes
"
CONFIGURE_OPTS[WS]="
    --with-boot-cflags=\"-g -O2\"
    --with-pkgversion=\"OmniOS $RELVER/$VER-$ILVER\"
    --with-bugurl=$HOMEURL/about/contact
"
LDFLAGS[i386]="-R$OPT/lib"
CPPFLAGS+=" -D_TS_ERRNO"

# If the selected compiler is the same version as the one we're building
# then the three-stage bootstrap is unecessary and some build time can be
# saved.
if [ -z "$FORCE_BOOTSTRAP" -a "`gcc -dumpversion`" = "$VER" ]; then
    CONFIGURE_OPTS+=" --disable-bootstrap"
    logmsg -n "--- disabling bootstrap"
else
    logmsg -n "--- full bootstrap build"
fi

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
        $TMPDIR/$BUILDDIR/$ARCH/libgcc/config.log \
        || logerr "Emulated TLS is enabled"

    $EGREP -s gcc_cv_libc_provides_ssp=yes $TMPDIR/$BUILDDIR/gcc/config.log \
        || logerr "libc support for SSP was not detected"

    [ -n "$SKIP_TESTSUITE" ] && return
    if [ -z "$BATCH" ] && ! ask_to_testsuite; then
        return
    fi

    export GUILE_AUTO_COMPILE=0
    export PATH+=:$OOCEBIN
    # The tests can be run in parallel - we sort them afterwards for consistent
    # results.
    MAKE_TESTSUITE_ARGS+=" $MAKE_JOBS"
    # Some gcc tests (e.g. limits-exprparen.c) need a larger stack
    ulimit -Ss 16385
    # Lots of tests create core files via assertions
    ulimit -c 0
    # This causes the testsuite to be run three times, once with -m32, once
    # with -m64 and once with -m64 and -msave-args
    MAKE_TESTSUITE_ARGS+=" RUNTESTFLAGS=--target_board=unix/\{-m32,-m64,-m64/-msave-args\}"
    # If not in batch mode, we've already asked whether this should be run
    # above, so set BATCH
    BATCH=1 run_testsuite "check check-target" "" build.log.testsuite
    pushd $TMPDIR/$BUILDDIR >/dev/null
    # Sort the test results in the individual summary files
    find $TMPDIR/$BUILDDIR -name '*.sum' -type f | while read s; do
        cp $s $s.orig
        nawk '
            /^Running target unix/ { sorting = 1; print; next }
            /Summary .*===$/ { close("sort -k2"); sorting = 0; print; next }
            sorting { print | "sort -k2" }
            # The version lines include the build path
            /  version / { next }
            { print }
        ' < $s.orig > $s
    done
    make_param mail-report.log
    cat mail-report.log > $SRCDIR/testsuite.log.detail
    $EGREP ' Summary (for .*)?===$|^#' mail-report.log > $SRCDIR/testsuite.log
    popd >/dev/null
}

init
download_source $PROG $PROG $VER
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
