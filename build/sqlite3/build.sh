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
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=sqlite-autoconf
VER=3450000
PKG=database/sqlite-3
SUMMARY="SQL database engine library"
DESC="SQLite is a self-contained, high-reliability, embedded, full-featured, "
DESC+="public-domain, SQL database engine."

SKIP_LICENCES="Public Domain"

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

CONFIGURE_OPTS="--disable-static"

CFLAGS+=" -DSQLITE_ENABLE_COLUMN_METADATA"

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
