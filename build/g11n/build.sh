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
#
# Copyright 2011-2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

# These are here so that buildctl can see what packages get built.
# Makefiles in the repo do the actual publishing.
PKG=system/library/iconv/utf-8
PKG=system/library/iconv/utf-8/manual
PKG=system/library/iconv/unicode
PKG=system/library/iconv/extra
PKG=system/library/iconv/xsh4/latin
PKG=system/install/locale
PKG=text/auto_ef
SUMMARY="This isn't used"
DESC="$SUMMARY"

PROG=g11n
VER=$PVER
BUILDNUM=$RELVER

if [ -z "$PKGPUBLISHER" ]; then
    logerr "No PKGPUBLISHER specified in config.sh"
    exit
fi

BUILD_DEPENDS_IPS="
    developer/versioning/git
    library/idnkit
    library/idnkit/header-idnkit
    developer/build/make
"

# Respect environmental overrides for these to ease development.
: ${G11N_SOURCE_REPO:=$GITHUB/g11n}
: ${G11N_SOURCE_BRANCH:=r$RELVER}

clone_source() {
    clone_github_source g11n \
        "$G11N_SOURCE_REPO" "$G11N_SOURCE_BRANCH" "$G11N_CLONE"

    export SRC=$TMPDIR/$BUILDDIR/g11n
    export PKGARCHIVE=$SRC
}

build() {
    pushd $TMPDIR/$BUILDDIR/g11n > /dev/null \
        || logerr "Cannot change to src dir"
    logmsg "--- toplevel build"
    # Why do we run this four times?
    for i in `seq 0 3`; do
        logcmd dmake
    done
    logcmd dmake || logerr "dmake failed"
    logmsg "--- proto install"
    logcmd dmake install || logerr "proto install failed"
    popd > /dev/null
}

install_man() {
    logmsg "--- installing man page"
    logcmd mkdir -p $SRC/proto/i386/fileroot/usr/share/man/man5/ \
        || logerr "could not create destdir for man page"
    logcmd cp files/iconv_en_US.UTF-8.5 \
        $SRC/proto/i386/fileroot/usr/share/man/man5/iconv_en_US.UTF-8.5 \
        || logerr "could not copy man page"
}

package() {
    pushd $TMPDIR/$BUILDDIR/g11n/pkg > /dev/null
    logmsg "--- packaging"
    ISALIST=i386 CC=gcc logcmd dmake \
        CLOSED_BUILD=no \
        L10N_BUILDNUM=$BUILDNUM \
        || logerr "pkg make failed"
    ISALIST=i386 CC=gcc logcmd dmake publish_pkgs \
        SRC=$SRC CLOSED_BUILD=no L10N_BUILDNUM=$BUILDNUM \
        PKGPUBLISHER_REDIST=$PKGPUBLISHER \
        || logerr "publish failed"
    popd > /dev/null
}

push_pkgs() {
    pushd $SRC > /dev/null
    logmsg "Rebuilding repository metadata"
    logcmd pkgrepo rebuild -s repo.redist || logerr "repo rebuild failed"
    logmsg "Pushing g11n pkgs to $PKGSRVR..."
    logcmd pkgrecv -s repo.redist/ -d $PKGSRVR 'pkg:/*' || logerr "push failed"
    popd > /dev/null
}

init
clone_source
build
install_man
package
push_pkgs

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
