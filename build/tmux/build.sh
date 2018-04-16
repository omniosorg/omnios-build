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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=tmux
VER=2.7
VERHUMAN=$VER
PKG=terminal/tmux
SUMMARY="Terminal multiplexer"
DESC="$SUMMARY"
LIBEVENT_VER=2.1.8
LDIR=libevent-${LIBEVENT_VER}-stable
XFORM_ARGS+=" -DLIBEVENT=$LIBEVENT_VER"

BUILDARCH=32
CONFIGURE_OPTS_32+=" --bindir=/usr/bin"
CPPFLAGS="\
    -I$TMPDIR/$PROG-$VER/$LDIR/include/event2 \
    -I$TMPDIR/$PROG-$VER/$LDIR/include -I/usr/include/ncurses \
"
LDFLAGS="-L$TMPDIR/$PROG-$VER/$LDIR/.libs -lsocket -lnsl -lsendfile"

build_libevent() {
    pushd $TMPDIR/$BUILDDIR/$LDIR > /dev/null
    logmsg "--- configuring libevent"
    logcmd ./configure --disable-static --disable-libevent-install \
        || logerr "failed libevent configure"

    # We have to patch libevent as well. Change PATCHDIR temporarily.
    oBUILDDIR=$BUILDDIR
    BUILDDIR+="/$LDIR"
    PATCHDIR=patches-libevent
    patch_source
    PATCHDIR=patches
    BUILDDIR=$oBUILDDIR

    logmsg "--- building libevent"
    logcmd make || logerr "failed libevent build"
    popd > /dev/null
}

init
download_source $PROG $PROG $VER

# Download and build libevent as that is not part of core
_BUILDDIR=$BUILDDIR
BUILDDIR=$LDIR
download_source libevent libevent ${LIBEVENT_VER}-stable $TMPDIR/$_BUILDDIR
BUILDDIR=$_BUILDDIR
build_libevent

patch_source
prep_build
build
make_isa_stub
strip_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
