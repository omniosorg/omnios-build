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
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=rsync
VER=3.3.0
PKG=network/rsync
SUMMARY="rsync - faster, flexible replacement for rcp"
DESC="An open source utility that provides fast incremental file transfer"

XXHASHVER=0.8.3
XFORM_ARGS+=" -DXXHASH=$XXHASHVER"

set_arch 64

init
prep_build

#########################################################################
# Download and build a static version of xxhash

save_buildenv
CONFIGURE_CMD=/bin/true \
    MAKE_INSTALL_ARGS="prefix=$PREFIX" \
    INSTALL=$GNUBIN/install \
    MAKE_ARGS_WS="MOREFLAGS=\"$CTF_CFLAGS\"" \
    build_dependency xxhash xxHash-$XXHASHVER xxhash v$XXHASHVER
restore_buildenv

# We want rsync to link statically with xxhash, rather than bundling the
# .so files
logcmd rm -f $DEPROOT/usr/lib/*.so*
LDFLAGS+=" -L$DEPROOT/usr/lib"
CPPFLAGS+=" -I$DEPROOT/usr/include"

#########################################################################

note -n "-- Building $PROG"

CONFIGURE_OPTS="
    --with-included-popt
    --enable-ipv6
"
# Needed so that man pages are correctly installed every time
REMOVE_PREVIOUS=1

post_configure() {
    $MAKE reconfigure
}

TESTSUITE_FILTER='^[A-Z#][A-Z ]|^-|[0-9] (passed|failed|skipped|missing)'

download_source $PROG $PROG $VER
patch_source
build
run_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
