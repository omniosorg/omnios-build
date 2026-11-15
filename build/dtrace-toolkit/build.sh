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
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=DTraceToolkit
VER=0.99.20261115
PKG=developer/dtrace/toolkit
SUMMARY="$PROG ($VER)"
DESC="$PROG - a collection of over 200 useful and documented DTrace scripts"

set_builddir toolkit-$VER

PREFIX=/opt/DTT

# The toolkit is just scripts, so there is nothing to compile
build_toolkit() {
    logmsg "Installing contents to packaging directory $DESTDIR/$PREFIX"
    logcmd mkdir -p $DESTDIR/$PREFIX \
        || logerr "--- Could not create packaging directory"
    logcmd rsync -a $TMPDIR/$BUILDDIR/ $DESTDIR/$PREFIX/ \
        || logerr "--- Installation failed."
}

init
download_source $PROG v$VER
patch_source
prep_build
build_toolkit
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
