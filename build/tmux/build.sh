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
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=tmux
VER=3.7
PKG=terminal/tmux
SUMMARY="Terminal multiplexer"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS=library/ncurses
SKIP_LICENCES=tmux

set_arch 64

CONFIGURE_OPTS+=" --enable-utempter"

pre_build() {
    typeset arch=$1

    CPPFLAGS="-I $PREFIX/include/ncurses"
    LDFLAGS="-lsocket -lnsl -lsendfile"

    cross_arch $arch && addpath PKG_CONFIG_PATH \
        ${SYSROOT[$arch]}/$PREFIX/${LIBDIRS[$arch]}/pkgconfig

    true
}

init
prep_build
download_source $PROG $PROG $VER
patch_source
run_autoreconf -i
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
