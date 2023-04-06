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
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
#

. ../../lib/build.sh

PROG=omnios
VER=$RELVER
PVER=1

PKG=illumos-gate
SUMMARY="$PROG"
DESC="$SUMMARY -- illumos and some special sauce."

BUILD_DEPENDS_IPS="developer/illumos-tools"

PKGPREFIX=""
PREFIX=""
set_builddir "$USER-$PROG-$VER"

publish_pkgs() {
    typeset arch=${1:-i386}; shift
    typeset root=${1:-$CODEMGR_WS}; shift
    typeset repo=${1:-$PKGSRVR}; shift
    typeset mog=$1

    logmsg "Entering $root"
    pushd $root > /dev/null

    logmsg "Pushing illumos packages to $repo..."

    ndrepo=packages/$arch/nightly-nd/repo.redist
    drepo=packages/$arch/nightly/repo.redist

    [ -d "$drepo" ] || logerr "No DEBUG repo at $drepo"

    logmsg "Repository information"
    $PKGREPO -s $drepo info
    echo

    [ "$FLAVOR" = ctf ] && \
        FLAVOR="SUNWcs `pkg search -H -o pkg.name -s $drepo \
        dir:path:/kernel OR dir:path:/platform OR dir:path:/usr/platform \
        | $EGREP -v '^ooce/|virtualization/kvm|graphics/(agpgart|drm)'`"

    if [ -d "$ndrepo" -a -d "$drepo" ]; then
        # Use pkgmerge to set variants for non-DEBUG and DEBUG.
        # The idea is, if someone wants to shift their illumos from
        # non-DEBUG (default) to DEBUG, they can simply utter:
        #
        #      pkg change-variant debug.illumos=true
        #
        # and a new BE with DEBUG bits appears.

        $PKGMERGE -d $repo \
            -s debug.illumos=false,$ndrepo/ \
            -s debug.illumos=true,$drepo/ \
            $FLAVOR
    else
        $PKGRECV -d $repo -s $drepo -m latest \
            ${mog:+--mog-file} ${mog} \
            ${FLAVOR:-'*'}
    fi

    logmsg "Leaving $root"
    popd > /dev/null
}

build_aarch64() {
    # Respect environmental overrides for these to ease development.
    : ${ARM_SOURCE_REPO:=$OOCEGITHUB/illumos-omnios}
    : ${ARM_SOURCE_BRANCH:=arm64-gate}
    VER+="-$ARM_SOURCE_BRANCH"

    typeset action=
    if [[ "$FLAVOR" =~ (bldenv|pkg) ]]; then
        action=$FLAVOR
        unset FLAVOR
    else
        clone_github_source $PKG \
            "$ARM_SOURCE_REPO" "$ARM_SOURCE_BRANCH" "$ARM_CLONE"
        ((EXTRACT_MODE)) && exit
    fi

    pushd $TMPDIR/$BUILDDIR/$PKG >/dev/null
    typeset cmd=nightly

    typeset env="
        ONNV_BUILDNUM=$RELVER
        aarch64_SYSROOT=${SYSROOT[aarch64]}
        PKGPUBLISHER_REDIST=$PKGPUBLISHER
        DMAKE_MAX_JOBS=$MJOBS
        PYTHON3_VERSION=$PYTHONVER
        PERL_VERSION=$SPERLVER
        DTC=$OOCEBIN/dtc
        MKIMAGE=$OOCEOPT/u-boot/tools/mkimage
    "

    typeset envfile=$SRCDIR/files/aarch64.env
    for cmd in bldenv nightly; do
        typeset $cmd="usr/src/tools/scripts/$cmd -T aarch64 $envfile"
    done

    # Allow dropping into the build environment with everything set up
    # for manual builds via '-f bldenv'
    if [ "$action" = bldenv ]; then
        env - $env TERM=$TERM SHELL=$SHELL $bldenv
        return
    fi

    if [ "$action" != "pkg" ]; then
        logmsg "-- building illumos"

        typeset logf=log/nightly.log

        logcmd env - $env $nightly &
        typeset -i nightlypid=$!

        # Start a background process to report some progress output
        (
            while [ ! -f "$logf" ]; do
                $SLEEP 1
            done
            $TAIL -f "$logf" | $EGREP '^(====|real |user |sys )'
        ) &
        typeset -i monitorpid=$!

        wait $nightlypid
        kill -9 $monitorpid

        typeset repo=packages/aarch64/nightly/repo.redist

        # XXX For unknown reasons, the following synthetic packages don't get
        # published.
        logcmd $PKGSEND publish -s $repo \
            usr/src/pkg/packages.aarch64/osnet-{redist,incorporation}.mog

        # We don't want these packages
        logcmd $PKGREPO -s $repo remove osnet ssh-common
    fi

    popd >/dev/null

    publish_pkgs aarch64 $TMPDIR/$BUILDDIR/$PKG ${REPOS[aarch64]} \
        "$SRCDIR/files/aarch64.mog"
}

init
prep_build
if [ "$BUILDARCH" = aarch64 ]; then
    build_aarch64
else
    check_for_prebuilt 'packages/i386/nightly-nd/repo.redist/'
    CODEMGR_WS=$PREBUILT_ILLUMOS
    publish_pkgs
fi
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
