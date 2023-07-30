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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=sudo
VER=1.9.14p3
PKG=security/sudo
SUMMARY="Authority delegation tool"
DESC="Provide limited super-user privileges to specific users"

set_arch 64

CONFIGURE_OPTS="
    --with-ldap
    --with-project
    --with-rundir=/var/run/sudo
    --with-pam --with-pam-login
    --with-tty-tickets
    --without-insults
    --without-lecture
    --with-ignore-dot
    --with-bsm-audit
    --disable-pam-session
    --enable-openssl
    --enable-python
    --enable-log-client
    --disable-log-server
"
CONFIGURE_OPTS[amd64]+="
    --libexecdir=/usr/lib/$PROG/amd64
"

SKIP_LICENCES=Various
TESTSUITE_SED="
    /^libtool:/d
    /^check_ttyname:/s/ *(.*//
    /^check_net_ifs:/s/ *(.*//
    /attempted multiple inclusion/d
"

build_init() {
    for arch in $CROSS_ARCH; do
        CPPFLAGS[$arch]+=" -I${SYSROOT[$arch]}/usr/include"
        LDFLAGS[$arch]+=" -L${SYSROOT[$arch]}/usr/lib"
        LDFLAGS[$arch]+=" -L${SYSROOT[$arch]}/usr/lib/mps"
    done
}

pre_configure() {
    typeset arch=$1

    ! cross_arch $arch && return

    CONFIGURE_OPTS[$arch]+="
        --build=${TRIPLETS[$BUILD_ARCH]}
    "

    # configure tries to find the build triplet prefixed gcc
    PATH+=":/opt/gcc-$DEFAULT_GCC_VER/bin"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf -autoreconf
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
