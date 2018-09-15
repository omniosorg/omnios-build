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

. ../../lib/functions.sh

PROG=sccs
VER=0.5.11
PKG=developer/versioning/sccs
SUMMARY="Source Code Control System (SCCS)"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="sunstudio12.1 compatibility/ucb"
RUN_DEPENDS_IPS="system/library/math"

build() {
    logmsg "Building and installing ($1)"
    pushd $TMPDIR/$1/usr/src > /dev/null || logerr "can't enter build harness"
    logcmd env STUDIOBIN=$SUNSTUDIO_BIN DESTDIR=$DESTDIR ./build \
        || logerr "make/install ($1) failed"
    popd > /dev/null
}

move_and_links() {
    logmsg "Shifting binaries and setting up links"
    logcmd mkdir -p $DESTDIR/usr/bin
    logcmd mv $DESTDIR/usr/ccs/bin/help $DESTDIR/usr/bin/sccshelp \
        || logerr "help move failed"
    pushd $DESTDIR/usr/ccs/bin > /dev/null || logerr "Cannot chdir"
    for cmd in *; do
        [ -x "$cmd" ] || continue
        logcmd mv $cmd ../../bin/ || logerr "Cannot relocate /usr/ccs/bin/$cmd"
        logcmd ln -s ../../bin/$cmd $cmd || logerr "Link $cmd failed"
    done
    logcmd ln -s ../../bin/sccshelp sccshelp || logerr "sccshelp link"
    logcmd ln -s ../../bin/sccshelp help || logerr "sccshelp link2"
    popd > /dev/null
}

init
prep_build
BUILDDIR=devpro-sccs-20061219
download_source devpro devpro-sccs src-20061219
build devpro-sccs-20061219
move_and_links
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
