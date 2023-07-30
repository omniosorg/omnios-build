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
# Copyright 2011-2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=nghttp2
VER=1.55.1
PKG=library/nghttp2
SUMMARY="nghttp2: HTTP/2 C Library"
DESC="An implementation of the Hypertext Transfer Protocol version 2 in C"

BUILD_DEPENDS_IPS="ooce/developer/cunit"

CONFIGURE_OPTS="
    --enable-lib-only
    --disable-silent-rules
    --without-systemd
    --with-openssl
    --disable-static
"

pre_build() {
    typeset arch=${1:?arch}

    export CUNIT_CFLAGS="${CFLAGS[$arch]} -I$OOCEOPT/include"
    export CUNIT_LIBS="-L$OOCEOPT/lib/amd64 -R$OOCEOPT/lib/amd64 -lcunit"

    case $arch in
        i386) ;&
        amd64)
            export ZLIB_CFLAGS="${CFLAGS[$arch]} -I/usr/include"
            export ZLIB_LIBS="-L/usr/lib"
            export OPENSSL_CFLAGS="${CFLAGS[$arch]} -I/usr/include"
            export OPENSSL_LIBS="-L/usr/lib"
            ;;
        aarch64)
            export ZLIB_CFLAGS="${CFLAGS[$arch]} -I${SYSROOT[$arch]}/usr/include"
            export ZLIB_LIBS="-L${SYSROOT[$arch]}/usr/lib"
            export OPENSSL_CFLAGS="${CFLAGS[$arch]} -I${SYSROOT[$arch]}/usr/include"
            export OPENSSL_LIBS="-L${SYSROOT[$arch]}/usr/lib"
            ;;
    esac
}

TESTSUITE_SED="
    /^libtool:/d
"

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
