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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=bind
VER=9.11.4-P1
VERHUMAN=$VER
PKG=network/dns/bind
SUMMARY="BIND DNS tools"
DESC="$SUMMARY"

set_arch 32

CONFIGURE_OPTS="
    --libdir=$PREFIX/lib/dns
    --bindir=$PREFIX/sbin
    --localstatedir=/var
    --with-libtool
    --with-openssl
    --enable-threads=yes
    --enable-devpoll=yes
    --disable-openssl-version-check
    --enable-fixed-rrset
    --disable-getifaddrs
    --with-pkcs11
    --enable-shared
    --disable-static
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
python_vendor_relocate
VER=${VER//-P/.}
VER=${VER//-W/.}
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
