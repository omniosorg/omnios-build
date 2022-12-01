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
. ../../lib/build.sh
. common.sh

PROG=openssl
VER=3.0.7
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

# Generic options for all architectures
LDFLAGS[base]="-shared -Wl,-z,text,-z,aslr,-z,ignore"
declare -A OPENSSL_CONFIG_OPTS
OPENSSL_CONFIG_OPTS="shared threads zlib"
OPENSSL_CONFIG_OPTS+=" --prefix=$PREFIX"
# Build with support for the previous 1.1.1 API
OPENSSL_CONFIG_OPTS+=" --api=1.1.1"

# Configure options specific to a particular arch.
OPENSSL_CONFIG_OPTS[i386]="--libdir=$PREFIX/lib"
OPENSSL_CONFIG_OPTS[amd64]="--libdir=$PREFIX/lib/amd64"
OPENSSL_CONFIG_OPTS[amd64]+=" enable-ec_nistp_64_gcc_128"

# The 'install' target installs html documentation too
MAKE_INSTALL_TARGET="install_sw install_ssldirs install_man_docs"

TESTSUITE_SED="
    s/pid=[0-9]*/pid=/g
    s/[0-9]* wallclock secs.*//
"

pre_build() {
    [ -z "$1" ] || return
    declare -g DUH=$DESTDIR$PREFIX/include/openssl/configuration.h
    declare -Ag OPENSSL_CFLAGS
    OPENSSL_CFLAGS[i386]="$CFLAGS ${CFLAGS[i386]}"
    OPENSSL_CFLAGS[amd64]="$CFLAGS ${CFLAGS[amd64]}"
    unset CFLAGS
}

configure_arch() {
    typeset arch=${1:?arch}

    [ $arch = amd64 ] && SSLPLAT=solaris64-x86_64-gcc || SSLPLAT=solaris-x86-gcc
    logmsg -n "--- Configure $arch ($SSLPLAT)"
    export __CNF_CFLAGS="${OPENSSL_CFLAGS[$arch]}"
    logcmd ./Configure $SSLPLAT \
        ${OPENSSL_CONFIG_OPTS} ${OPENSSL_CONFIG_OPTS[$arch]} \
        || logerr "Failed to run configure"
    MAKE_ARGS_WS="
        SHARED_LDFLAGS=\"${LDFLAGS[$arch]} ${LDFLAGS[base]}\"
        LIB_LDFLAGS=\"${LDFLAGS[$arch]} ${LDFLAGS[base]}\"
    "
}

# Preserve the opensslconf.h file from each build since there will be
# differences due to the architecture.
post_install() {
    logcmd cp ${DUH}{,.$1}
}

post_build() {
    [ -z "$1" ] || return
    logcmd -p diff -D __x86_64 ${DUH}.{i386,amd64} > $DUH
    patch_pc $MAJVER $DESTDIR$PREFIX/lib || logerr "patch_pc failed"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
post_build
PATH=$OOCEBIN:$PATH run_testsuite test "" testsuite-${VER%%.*}.log
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
