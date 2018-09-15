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
# Use is subject to license terms.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=cpp
VER=0.5.11
PKG=developer/macro/cpp
SUMMARY="The C Pre-Processor (cpp)"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="developer/parser/bison"

setup_src() {
   logcmd mkdir -p $TMPDIR/$BUILDDIR
   logcmd cp $SRCDIR/files/* $TMPDIR/$BUILDDIR || logerr "file copy failed"
}

build() {
    # Set the version to something reasonable
    pushd $TMPDIR/$BUILDDIR > /dev/null || logerr "can't enter build harness"
    logcmd gmake CC=gcc
    popd > /dev/null
}

make_install() {
    logcmd mkdir -p $DESTDIR/usr/lib || logerr "mkdir failed"
    logcmd mkdir -p $DESTDIR/usr/ccs/lib || logerr "mkdir failed"
    pushd $TMPDIR/$BUILDDIR > /dev/null || logerr "can't enter build harness"
    logcmd gmake install CC=gcc DESTDIR=$DESTDIR
    popd > /dev/null
}

init
setup_src
prep_build
build
make_install
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
