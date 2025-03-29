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

# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=sqlite-autoconf
VER=3490100
PKG=database/sqlite-3
SUMMARY="SQL database engine library"
DESC="SQLite is a self-contained, high-reliability, embedded, full-featured, "
DESC+="public-domain, SQL database engine."

SKIP_LICENCES="Public Domain"

forgo_isaexec

VERHUMAN="`echo $VER | sed '
    # Mmmsspp -> M.mm.ss.pp
    s/\(.\)\(..\)\(..\)\(..\)/\1.\2.\3.\4/
    # Remove leading zeros
    s/\.0/./g
    # Remove empty last component
    s/\.0$//
'`"
[ -n "$VERHUMAN" ] || logerr "-- Could not build VERHUMAN"
logmsg "-- Building version $VERHUMAN"

CONFIGURE_OPTS="
    --disable-static
    --enable-fts4
    --enable-fts5
    --enable-rtree
    --enable-json
"

# The new sqlite autoconf system delivers the shared library as
#   libsqlite3.so.<ver>
# but still symlinks that back to libsqlite3.so.0 (!). This is unfortunate.
# We use `--soname=legacy` here to make the embedded soname in the final
# library patch that symlink, libsqlite3.so.0. We must also skip the ABI check
# as it will always detect that the ABI has changed from 3 to 0, which it
# hasn't!
SKIP_ABICHECK=1
CONFIGURE_OPTS+="
    --soname=legacy
"

pre_build() {
    typeset arch=$1

    ! cross_arch $arch && return

    # When cross compiling we can't automatically detect readline and the shell
    # ends up without support.
    typeset sysr=${SYSROOT[$arch]}
    CONFIGURE_OPTS[${arch}_WS]="
        --enable-readline
        --with-readline-ldflags=\"-lreadline -lncurses\"
        --with-readline-header=$sysr/usr/include/readline/readline.h
    "
    LDFLAGS[$arch]+=" -L $sysr/${LIBDIRS[$arch]}"
}

export CC_FOR_BUILD=$GCC
CFLAGS+=" -DSQLITE_ENABLE_COLUMN_METADATA"
LDFLAGS[i386]+=" -lssp_ns"

init
download_source sqlite $PROG $VER
patch_source
prep_build
build
make_isa_stub
VER=$VERHUMAN
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
