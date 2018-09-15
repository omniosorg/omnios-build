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

PROG=dbus-glib
VER=0.110
PKG=system/library/libdbus-glib
SUMMARY="$PROG - GNOME GLib DBUS integration library"
DESC="$SUMMARY"

DEPENDS_IPS="system/library/libdbus library/glib2 library/zlib system/library system/library/gcc-runtime"

CONFIGURE_OPTS="--disable-fam --disable-dtrace --disable-tests"
GLIB_GENMARSHAL=/usr/bin/glib-genmarshal
export GLIB_GENMARSHAL

save_function configure32 configure32_orig
save_function configure64 configure64_orig
configure32() {
    DBUS_LIBS=-ldbus-1
    export DBUS_LIBS
    DBUS_CFLAGS="-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include"
    export DBUS_CFLAGS
    DBUS_GLIB_CFLAGS="-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include"
    export DBUS_GLIB_CFLAGS
    DBUS_GLIB_LIBS="-lglib-2.0 -lgobject-2.0 -lgio-2.0"
    export DBUS_GLIB_LIBS
    configure32_orig
    logcmd mv config.status config.status.old || logerr "status backup failed"
    sed -e 's/S\["GLIB_GENMARSHAL"\]=""/S["GLIB_GENMARSHAL"]="glib-genmarshal"/' < config.status.old > config.status || logerr "sed failed"
    logcmd chmod 755 config.status || logerr "chmod failed"
    logcmd ./config.status || logerr "config status"
}
configure64() {
    DBUS_LIBS=-ldbus-1
    export DBUS_LIBS
    DBUS_CFLAGS="-I/usr/include/dbus-1.0 -I/usr/lib/amd64/dbus-1.0/include"
    export DBUS_CFLAGS
    DBUS_GLIB_CFLAGS="-I/usr/include/glib-2.0 -I/usr/lib/amd64/glib-2.0/include"
    export DBUS_GLIB_CFLAGS
    DBUS_GLIB_LIBS="-lglib-2.0 -lgobject-2.0 -lgio-2.0"
    export DBUS_GLIB_LIBS
    configure64_orig
    logcmd mv config.status config.status.old || logerr "status backup failed"
    sed -e 's/S\["GLIB_GENMARSHAL"\]=""/S["GLIB_GENMARSHAL"]="glib-genmarshal"/' < config.status.old > config.status || logerr "sed failed"
    logcmd chmod 755 config.status || logerr "chmod failed"
    logcmd ./config.status || logerr "config status"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
