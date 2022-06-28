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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh
. common.sh

PROG=openssl
VER=3.0.4
DASHREV=1
PKG=library/security/openssl-3
SUMMARY="Cryptography and SSL/TLS Toolkit"
DESC="A toolkit for Secure Sockets Layer and Transport Layer protocols "
DESC+="and general purpose cryptographic library"

# Required for the testsuite - not yet in ooce/omnios-build-tools
BUILD_DEPENDS_IPS+=" ooce/file/lsof"

MAJVER=${VER%%.*}
XFORM_ARGS+="
    -DMAJVER=$MAJVER
    -DLIBVER=${VER%%.*}
    -DLICENCEFILE=LICENSE.txt -DLICENCE=Apache2
"

set_builddir $PROG-$VER
set_patchdir patches-${VER%%.*}

# Generic options for both 32 and 64bit variants
base_LDFLAGS="-shared -Wl,-z,text,-z,aslr,-z,ignore"
OPENSSL_CONFIG_OPTS="shared threads zlib"
OPENSSL_CONFIG_OPTS+=" --prefix=$PREFIX"
# Build with support for the previous 1.1.1 API
OPENSSL_CONFIG_OPTS+=" --api=1.1.1"

# Configure options specific to a 32-bit or 64-bit builds
OPENSSL_CONFIG_32_OPTS="--libdir=$PREFIX/lib"
OPENSSL_CONFIG_64_OPTS="--libdir=$PREFIX/lib/$ISAPART64"
OPENSSL_CONFIG_64_OPTS+=" enable-ec_nistp_64_gcc_128"

# The 'install' target installs html documentation too
MAKE_INSTALL_TARGET="install_sw install_ssldirs install_man_docs"

TESTSUITE_SED="
    s/pid=[0-9]*/pid=/g
    s/[0-9]* wallclock secs.*//
"

save_function make_prog _make_prog
make_prog() {
    MAKE_ARGS_WS="
        SHARED_LDFLAGS=\"$SHARED_LDFLAGS\"
        LIB_LDFLAGS=\"$SHARED_LDFLAGS\"
    "
    _make_prog
}

configure32() {
    SSLPLAT=solaris-x86-gcc
    logmsg -n "--- Configure (32-bit) $SSLPLAT"
    export __CNF_CFLAGS="$CFLAGS $CFLAGS32"
    logcmd ./Configure $SSLPLAT \
        ${OPENSSL_CONFIG_OPTS} ${OPENSSL_CONFIG_32_OPTS} \
        || logerr "Failed to run configure"
    SHARED_LDFLAGS="$LDFLAGS32 $base_LDFLAGS"
}

configure64() {
    SSLPLAT=solaris64-x86_64-gcc
    logmsg -n "--- Configure (64-bit) $SSLPLAT"
    export __CNF_CFLAGS="$CFLAGS $CFLAGS64"
    logcmd ./Configure $SSLPLAT \
        ${OPENSSL_CONFIG_OPTS} ${OPENSSL_CONFIG_64_OPTS} \
        || logerr "Failed to run configure"
    SHARED_LDFLAGS="$LDFLAGS64 $base_LDFLAGS"
}

# Preserve the opensslconf.h file from each build since there will be
# differences due to the architecture.
build() {
    local duh=$DESTDIR$PREFIX/include/openssl/configuration.h

    [[ $BUILDARCH =~ ^(32|both)$ ]] && build32 && logcmd cp ${duh}{,.32}
    [[ $BUILDARCH =~ ^(64|both)$ ]] && build64 && logcmd cp ${duh}{,.64}

    logcmd -p diff -D __x86_64 ${duh}.{32,64} > $duh

    patch_pc $MAJVER $DESTDIR$PREFIX/lib || logerr "patch_pc failed"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
PATH=$OOCEBIN:$PATH run_testsuite test "" testsuite-${VER%%.*}.log
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
