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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=ncurses
VER=6.1-20180818
VERHUMAN=$VER
BUILDDIR=$PROG-$VER
VER=${VER/-/.}
PKG=library/ncurses
SUMMARY="A CRT screen handling package"
DESC="Utilities and shared libraries for terminal handling"

DEPENDS_IPS="shell/bash system/library"

LD=/usr/ccs/bin/ld
export LD
GPREFIX=$PREFIX/gnu
CONFIGURE_OPTS_COMMON="
    --program-prefix=g
    --mandir=$GPREFIX/share/man
    --disable-overwrite
    --without-normal
    --with-shared
    --enable-widec
    --disable-lib-suffixes
    --without-debug
    --enable-string-hacks
    --includedir=$PREFIX/include/ncurses
    --prefix=$GPREFIX
"
CONFIGURE_OPTS_ABI6="$CONFIGURE_OPTS_COMMON"
CONFIGURE_OPTS_ABI5="$CONFIGURE_OPTS_COMMON --with-abi-version=5"
CONFIGURE_OPTS_32="
    --bindir=$PREFIX/bin/$ISAPART"

CONFIGURE_OPTS_64="
    --bindir=$PREFIX/bin/$ISAPART64
    --libdir=$GPREFIX/lib/$ISAPART64"

gnu_links() {
    # put libncurses* in PREFIX/lib so other programs don't need to link
    # with rpath
    mkdir -p $DESTDIR/$PREFIX/lib/$ISAPART64
    mv $DESTDIR/$GPREFIX/lib/libncurses* $DESTDIR/$PREFIX/lib
    mv $DESTDIR/$GPREFIX/lib/$ISAPART64/libncurses* \
       $DESTDIR/$PREFIX/lib/$ISAPART64
}

save_function make_install make_install_orig
make_install_libs() {
    logmsg "--- make install.libs"
    logcmd $MAKE DESTDIR=${DESTDIR} install.libs || \
        logerr "--- Make install.libs failed"
}
build_abi5() {
    logmsg '--- Building backward-compatible ABI version 5 libraries.'
    CONFIGURE_OPTS="$CONFIGURE_OPTS_ABI5"
    save_function make_install_libs make_install
    build
}
build_abi6() {
    logmsg '--- Building ABI version 6.'
    CONFIGURE_OPTS="$CONFIGURE_OPTS_ABI6"
    save_function make_install_orig make_install
    build
}

init
download_source $PROG $PROG $VERHUMAN
patch_source
prep_build
build_abi5
build_abi6
make_isa_stub
gnu_links
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
