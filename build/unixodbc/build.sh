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

PROG=unixODBC
VER=2.3.7
VERHUMAN=$VER
PKG=library/unixodbc
SUMMARY="The UnixODBC Subsystem and SDK"
DESC="UnixODBC - The UnixODBC Subsystem and SDK"

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
