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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=unzip
VER=6.0
VERHUMAN=$VER
PKG=compress/unzip
SUMMARY="The Info-Zip (unzip) compression utility"
DESC="$SUMMARY"

BUILDDIR=$PROG${VER//./}
set_arch 32

HARDLINK_TARGETS="
    usr/bin/unzip
"

# Copied from upstream's pkg makefile
export LOCAL_UNZIP="-DUNICODE_SUPPORT -DNO_WORKING_ISPRINT -DUNICODE_WCHAR"

configure32() {
    export ISAPART
}

BASE_MAKE_ARGS="-f unix/Makefile"
MAKE_ARGS="$BASE_MAKE_ARGS generic_gcc"
MAKE_INSTALL_ARGS="$BASE_MAKE_ARGS install"

init
download_source $PROG $PROG${VER//./}
patch_source
prep_build
MAKE_INSTALL_ARGS+=" prefix=$DESTDIR$PREFIX"
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
