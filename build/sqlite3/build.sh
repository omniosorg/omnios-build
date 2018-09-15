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

PROG=sqlite-autoconf
VER=3240000
PKG=database/sqlite-3
SUMMARY="SQL database engine library"
DESC="$SUMMARY"

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

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
