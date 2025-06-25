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

# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=oqs-provider
VER=0.9.0
PKG=library/security/oqs-provider
SUMMARY="$PROG"
DESC="Open Quantum Safe provider for OpenSSL (3.x)"

TESTSUITE_SED='
    s/  *[0-9][0-9]*\.[0-9][0-9]*  *sec//
    /^Test project/d
'

# add an incorporation to tie the oqs-provider to the tested liboqs release
LIBOQSVER=`pkg_ver liboqs`
RUN_DEPENDS_IPS="=library/security/liboqs@$LIBOQSVER"

CONFIGURE_OPTS="
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DOPENSSL_ROOT_DIR=$PREFIX
"
CONFIGURE_OPTS[i386]=
# if we don't set the crypto library path explicitly the build framework
# will pick /usr/lib/64 and install the provider library there instead of amd64
CONFIGURE_OPTS[amd64]="
    -DCMAKE_LIBRARY_ARCHITECTURE=amd64
    -DOPENSSL_CRYPTO_LIBRARY=$PREFIX/${LIBDIRS[amd64]}/libcrypto.so
"

init
download_source $PROG $VER
patch_source
prep_build cmake+ninja
build
TESTSUITE_MAKE=ctest run_testsuite ""
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
