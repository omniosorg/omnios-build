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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=openssl
VER=1.1.1o
LVER=1.0.2u
VERHUMAN=$VER
PKG=library/security/openssl
SUMMARY="Cryptography and SSL/TLS Toolkit"
DESC="A toolkit for Secure Sockets Layer and Transport Layer protocols "
DESC+="and general purpose cryptographic library"

SKIP_LICENCES=OpenSSL

# Generic options for both 32 and 64bit variants
base_OPENSSL_CONFIG_OPTS="shared threads zlib enable-ssl2 enable-ssl3"
base_LDFLAGS="-shared -Wl,-z,text,-z,aslr,-z,ignore"

# Configure options specific to a 32bit or 64bit builds
base_OPENSSL_CONFIG_32_OPTS=
base_OPENSSL_CONFIG_64_OPTS="enable-ec_nistp_64_gcc_128"

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
    logcmd ./Configure $SSLPLAT --prefix=$PREFIX \
        ${OPENSSL_CONFIG_OPTS} ${OPENSSL_CONFIG_32_OPTS} \
        || logerr "Failed to run configure"
    SHARED_LDFLAGS="$base_LDFLAGS"
}

configure64() {
    SSLPLAT=solaris64-x86_64-gcc
    logmsg -n "--- Configure (64-bit) $SSLPLAT"
    export __CNF_CFLAGS="$CFLAGS $CFLAGS64"
    logcmd ./Configure $SSLPLAT --prefix=$PREFIX \
        ${OPENSSL_CONFIG_OPTS} ${OPENSSL_CONFIG_64_OPTS} \
        || logerr "Failed to run configure"
    SHARED_LDFLAGS="-m64 $base_LDFLAGS"
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

save_function make_package _make_package
make_package() {
    if echo $VER | egrep -s '[a-z]'; then
        NUMVER=${VER::$((${#VER} -1))}
        ALPHAVER=${VER:$((${#VER} -1))}
        VER=${NUMVER}.$(ord26 ${ALPHAVER})
    fi

    _make_package
}

# Move installed libs from /usr/lib to /lib
move_libs() {
    logmsg "Relocating libs from usr/lib to lib"
    logcmd mv $DESTDIR/usr/lib/{64,amd64} || logerr "mv"
    logcmd mkdir -p $DESTDIR/lib/amd64 || logerr "mkdir"
    logcmd mv $DESTDIR/usr/lib/lib* $DESTDIR/lib/ \
        || logerr "Failed to move libs (32-bit)"
    logcmd mv $DESTDIR/usr/lib/amd64/lib* $DESTDIR/lib/amd64/ \
        || logerr "Failed to move libs (64-bit)"
}

version_files() {
    ver=$2
    [ -d "$1~" ] || cp -rp "$1" "$1~"

    pushd $1 >/dev/null || logerr "pushd version files"

    logcmd mv usr/include/openssl{,-$ver}
    for f in usr/bin/*; do
        logcmd mv $f{,-$ver} || logerr "mv bin"
    done
    [ -d usr/share/man ] && logcmd mv usr/share/man usr/ssl/man

    logcmd mkdir -p usr/ssl/lib usr/ssl/lib/amd64
    logcmd mv usr/lib/pkgconfig usr/ssl/lib/pkgconfig
    logcmd mv usr/lib/amd64/pkgconfig usr/ssl/lib/amd64/pkgconfig
    logcmd mv lib/lib*.a usr/ssl/lib
    logcmd mv lib/amd64/lib*.a usr/ssl/lib/amd64

    logcmd rm -f lib/lib{crypto,ssl}.so
    logcmd rm -f lib/amd64/lib{crypto,ssl}.so

    [ -d usr/ssl/certs ] && logcmd rm -rf usr/ssl/certs
    logcmd ln -s ../../etc/ssl/certs usr/ssl/certs

    logcmd mv usr/ssl usr/ssl-$ver

    popd >/dev/null
}

merge_package() {
    version_files $DESTDIR `echo $VER | cut -d. -f1-2`
    version_files $LDESTDIR `echo $LVER | cut -d. -f1-2`

    ( cd $LDESTDIR; find . | cpio -pmud $DESTDIR )

    # This is to satisfy the dangling symlink checker. It's excluded by the
    # local.mog
    logcmd mkdir -p $DESTDIR/etc/ssl/certs
}

######################################################################

init

######################################################################
### OpenSSL 1.1.x build

if [ -z "$FLAVOR" -o "$FLAVOR" = "1.1" ]; then
    note -n "Building OpenSSL $VER"

    OPENSSL_CONFIG_OPTS="$base_OPENSSL_CONFIG_OPTS --api=1.0.0"
    OPENSSL_CONFIG_32_OPTS="$base_OPENSSL_CONFIG_32_OPTS"
    #OPENSSL_CONFIG_64_OPTS="$base_OPENSSL_CONFIG_64_OPTS no-asm"
    OPENSSL_CONFIG_64_OPTS="$base_OPENSSL_CONFIG_64_OPTS"
    download_source $PROG $PROG $VER
    patch_source
    prep_build
    build
    (cd $DESTDIR; gpatch -p1 < $SRCDIR/$PATCHDIR/post/opensslconf.dualarch)
    run_testsuite
    move_libs
fi

######################################################################
### OpenSSL 1.0.x build

if [ -z "$FLAVOR" -o "$FLAVOR" = "1.0" ]; then
    note -n "Building OpenSSL $LVER"

    oDESTDIR=$DESTDIR
    oPKG=$PKG
    oPKGE=$PKGE

    PKG+=_legacy        ##IGNORE## Use different directory for build
    OPENSSL_CONFIG_OPTS="$base_OPENSSL_CONFIG_OPTS"
    OPENSSL_CONFIG_32_OPTS="$base_OPENSSL_CONFIG_32_OPTS"
    OPENSSL_CONFIG_32_OPTS+=" --pk11-libname=/usr/lib/libpkcs11.so.1"
    OPENSSL_CONFIG_64_OPTS="$base_OPENSSL_CONFIG_64_OPTS"
    OPENSSL_CONFIG_64_OPTS+=" --pk11-libname=/usr/lib/64/libpkcs11.so.1"
    set_builddir "$PROG-$LVER"

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

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
