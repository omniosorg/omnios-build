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
# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#

. ../../lib/build.sh

PROG=devpro-libmtsk
MTSKVER=20060131
PKG=system/library/mtsk
VER=0.5.11
SUMMARY="Microtasking Libraries"
DESC="$SUMMARY"

set_builddir $PROG
set_ssp none
SKIP_RTIME_CHECK=1

# These are pre-built binaries which cannot be re-linked with a
# non-executable data segment.
EXECDATA_EXPECTED=1

build() {
    rsync -a $TMPDIR/$BUILDDIR/lib/ $DESTDIR/lib/ || logerr "rsync failed"
}

init
download_source on-closed $PROG $MTSKVER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
