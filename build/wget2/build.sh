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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=wget2
VER=2.0.1
PKG=web/wget2
SUMMARY="GNU Wget2"
DESC="Retrieving files using HTTP, HTTPS, FTP and FTPS "
DESC+="the most widely-used Internet protocols"

# The libmicrohttpd library is needed for the testsuite
LMHTTPD_VER=0.9.73

RUN_DEPENDS_IPS="web/ca-bundle"

# - could bundle libpsl
# - could bundle libhsts (and add hsts.dafsa to web/ca-bundle?)

init
prep_build autoconf

###########################################################################
# The testsuite uses libmicrohttpd

if [ -z "$SKIP_TESTSUITE" ]; then
    save_variable BUILDARCH
    BUILDARCH=64
    CONFIGURE_OPTS="
        --with-ssl=openssl
    "
    build_dependency libmicrohttpd libmicrohttpd-$LMHTTPD_VER \
        libmicrohttpd libmicrohttpd $LMHTTPD_VER
    restore_variable BUILDARCH

    CPPFLAGS="-I$DEPROOT$PREFIX/include"
    LDFLAGS[amd64]+=" -L$DEPROOT$PREFIX/lib/amd64"
    addpath PKG_CONFIG_PATH64 $DEPROOT$PREFIX/lib/amd64/pkgconfig
fi

###########################################################################

note -n "-- Building $PROG"

forgo_isaexec

CONFIGURE_OPTS="
    --with-ssl=openssl
    --disable-manylibs
    --disable-static
    --with-brotlidec
    --with-bzip2
    --with-libidn
    --with-libmicrohttpd
    --with-libnghttp2
    --with-libpcre2
    --with-lzip
    --with-lzma
    --with-zlib
    --with-zstd
"

CONFIGURE_OPTS[i386]+=" --without-libmicrohttpd"

TESTSUITE_FILTER='^[A-Z#][A-Z ]'

install_man() {
    logcmd mkdir -p $DESTDIR/$PREFIX/share/man
    logcmd rsync -ac --delete \
         $TMPDIR/$EXTRACTED_SRC/docs/man/ $DESTDIR/$PREFIX/share/man/ \
        || logerr "installation of man pages failed"
}

download_source $PROG $PROG $VER
patch_source
build
if [ -z "$SKIP_TESTSUITE" ]; then
    run_testsuite check
    grep -h 'ERROR:.*out of' $TMPDIR/$BUILDDIR/*/test-suite.log 2>/dev/null \
        >> $SRCDIR/testsuite.log
fi
install_man
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
