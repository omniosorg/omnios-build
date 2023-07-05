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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=libffi
VER=3.4.4
PKG=library/libffi
SUMMARY="A Portable Foreign Function Interface Library"
DESC="$PROG - $SUMMARY"

SKIP_LICENCES=libffi

LDFLAGS+=" $SSPFLAGS"

export MAKE

# libffi has historically been linked with libtool's -nostdlib.
# The exact reason for this unclear but historic commit messages indicate that
# it may be related to C++ throw/catch across the library interface.
# We should try and clarify the exact reason but we retain the same link
# behaviour.

post_make() {
    typeset arch="$1"
    typeset tripl
    [ "$arch" = 'i386' ] && tripl='amd64' || tripl=$arch
    logmsg "--- rebuilding libraries with -nostdlib"
    pushd ${TRIPLETS[$tripl]} >/dev/null || logerr "pushd"
    if [ $arch = 'i386' ]; then
        libtool_nostdlib libtool "-lc -lssp_ns"
    else
        # link libgcc for __clear_cache
        libtool_nostdlib libtool "-lgcc -lc"
    fi
    logcmd $MAKE clean all || logerr "Rebuild with -nostdlib failed"
    popd >/dev/null
}

post_build() {
    typeset arch="$1"
    typeset tripl
    typeset nm=nm
    cross_arch $arch && nm=${TRIPLETS[$arch]}-nm
    [ "$arch" = 'i386' ] && tripl='amd64' || tripl=$arch
    $nm $TMPDIR/$BUILDDIR/${TRIPLETS[$tripl]}/.libs/libffi.so \
        | $EGREP '\|_(init|fini)' \
        && logerr "libffi was linked against standard libraries."
}

init
prep_build

note -n "Building current version: $VER"
download_source $PROG $PROG $VER
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
