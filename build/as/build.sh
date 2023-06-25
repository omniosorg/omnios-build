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
# Copyright 2020 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=as
VER=0.5.11
PKG=developer/as
SUMMARY="$DISTRO Bundled Assembler (aka DevPro)"
DESC="$SUMMARY"

set_builddir as

# This package contains closed binaries that have some old dependencies
SKIP_RTIME_CHECK=1
set_ssp none

install() {
    pushd $TMPDIR/$BUILDDIR >/dev/null
    logcmd rsync -avr ${PREFIX#/}/ $DESTDIR/${PREFIX#/}/
    popd >/dev/null
}

init
download_source on-closed as
patch_source
prep_build
install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
