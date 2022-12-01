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
#
. ../../lib/build.sh

PROG=dbus-glib
VER=0.112
PKG=system/library/libdbus-glib
SUMMARY="$PROG - GNOME GLib DBUS integration library"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="
    system/library/libdbus
    library/glib2
"

CONFIGURE_OPTS="
    --disable-fam
    --disable-dtrace
    --disable-tests
    GLIB_GENMARSHAL=/usr/bin/glib-genmarshal
"
CONFIGURE_OPTS[WS]="
    DBUS_LIBS=-ldbus-1
    DBUS_GLIB_LIBS=\"-lglib-2.0 -lgobject-2.0 -lgio-2.0\"
"
CONFIGURE_OPTS[i386_WS]="
    DBUS_CFLAGS=\"-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include\"
    DBUS_GLIB_CFLAGS=\"-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include\"
"
CONFIGURE_OPTS[amd64_WS]="
    DBUS_CFLAGS=\"-I/usr/include/dbus-1.0 -I/usr/lib/amd64/dbus-1.0/include\"
    DBUS_GLIB_CFLAGS=\"-I/usr/include/glib-2.0 -I/usr/lib/amd64/glib-2.0/include\"
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
