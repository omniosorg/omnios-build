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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2020 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PKG=package/pkg
PKGLIST=$PKG
SUMMARY="This isn't used"
DESC="$SUMMARY"

ARCH=aarch64
[ "$CLIBUILDARCH" = $ARCH ] || logerr "Incorrect arch selected, use -a $ARCH"

PROG=pkg
VER=omni
BUILDNUM=$RELVER
[ -n "$PKGPUBLISHER" ] || logerr "No PKGPUBLISHER specified. Check lib/site.sh"

# Respect environmental overrides for these to ease development.
: ${PKG_SOURCE_REPO:=$OOCEGITHUB/pkg5}
: ${PKG_SOURCE_BRANCH:=r$RELVER}
VER+="-$PKG_SOURCE_BRANCH"

clone_source() {
    clone_github_source pkg \
        "$PKG_SOURCE_REPO" "$PKG_SOURCE_BRANCH" "$PKG5_CLONE"
    ((EXTRACT_MODE)) && exit
}

build() {
    pushd $TMPDIR/$BUILDDIR/pkg/src > /dev/null || logerr "Cannot chdir"
    python_cross_setup $ARCH
    logmsg "--- generate CFFI source"
    logcmd make cffi_src
    logmsg "--- build"
    logcmd python setup.py install
    logmsg "--- modules"
    logcmd make -e \
        MACH=$ARCH \
        REQUIREMENTS=requirements-aarch64.txt \
        TARGET=install modules/$PYTHON3VER
    popd > /dev/null
}

package() {
    pushd $TMPDIR/$BUILDDIR/pkg/src/pkg > /dev/null
    logmsg "--- packaging"
    logcmd make publish-pkgs \
        BUILDNUM=$BUILDNUM \
        PKGSEND_OPTS="" \
        PKGPUBLISHER=$PKGPUBLISHER \
        PKGREPOTGT="" \
        PKGREPOLOC="${REPOS[$ARCH]}" \
		ARCH=$ARCH \
		PKGCMDENV=/usr/bin \
		MANIFESTS='package\:pkg.p5m' \
		PKG_IMAGE=${SYSROOT[$ARCH]} \
        || logerr "publish failed"
    popd > /dev/null
}

init
clone_source
build
package

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
