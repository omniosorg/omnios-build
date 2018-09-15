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
# Use is subject to license terms.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=idnkit
VER=2.3
VERHUMAN=$VER
PKG=library/idnkit
SUMMARY="Internationalized Domain Name kit (idnkit/JPNIC)"
DESC="Internationalized Domain Name kit (idnkit/JPNIC)"

CONFIGURE_OPTS="--disable-static --mandir=/usr/share/man"
LIBTOOL_NOSTDLIB=libtool
LIBTOOL_NOSTDLIB_EXTRAS=-lc

install_legacy()
{
    # Include libraries from idnkit1
    ver=1.0.2
    for lib in idnkit idnkitlite; do
        logcmd cp /usr/lib/lib$lib.so.$ver $DESTDIR/usr/lib/
        logcmd cp /usr/lib/amd64/lib$lib.so.$ver $DESTDIR/usr/lib/amd64/
        logcmd ln -s lib$lib.so.$ver $DESTDIR/usr/lib/lib$lib.so.1
        logcmd ln -s lib$lib.so.$ver $DESTDIR/usr/lib/amd64/lib$lib.so.1
    done
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
install_legacy
make_package lib.mog

PKG=library/idnkit/header-idnkit
DEPENDS_IPS=""
SUMMARY="Internationalized Domain Name Support Developer Files"
DESC="Internationalized Domain Name Support Developer Files"
make_package headers.mog

PKG=network/dns/idnconv
DEPENDS_IPS="library/idnkit"
SUMMARY="Internationalized Domain Name Support Utilities"
DESC="Internationalized Domain Name Support Utilities"
make_package bin.mog

clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
