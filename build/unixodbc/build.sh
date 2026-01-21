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
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=unixODBC
VER=2.3.14
PKG=library/unixodbc
SUMMARY="The UnixODBC Subsystem and SDK"
DESC="UnixODBC - The UnixODBC Subsystem and SDK"

# Requires the new definition of getpwuid_r()
set_standard XPG6

CONFIGURE_OPTS="
    --includedir=$PREFIX/include/odbc
    --localstatedir=/var
    --sysconfdir=/etc/odbc
    --enable-shared
    --disable-static
    --disable-libtool-lock
    --disable-gui
    --enable-threads
    --disable-gnuthreads
    --enable-readline
    --enable-inicaching
    --enable-drivers=yes
    --enable-driver-conf=yes
    --enable-fdb
    --enable-odbctrace
    --enable-iconv
    --enable-stats
    --enable-rtldgroup
    --disable-ltdllib
    --without-pth
    --without-pth-test
    --with-libiconv-prefix=$PREFIX
    --disable-ltdl-install
    --with-pic
"

export MAKE

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
