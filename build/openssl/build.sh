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

PROG=openssl
VER=1.1.0i
LVER=1.0.2p
VERHUMAN=$VER
PKG=library/security/openssl
SUMMARY="Cryptography and SSL/TLS Toolkit"
DESC="A toolkit for Secure Sockets Layer and Transport Layer protocols and general purpose cryptographic library"

RUN_DEPENDS_IPS="system/library library/zlib"
BUILD_DEPENDS_IPS+=" developer/sunstudio12.1"

# Generic configure options for both 32 and 64bit variants
base_OPENSSL_CONFIG_OPTS="shared threads zlib enable-ssl2 enable-ssl3"

# Configure options specific to a 32bit build
OPENSSL_CONFIG_32_OPTS=""

# Configure options specific to a 64bit build
OPENSSL_CONFIG_64_OPTS="enable-ec_nistp_64_gcc_128"

NO_PARALLEL_MAKE=1

make_prog() {
    [ -n "$NO_PARALLEL_MAKE" ] && MAKE_JOBS=
    logmsg "--- make"
    # This will setup the internal runpath of libssl and libcrypto
    logcmd $MAKE $MAKE_JOBS \
        SHARED_LDFLAGS="$SHARED_LDFLAGS" \
        LIB_LDFLAGS="$SHARED_LDFLAGS" \
        || logerr "--- Make failed"
}

configure32() {
    SSLPLAT=solaris-x86-gcc
    logmsg "--- Configure (32-bit) $SSLPLAT"
    logcmd ./Configure $SSLPLAT --prefix=$PREFIX \
        ${OPENSSL_CONFIG_OPTS} \
        ${OPENSSL_CONFIG_32_OPTS} \
        || logerr "Failed to run configure"
    SHARED_LDFLAGS="-shared -Wl,-z,text,-z,aslr,-z,ignore"
}

configure64() {
    SSLPLAT=solaris64-x86_64-gcc
    logmsg "--- Configure (64-bit) $SSLPLAT"
    logcmd ./Configure $SSLPLAT --prefix=$PREFIX \
        ${OPENSSL_CONFIG_OPTS} \
        ${OPENSSL_CONFIG_64_OPTS} \
        || logerr "Failed to run configure"
    SHARED_LDFLAGS="-m64 -shared -Wl,-z,text,-z,aslr,-z,ignore"
}

# Preserve the opensslconf.h file from each build since there will be
# differences due to the architecture.
# These are used to prepare the patch that is applied before packaging.
build() {
    [[ $BUILDARCH =~ ^(32|both)$ ]] && build32 && \
        logcmd cp $DESTDIR/usr/include/openssl/opensslconf.h{,.32}
    [[ $BUILDARCH =~ ^(64|both)$ ]] && build64 && \
        logcmd cp $DESTDIR/usr/include/openssl/opensslconf.h{,.64}
}

install_pkcs11()
{
    logmsg "--- installing pkcs11 engine"
    pushd $SRCDIR/engine_pkcs11 > /dev/null
    find . | cpio -pvmud $TMPDIR/$BUILDDIR/engines/
    popd > /dev/null
}

save_function make_package make_package_orig
make_package() {
    if echo $VER | egrep -s '[a-z]'; then
        NUMVER=${VER::$((${#VER} -1))}
        ALPHAVER=${VER:$((${#VER} -1))}
        VER=${NUMVER}.$(ord26 ${ALPHAVER})
    fi

    make_package_orig
}

# Move installed libs from /usr/lib to /lib
move_libs() {
    logmsg "Relocating libs from usr/lib to lib"
    logcmd mv $DESTDIR/usr/lib/64 $DESTDIR/usr/lib/amd64
    logcmd mkdir -p $DESTDIR/lib/amd64
    logcmd mv $DESTDIR/usr/lib/lib* $DESTDIR/lib/ \
        || logerr "Failed to move libs (32-bit)"
    logcmd mv $DESTDIR/usr/lib/amd64/lib* $DESTDIR/lib/amd64/ \
        || logerr "Failed to move libs (64-bit)"
}

version_files() {
    ver=$2
    [ -d "$1~" ] || cp -rp "$1" "$1~"
    pushd $1
    mv usr/include/openssl usr/include/openssl-$ver
    for f in usr/bin/*; do
        mv $f $f-$ver
    done
    [ -d usr/share/man ] && mv usr/share/man usr/ssl/man

    mkdir usr/ssl/lib usr/ssl/lib/amd64
    mv usr/lib/pkgconfig usr/ssl/lib/pkgconfig
    mv usr/lib/amd64/pkgconfig usr/ssl/lib/amd64/pkgconfig
    mv lib/llib* lib/lib*.a usr/ssl/lib
    mv lib/amd64/llib* lib/amd64/lib*.a usr/ssl/lib/amd64

    rm -f lib/lib{crypto,ssl}.so
    rm -f lib/amd64/lib{crypto,ssl}.so

    [ -d usr/ssl/certs ] && rm -rf usr/ssl/certs
    (cd usr/ssl; ln -s ../../etc/ssl/certs)

    mv usr/ssl usr/ssl-$ver
    popd
}

merge_package() {
    version_files $DESTDIR `echo $VER | cut -d. -f1-2`
    version_files $LDESTDIR `echo $LVER | cut -d. -f1-2`

    ( cd $LDESTDIR; find . | cpio -pmud $DESTDIR )

    # This is to satisfy the dangling symlink checker. It's excluded by the
    # local.mog
    mkdir -p $DESTDIR/etc/ssl/certs
}

######################################################################

init

######################################################################
### OpenSSL 1.1.x build

if [ -z "$FLAVOR" -o "$FLAVOR" = "1.1" ]; then
    note "Building OpenSSL $VER"

    OPENSSL_CONFIG_OPTS="$base_OPENSSL_CONFIG_OPTS --api=1.0.0"
    download_source $PROG $PROG $VER
    patch_source
    prep_build
    build
    (cd $DESTDIR; gpatch -p1 < $SRCDIR/$PATCHDIR/post/opensslconf.dualarch)
    run_testsuite
    move_libs
    make_lintlibs crypto /lib /usr/include "openssl/!(asn1_mac|ssl*|*tls*).h"
    make_lintlibs ssl /lib /usr/include "openssl/{ssl,*tls}*.h"
fi

######################################################################
### OpenSSL 1.0.x build

if [ -z "$FLAVOR" -o "$FLAVOR" = "1.0" ]; then
    note "Building OpenSSL $LVER"

    oDESTDIR=$DESTDIR
    oPKG=$PKG
    oPKGE=$PKGE

    PKG+=_legacy        ##IGNORE## Use different directory for build
    OPENSSL_CONFIG_OPTS="$base_OPENSSL_CONFIG_OPTS"
    OPENSSL_CONFIG_32_OPTS+=" --pk11-libname=/usr/lib/libpkcs11.so.1"
    OPENSSL_CONFIG_64_OPTS+=" --pk11-libname=/usr/lib/64/libpkcs11.so.1"
    BUILDDIR=$PROG-$LVER

    # OpenSSL 1.0 uses INSTALL_PREFIX= instead of DESTDIR=
    make_install() {
        logmsg "--- make install"
        logcmd make INSTALL_PREFIX=$DESTDIR install \
            || logerr "Failed to make install"
    }

    TESTSUITE_FILTER='[0-9] tests|TESTS'

    PATCHDIR=patches-1.0
    download_source $PROG $PROG $LVER
    patch_source
    install_pkcs11
    prep_build
    build
    (cd $DESTDIR; gpatch -p1 < $SRCDIR/$PATCHDIR/post/opensslconf.dualarch)
    run_testsuite test "" testsuite.1.0.log
    move_libs
    make_lintlibs crypto /lib /usr/include "openssl/!(ssl*|*tls*).h"
    make_lintlibs ssl /lib /usr/include "openssl/{ssl,*tls}*.h"

    PKG=$oPKG ##IGNORE##
    PKGE=$oPKGE
    LDESTDIR="$DESTDIR"
    DESTDIR="$oDESTDIR"
fi

######################################################################
### Packaging

if [ -z "$FLAVOR" ]; then
    merge_package
    make_package
fi

clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
