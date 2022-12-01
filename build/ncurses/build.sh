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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=ncurses
VER=6.3
PKG=library/ncurses
SUMMARY="A CRT screen handling package"
DESC="Utilities and shared libraries for terminal handling"

LD=/usr/ccs/bin/ld
export LD
GPREFIX=$PREFIX/gnu
CONFIGURE_OPTS_COMMON="
    --program-prefix=g
    --mandir=$GPREFIX/share/man
    --disable-overwrite
    --disable-stripping
    --without-normal
    --with-shared
    --enable-widec
    --disable-lib-suffixes
    --enable-pc-files
    --without-debug
    --enable-string-hacks
    --enable-symlinks
    --includedir=$PREFIX/include/ncurses
    --prefix=$GPREFIX
    --with-terminfo-dirs=$GPREFIX/share/terminfo
    --with-default-terminfo-dir=$GPREFIX/share/terminfo
"
CONFIGURE_OPTS_ABI6="$CONFIGURE_OPTS_COMMON"
CONFIGURE_OPTS_ABI5="$CONFIGURE_OPTS_COMMON --with-abi-version=5"
CONFIGURE_OPTS[i386]="
    --bindir=$PREFIX/bin/i386
    --with-pkg-config-libdir=$PREFIX/lib/pkgconfig
"
CONFIGURE_OPTS[amd64]="
    --bindir=$PREFIX/bin/amd64
    --libdir=$GPREFIX/lib/amd64
    --with-pkg-config-libdir=$PREFIX/lib/amd64/pkgconfig
"

build_abi5() {
    logmsg -n '--- Building backward-compatible ABI version 5 libraries.'
    CONFIGURE_OPTS="$CONFIGURE_OPTS_ABI5"
    MAKE_INSTALL_TARGET=install.libs
    build
}

build_abi6() {
    logmsg -n '--- Building ABI version 6.'
    CONFIGURE_OPTS="$CONFIGURE_OPTS_ABI6"
    MAKE_INSTALL_TARGET=install
    build
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build_abi5
build_abi6
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
