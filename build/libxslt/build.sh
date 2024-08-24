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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=libxslt
VER=1.1.42
PKG=library/libxslt
SUMMARY="The XSLT C library"
DESC="The portable XSLT C library built on libxml2"

CFLAGS[i386]+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
CFLAGS[amd64]+=" -D_LARGEFILE_SOURCE"
CFLAGS[aarch64]+=" -D_LARGEFILE_SOURCE"

CONFIGURE_OPTS="
    --disable-static
    --with-pic
    --without-crypto
    --without-python
"

post_install() {
    [ $1 = i386 ] && return

    make_isa_stub

    # xslt-config is a shell script, so we can run the test
    # even when cross-building
    logmsg "-- running tests"
    [ `$DESTDIR/usr/bin/xslt-config --cflags` = "-I/usr/include/libxml2" ] \
        || logerr "xslt-config --cflags not working"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf -autoreconf
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
