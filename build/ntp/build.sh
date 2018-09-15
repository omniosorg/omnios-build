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

PROG=ntp
VER=4.2.8p12
VERHUMAN=$VER
PKG=service/network/ntp
SUMMARY="Network Time Services"
DESC="$SUMMARY"

set_arch 64

CONFIGURE_OPTS_64+="
    --bindir=/usr/sbin
    --with-binsubdir=sbin
    --libexecdir=/usr/lib/inet
    --sysconfdir=/etc/inet
    --with-openssl-libdir=/lib
"

CONFIGURE_OPTS="
    --enable-all-clocks
    --enable-debugging
    --enable-debug-timing
    --disable-optional-args
    --enable-parse-clocks
    --enable-ignore-dns-errors
    --without-ntpsnmpd
    --without-sntp
    --without-lineeditlibs
"

overlay_root() {
    (cd $SRCDIR/root && tar cf - .) | (cd $DESTDIR && tar xf -)
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
overlay_root
install_smf network ntp.xml ntp
#NOTE: Uncomment these IFF we go back to ntp-dev versions or p-releases again.
#VER=${VER//dev-/}
VER=${VER//p/.}
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
