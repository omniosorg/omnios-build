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
# Copyright 2011-2013 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
#
# Copyright (c) 2014, 2016 by Delphix. All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=fio
VER=3.5
VERHUMAN=$VER
PKG=system/test/fio
SUMMARY="Flexible IO Tester"
DESC="Flexible IO Tester"
NOSCRIPTSTUB=1
BUILDDIR=$PROG-$PROG-$VER

CONFIGURE_OPTS=
CONFIGURE_OPTS_32=
CONFIGURE_OPTS_64="--extra-cflags=-m64"

make_install32() {
    logcmd $MAKE DESTDIR=${DESTDIR} bindir="/usr/bin/i386" install || \
        logerr "--- Make install failed"
}

make_install64() {
    logcmd $MAKE DESTDIR=${DESTDIR} bindir="/usr/bin/amd64" install || \
        logerr "--- Make install failed"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
