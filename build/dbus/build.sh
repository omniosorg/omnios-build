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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=dbus
VER=1.12.0
PKG=dbus ##IGNORE##
SUMMARY="$PROG - IPC-based message notifications"
DESC="$SUMMARY"

# Use old gcc4 standards level for this.
CFLAGS+="-std=gnu89"
CPPFLAGS+="-D__EXTENSIONS__ -D_REENTRANT"
CONFIGURE_OPTS="
    --with-dbus-daemondir=/usr/lib
    --bindir=/usr/bin
    --localstatedir=/var
    --libexecdir=/usr/libexec
    --with-x=no
    --with-dbus-user=root
    --disable-static
"

LIBTOOL_NOSTDLIB=libtool

# We build backwards here on purpose so that 32bit binaries win
# (for install collisions).
build() {
    [[ $BUILDARCH =~ ^(64|both)$ ]] && build64
    [[ $BUILDARCH =~ ^(32|both)$ ]] && build32
}

post_install() {
    mkdir -p $DESTDIR/etc/security/auth_attr.d
    mkdir -p $DESTDIR/etc/security/prof_attr.d
    cp files/auth-system%2Flibrary%2Fdbus \
        $DESTDIR/etc/security/auth_attr.d/system%2Flibrary%2Fdbus
    cp files/prof-system%2Flibrary%2Fdbus \
        $DESTDIR/etc/security/prof_attr.d/system%2Flibrary%2Fdbus
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_isa_stub
install_smf system dbus.xml svc-dbus
post_install

PKG=system/library/dbus
SUMMARY="Simple IPC library based on messages"
DESC="Simple IPC library based on messages"
make_package dbus.mog

PKG=system/library/libdbus
SUMMARY="Simple IPC library based on messages - client libraries"
DESC="Simple IPC library based on messages - client libraries"
make_package libdbus.mog

clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
