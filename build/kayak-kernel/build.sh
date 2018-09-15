#!/usr/bin/bash

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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#

# We have to build as root to manipulate ZFS datasets
export ROOT_OK=yes
. ../../lib/functions.sh

PROG=kayak-kernel
PKG=system/install/kayak-kernel
VER=1.1
SUMMARY="Kayak - network installer media"
DESC="$SUMMARY"

KAYAK_CLOBBER=${KAYAK_CLOBBER:=0}

if [ -n "$SKIP_KAYAK_KERNEL" ]; then
    logmsg "Skipping kayak-kernel build"
    exit 0
fi

# Reality check.
if [ "$UID" = 0 ]; then
    SUDO=""
    OLDUSER=root
elif [ -n "$KAYAK_SUDO_BUILD" ]; then
    SUDO="$PFEXEC"
    OLDUSER=`whoami`
else
    logerr "--- You must be root or set KAYAK_SUDO_BUILD"
    logmsg "Proceeding as if KAYAK_SUDO_BUILD was set to 1."
    KAYAK_SUDO_BUILD=1
    SUDO="$PFEXEC"
    OLDUSER=`whoami`
fi

# Explicitly figure out BATCH so the sudo-bits can honour it.
[ "$BATCH" = 1 ] && BATCHMODE=1 || BATCHMODE=0

# Set up VERSION now in the environment for Kayak's makefiles if needed.
# NOTE: This is currently dependent on PREBUILT_ILLUMOS as a way to prevent
# least-surprise. We may want to promote this to "do it all the time!"
if [ -d ${PREBUILT_ILLUMOS:-/dev/null} ]; then
    logmsg "Using pre-built illumos at $PREBUILT_ILLUMOS (may need to wait)"
    wait_for_prebuilt
    export VERSION=r$RELVER
    logmsg "Using VERSION=$VERSION"
else
    logmsg "Using non-pre-built illumos - unsetting VERSION."
    unset VERSION
    PREBUILT_ILLUMOS="/dev/null"
fi

# NOTE: If PKGURL is specified, allow it to be different than the destination
# PKGSRVR. PKGURL is from where kayak-kernel takes its bits. PKGSRVR is where
# this package (with a prebuilt miniroot and unix) will be installed.
PKGURL=${PKGURL:=$PKGSRVR}
export PKGURL
logmsg "Grabbing packages from $PKGURL."
logmsg "Publishing kayak-kernel to $PKGSRVR."

# Respect environmental overrides for these to ease development.
: ${KAYAK_SOURCE_REPO:=$GITHUB/kayak}
: ${KAYAK_SOURCE_BRANCH:=r$RELVER}

clone_source() {
    clone_github_source kayak \
        "$KAYAK_SOURCE_REPO" "$KAYAK_SOURCE_BRANCH" "$KAYAK_CLONE"

    gdir=$TMPDIR/$BUILDDIR/kayak
    GITREV=`$GIT -C $gdir log -1  --format=format:%at`
    COMMIT=`$GIT -C $gdir log -1  --format=format:%h`
    REVDATE=`echo $GITREV | gawk '{ print strftime("%c %Z",$1) }'`
    VERHUMAN="${COMMIT:0:7} from $REVDATE"
}

init
prep_build
clone_source
logmsg "Now building $PKG"
$SUDO ./sudo-bits.sh $KAYAK_CLOBBER $TMPDIR/$BUILDDIR \
    $PREBUILT_ILLUMOS $DESTDIR $PKGURL $VER $OLDUSER $BATCHMODE \
    || logerr "--- sudo-bits sub-script failed."
make_package kayak-kernel.mog
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
