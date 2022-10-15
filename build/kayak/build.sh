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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#

. ../../lib/build.sh

PROG=kayak
VER=1.1
PKG=system/install/kayak
SUMMARY="Kayak - OmniOS media generator and server"
DESC="Kayak generates install media for OmniOS: either ISO/USB or network installation using PXE, DHCP, and HTTP"

BUILD_DEPENDS_IPS="developer/versioning/git"
RUN_DEPENDS_IPS="
    developer/build/gnu-make
"

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
    ((EXTRACT_MODE)) && exit
}

build_server() {
    pushd $TMPDIR/$BUILDDIR/kayak > /dev/null \
        || logerr "Cannot change to src dir"
    logmsg "Installing server files"
    logcmd gmake DESTDIR=$DESTDIR install-package \
        || logerr "gmake failed"
    popd > /dev/null
}

init
clone_source
prep_build
build_server
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
