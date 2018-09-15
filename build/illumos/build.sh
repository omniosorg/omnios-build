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

PROG=omnios
VER=$RELVER
PVER=1

PKG=illumos-gate
SUMMARY="$PROG"
DESC="$SUMMARY -- illumos and some special sauce."

BUILD_DEPENDS_IPS="developer/illumos-tools"

PKGPREFIX=""
PREFIX=""
BUILDDIR=$USER-$PROG-$VER

push_pkgs() {
    logmsg "Entering $CODEMGR_WS"
    pushd $CODEMGR_WS > /dev/null
    logmsg "Pushing illumos pkgs to $PKGSRVR..."

    # Use pkgmerge to set pkg(5) variants for non-DEBUG and DEBUG.
    # The idea is, if someone wants to shift their illumos from
    # non-DEBUG (default) to DEBUG, they can simply utter:
    #
    #      pkg change-variant debug.illumos=true
    #
    # and a new BE with DEBUG bits appears.

    # A particular package or pattern can be specified using the -f argument
    # to this build script which sets $FLAVOR

    ndrepo=packages/i386/nightly-nd/repo.redist
    drepo=packages/i386/nightly/repo.redist

    logmsg "Repository information"
    pkgrepo -s $ndrepo info
    echo

    [ "$FLAVOR" = ctf ] && \
        FLAVOR="SUNWcs `pkg search -H -o pkg.name \
            dir:path:/kernel OR dir:path:/platform \
            | egrep -v 'driver/virtualization/kvm'`"

    pkgmerge -d $PKGSRVR \
        -s debug.illumos=false,$ndrepo/ \
        -s debug.illumos=true,$drepo/ \
        $FLAVOR

    logmsg "Leaving $CODEMGR_WS"
    popd > /dev/null
}

init
prep_build
check_for_prebuilt 'packages/i386/nightly-nd/repo.redist/'
CODEMGR_WS=$PREBUILT_ILLUMOS
push_pkgs
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
