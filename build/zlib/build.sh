#!/usr/bin/bash

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

# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=zlib
VER=1.2.11
PKG=library/zlib
SUMMARY="$PROG - A massively spiffy yet delicately unobtrusive compression library"
DESC="$SUMMARY"

DEPENDS_IPS="system/library/gcc-runtime"
BUILD_DEPENDS_IPS="$DEPENDS_IPS developer/sunstudio12.1"

CFLAGS+=" -DNO_VIZ"

CONFIGURE_OPTS_32="--prefix=$PREFIX
    --includedir=$PREFIX/include
    --libdir=$PREFIX/lib"

CONFIGURE_OPTS_64="--prefix=$PREFIX
    --includedir=$PREFIX/include
    --libdir=$PREFIX/lib/$ISAPART64"

install_license(){
    # This is fun, take from the zlib.h header
    /bin/awk '/Copyright/,/\*\//{if($1 != "*/"){print}}' \
        $TMPDIR/$BUILDDIR/zlib.h > $DESTDIR/license
}

make_prog32() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logcmd gmake LDSHARED="gcc -shared -nostdlib" || logerr "gmake failed"
    popd > /dev/null
}

make_prog64() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logcmd gmake LDSHARED="gcc -shared -nostdlib" || logerr "gmake failed"
    popd > /dev/null
}

# Relocate the libs to /lib, to match upstream
move_libs() {
    logcmd mkdir -p $DESTDIR/lib/amd64
    logcmd ln -s amd64 $DESTDIR/lib/64
    logcmd mv $DESTDIR/usr/lib/lib* $DESTDIR/lib || \
        logerr "failed to move libs (32-bit)"
    logcmd mv $DESTDIR/usr/lib/amd64/lib* $DESTDIR/lib/amd64 || \
        logerr "failed to move libs (64-bit)"
    pushd $DESTDIR/usr/lib >/dev/null
    logcmd ln -s ../../lib/libz.so.$VER libz.so
    logcmd ln -s ../../lib/libz.so.$VER libz.so.1
    logcmd ln -s ../../lib/libz.so.$VER libz.so.$VER
    popd >/dev/null
    pushd $DESTDIR/usr/lib/amd64 >/dev/null
    logcmd ln -s ../../../lib/64/libz.so.$VER libz.so
    logcmd ln -s ../../../lib/64/libz.so.$VER libz.so.1
    logcmd ln -s ../../../lib/64/libz.so.$VER libz.so.$VER
    popd>/dev/null
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite
make_lintlibs z /usr/lib /usr/include
make_isa_stub
install_license
move_libs
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
