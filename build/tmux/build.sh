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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=tmux
VER=3.4
PKG=terminal/tmux
SUMMARY="Terminal multiplexer"
DESC="$SUMMARY"
LIBEVENT_VER=2.1.12
LIBEVENT_DIR=libevent-${LIBEVENT_VER}-stable
XFORM_ARGS+=" -DLIBEVENT=$LIBEVENT_VER"

BUILD_DEPENDS_IPS=library/ncurses
SKIP_LICENCES=tmux

init
prep_build

set_arch 64

#########################################################################
# Download and build a static version of libevent

CONFIGURE_OPTS="
    --prefix=/usr
    --disable-shared
    ac_cv_lib_xnet_socket=no
"

build_dependency libevent $LIBEVENT_DIR \
    libevent libevent ${LIBEVENT_VER}-stable

#########################################################################

note -n "-- Building $PROG"

CONFIGURE_OPTS+=" --enable-utempter"

pre_build() {
    typeset arch=$1

    CPPFLAGS=" \
        -I$DEPROOT/usr/include -I$DEPROOT/usr/include/event2 \
        -I/usr/include/ncurses \
    "
    LDFLAGS="-L$DEPROOT/usr/${LIBDIRS[$arch]} -lsocket -lnsl -lsendfile"

    cross_arch $arch && addpath PKG_CONFIG_PATH \
        ${SYSROOT[$arch]}/$PREFIX/${LIBDIRS[$arch]}/pkgconfig

    true
}

download_source $PROG $PROG $VER
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
