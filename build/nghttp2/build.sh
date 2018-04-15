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
# Copyright 2011-2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=nghttp2
VER=1.31.1
VERHUMAN=$VER
PKG=library/nghttp2
SUMMARY="Nghttp2: HTTP/2 C Library"
DESC="$SUMMARY"

CFLAGS="-O2"
LDFLAGS="-lm"
CONFIGURE_OPTS="
    --enable-lib-only
    --disable-silent-rules
"

export ZLIB_CFLAGS="-I/usr/include"
export ZLIB_LIBS="-L/usr/lib"
export OPENSSL_CFLAGS="-I/usr/include"
export OPENSSL_LIBS="-L/usr/lib"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
