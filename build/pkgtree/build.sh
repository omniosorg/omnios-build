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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=pkgtree
VER=1.1
VERHUMAN=$VER
PKG=system/pkgtree
SUMMARY="pkgtree displays the IPS package dependency tree."
DESC="pkgtree takes package information from the running system, caches it, then displays dependency information for all packages or for an individual package selected by pkg_fmri."

BUILD_DEPENDS_IPS="network/rsync runtime/perl/manual"
RUN_DEPENDS_IPS="runtime/perl"

build() {
    pushd $TMPDIR/$BUILDDIR > /dev/null

    VENDOR_DIR="${DESTDIR}${PREFIX}/perl5/vendor_perl/${SPERLVER}"
    logmsg "Copying files"
    logcmd mkdir -p $VENDOR_DIR || logerr "--- Failed to make vendor_perl dir"
    pushd lib/perl5 > /dev/null
    logcmd rsync -a . $VENDOR_DIR/ || logerr "--- Failed to copy files"
    popd > /dev/null
    logcmd mkdir ${DESTDIR}${PREFIX}/bin || logerr "--- Failed to make bin dir"
    logcmd rsync -a bin/ ${DESTDIR}${PREFIX}/bin/ \
        || logerr "--- Failed to install bins"

    MAN_DIR="${DESTDIR}${PREFIX}/share/man/man1"
    POD2MAN="/usr/perl5/bin/pod2man"
    logmsg "Creating man page"
    logcmd mkdir -p $MAN_DIR || logerr "--- Failed to make man1 dir"
    logcmd $POD2MAN bin/pkgtree $MAN_DIR/pkgtree.1 \
        || logerr "--- Failed to make man page"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
