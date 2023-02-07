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
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh
. common.sh

PROG=openssl
VER=1.0.2u
DASHREV=1
PKG=library/security/openssl-10
SUMMARY="Cryptography and SSL/TLS Toolkit"
DESC="A toolkit for Secure Sockets Layer and Transport Layer protocols "
DESC+="and general purpose cryptographic library"

SKIP_LICENCES=OpenSSL
BMI_EXPECTED=1

MAJVER=${VER%.*}
XFORM_ARGS+="
    -DMAJVER=$MAJVER
    -DLIBVER=${VER%.*}.0
    -DLICENCEFILE=LICENSE -DLICENCE=OpenSSL
"

set_patchdir patches-${VER%.*}
TESTSUITE_FILTER='[0-9] tests|TESTS'

# Generic options for both 32- and 64-bit variants
base_LDFLAGS="-shared -Wl,-z,text,-z,aslr,-z,ignore"
OPENSSL_CONFIG_OPTS="shared threads zlib enable-ssl2 enable-ssl3"
OPENSSL_CONFIG_OPTS+=" --prefix=$PREFIX"

# Configure options specific to a 32-bit or 64-bit builds
OPENSSL_CONFIG_32_OPTS="--libdir=lib"
OPENSSL_CONFIG_32_OPTS+=" --pk11-libname=$PREFIX/lib/libpkcs11.so.1"
OPENSSL_CONFIG_64_OPTS="--libdir=lib/$ISAPART64"
OPENSSL_CONFIG_64_OPTS+=" enable-ec_nistp_64_gcc_128"
OPENSSL_CONFIG_64_OPTS+=" --pk11-libname=$PREFIX/lib/$ISAPART64/libpkcs11.so.1"

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
    local duh=$DESTDIR$PREFIX/include/openssl/opensslconf.h

    [[ $BUILDARCH =~ ^(32|both)$ ]] && build32 && logcmd cp ${duh}{,.32}
    [[ $BUILDARCH =~ ^(64|both)$ ]] && build64 && logcmd cp ${duh}{,.64}

    logcmd -p diff -D __x86_64 ${duh}.{32,64} > $duh

    patch_pc $MAJVER $DESTDIR$PREFIX/lib || logerr "patch_pc failed"
}

install_pkcs11()
{
    logmsg "--- installing pkcs11 engine"
    pushd $SRCDIR/engine_pkcs11 > /dev/null
    find . | cpio -pmud $TMPDIR/$BUILDDIR/engines/
    popd > /dev/null
}

# OpenSSL 1.0 uses INSTALL_PREFIX= instead of DESTDIR=
make_install() {
    logmsg "--- make install"
    logcmd make INSTALL_PREFIX=$DESTDIR install \
        || logerr "Failed to make install"
}

init
download_source $PROG $PROG $VER
patch_source
install_pkcs11
prep_build
build
run_testsuite test "" testsuite-${VER%.*}.log
make_package -legacy
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
