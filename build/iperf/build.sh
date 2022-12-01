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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=iperf
VER=3.1.3
PKG=network/test/iperf
SUMMARY="iperf network testing tool"
DESC="$SUMMARY $VER"

DEPENDS_IPS="system/library"

set_arch 64

CONFIGURE_OPTS="
    --bindir=$PREFIX/bin
    --disable-static
"
LDFLAGS="-lsocket -lnsl"
SKIP_LICENCES=iperf

make_symlinks()  {
    logcmd ln -s iperf3 $DESTDIR/usr/bin/iperf
    logcmd ln -s iperf3.1 $DESTDIR/usr/share/man/man1/iperf.1
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_symlinks
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
