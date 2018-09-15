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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.

. ../../lib/functions.sh

# The following lines starting with PKG= let buildctl spot the packages that
# are actually built by the makefiles in the pkg source. Also build a package
# list to use later when showing package differences.
PKG=package/pkg
PKGLIST=$PKG
PKG=package/pkg-35
PKGLIST+=" $PKG"
PKG=system/zones/brand/ipkg
PKGLIST+=" $PKG"
PKG=system/zones/brand/lipkg
PKGLIST+=" $PKG"
PKG=system/zones/brand/sparse
PKGLIST+=" $PKG"
PKG=system/zones/brand/bhyve
PKGLIST+=" $PKG"
PKG=system/zones/brand/kvm
PKGLIST+=" $PKG"
SUMMARY="This isn't used"
DESC="$SUMMARY"

PROG=pkg
VER=omni
BUILDNUM=$RELVER
if [ -z "$PKGPUBLISHER" ]; then
    logerr "No PKGPUBLISHER specified. Check lib/site.sh"
    exit
fi

BUILD_DEPENDS_IPS="
    developer/versioning/git
    system/zones/internal
    text/intltool
"
RUN_DEPENDS_IPS="runtime/python-27"

# Respect environmental overrides for these to ease development.
: ${PKG_SOURCE_REPO:=$GITHUB/pkg5}
: ${PKG_SOURCE_BRANCH:=r$RELVER}
VER+="-$PKG_SOURCE_BRANCH"

clone_source() {
    clone_github_source pkg \
        "$PKG_SOURCE_REPO" "$PKG_SOURCE_BRANCH" "$PKG5_CLONE"
}

build() {
    pushd $TMPDIR/$BUILDDIR/pkg/src > /dev/null || logerr "Cannot chdir"
    logmsg "--- toplevel build"
    logcmd make clean
    logcmd make CODE_WS=$TMPDIR/$BUILDDIR/pkg || logerr "make failed"
    logmsg "--- proto install"
    logcmd make install CODE_WS=$TMPDIR/$BUILDDIR/pkg || logerr "install failed"
    popd > /dev/null
}

package() {
    pushd $TMPDIR/$BUILDDIR/pkg/src/pkg > /dev/null
    logmsg "--- packaging"
    logcmd make clean
    logcmd make \
        CODE_WS=$TMPDIR/$BUILDDIR/pkg \
        BUILDNUM=$BUILDNUM || logerr "pkg make failed"
    logcmd make publish-pkgs \
        CODE_WS=$TMPDIR/$BUILDDIR/pkg \
        BUILDNUM=$BUILDNUM \
        PKGSEND_OPTS="" \
        PKGPUBLISHER=$PKGPUBLISHER \
        PKGREPOTGT="" \
        PKGREPOLOC="$PKGSRVR" \
        || logerr "publish failed"
    popd > /dev/null
}

init
clone_source
build
package

if [ -z "$BATCH" -a -z "$SKIP_PKG_DIFF" ]; then
    for pkg in $PKGLIST; do
        fmri="`pkg list -nvHg $PKGSRVR $pkg | awk '{print $1}'`"
        logmsg "-- For package $fmri"
        diff_package $fmri
    done
fi

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
