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
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=bind
VER=9.16.18
PKG=network/dns/bind
SUMMARY="BIND DNS tools"
DESC="Client utilities for DNS lookups"

LIBUVVER=1.41.1
XFORM_ARGS+=" -DLIBUV=$LIBUVVER"

# This package ships private shared libraries in $PREFIX/lib/dns that are only
# provided for use by the client utilities. We can therefore build everything
# as 64-bit only and avoid shipping the include files, python modules and
# library man pages (see local.mog)
set_arch 64
set_standard XPG4v2 CFLAGS

CONFIGURE_OPTS="
    --libdir=$PREFIX/lib/dns
    --bindir=$PREFIX/sbin
    --localstatedir=/var
    --with-libtool
    --with-openssl
    --enable-threads=yes
    --enable-devpoll=yes
    --enable-fixed-rrset
    --disable-getifaddrs
    --enable-shared
    --disable-static
    --without-python
"

init
prep_build autoconf -autoreconf

#########################################################################
# Download and build a static version of libuv

save_buildenv
save_function configure64 _configure64

configure64() {
    run_inbuild "./autogen.sh"
    _configure64 "$@"
}

CFLAGS+=" -fPIC"
CONFIGURE_OPTS=" --disable-shared --enable-static"

build_dependency libuv libuv-$LIBUVVER libuv v$LIBUVVER

save_function _configure64 configure64
restore_buildenv

export LIBUV_CFLAGS="-I$DEPROOT$PREFIX/include"
export LIBUV_LIBS="-L$DEPROOT$PREFIX/lib/$ISAPART64 -luv"

#########################################################################

download_source $PROG $PROG $VER
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
