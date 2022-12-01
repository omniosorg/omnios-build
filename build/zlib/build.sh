#!/usr/bin/bash

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

# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=zlib
VER=1.2.13
PKG=library/zlib
SUMMARY="$PROG compression library"
DESC="A patent-free compression library"

SKIP_LICENCES=zlib

CFLAGS+=" -DNO_VIZ"

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --includedir=$PREFIX/include
"
CONFIGURE_OPTS[i386]="--libdir=$PREFIX/lib"
CONFIGURE_OPTS[amd64]="--libdir=$PREFIX/lib/amd64"
CONFIGURE_OPTS[aarch64]="--libdir=$PREFIX/lib/aarch64"
LDFLAGS[i386]+=" -lssp_ns"
export cc=$CC

SO_LDFLAGS="-Wl,-ztext -Wl,-zdefs"
MAKE_ARGS_WS="
    LDSHARED=\"$CC -shared -nostdlib $SO_LDFLAGS -Wl,-h,libz.so.1\"
"

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf-like
build
run_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
