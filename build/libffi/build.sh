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

PROG=libffi
VER=3.2.1
VERHUMAN=$VER
PKG=library/libffi
SUMMARY="A Portable Foreign Function Interface Library"
DESC="$SUMMARY"

make_prog32() {
    logmsg "Making program (32)"
    logcmd gmake
    pushd i386-pc-solaris2.11 > /dev/null
    logcmd gmake clean
    libtool_nostdlib libtool -lc
    logcmd gmake || logerr "make failed"
    popd > /dev/null
}

make_install32() {
    logmsg "Installing program (32)"
    pushd i386-pc-solaris2.11 > /dev/null
    logcmd gmake install DESTDIR="$DESTDIR"
    popd > /dev/null
}

make_prog64() {
    logmsg "Making program (64)"
    logcmd gmake
    pushd i386-pc-solaris2.11 > /dev/null
    logcmd gmake clean
    libtool_nostdlib libtool -lc
    logcmd gmake || logerr "make failed"
    popd > /dev/null
}

make_install64() {
    logmsg "Installing program (64)"
    pushd i386-pc-solaris2.11 > /dev/null
    logcmd gmake install DESTDIR="$DESTDIR"
    popd > /dev/null
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
