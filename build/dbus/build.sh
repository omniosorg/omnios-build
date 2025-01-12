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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=dbus
VER=1.16.0
PKG=dbus ##IGNORE##
SUMMARY="filled in below"
DESC="$SUMMARY"

set_standard XPG6
CPPFLAGS+=" -D_REENTRANT"

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --localstatedir=/var
    --libexecdir=/usr/libexec
    -Druntime_dir=/var/run
    -Ddbus_daemondir=/usr/lib
    -Ddbus_user=root
    -Depoll=disabled
    -Dinotify=disabled
    -Dc_link_args=-lsocket
"

CONFIGURE_OPTS[i386]="
    --bindir=$PREFIX/bin
    --libdir=$PREFIX/${LIBDIRS[i386]}
"
CONFIGURE_OPTS[amd64]="
    --bindir=$PREFIX/bin
    --libdir=$PREFIX/${LIBDIRS[amd64]}
"
CONFIGURE_OPTS[aarch64]="
    --bindir=$PREFIX/bin
    --libdir=$PREFIX/${LIBDIRS[aarch64]}
"

TESTSUITE_SED="
    /^ninja:/d
    /Full log written to/d
    s/  *$//
    s/\<[0-9][0-9]*\.[0-9][0-9]*s\>//
"

pre_configure() {
    typeset arch=$1

    ! cross_arch $arch && return

    CONFIGURE_CMD+=" --cross-file $BLIBDIR/meson-$arch-gcc"

    # use GNU msgfmt; otherwise the build fails
    PATH="$GNUBIN:$PATH:$OOCEBIN"
}

post_install() {
    [ $1 = i386 ] && return

    install_smf system dbus.xml svc-dbus

    manifest_start $TMPDIR/manifest.dbus
    manifest_add_dir $PREFIX/bin
    manifest_add_dir etc/dbus-1
    manifest_add_dir lib/svc manifest/system method
    manifest_add $PREFIX/lib dbus-daemon
    manifest_add_dir $PREFIX/libexec
    manifest_add_dir $PREFIX/share xml/dbus-1
    manifest_add_dir $PREFIX/share/dbus-1 \
        services session.d system-services system.d
    manifest_add_dir var/lib dbus
    manifest_finalise $TMPDIR/manifest.dbus $PREFIX

    manifest_uniq $TMPDIR/manifest.{libdbus,dbus}
    manifest_finalise $TMPDIR/manifest.libdbus $PREFIX
}

init
download_source $PROG $PROG $VER
patch_source
prep_build meson
build
TESTSUITE_MAKE="$PYTHONLIB/python$PYTHONVER/bin/meson" run_testsuite test
make_isa_stub

PKG=system/library/dbus
SUMMARY="Simple IPC library based on messages"
DESC="A simple system for interprocess communication and coordination"
[ "$FLAVOR" != libsandheaders ] \
    && make_package -seed $TMPDIR/manifest.dbus dbus.mog

PKG=system/library/libdbus
SUMMARY+=" - client libraries"
DESC+=" - client libraries"
make_package -seed $TMPDIR/manifest.libdbus

clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
