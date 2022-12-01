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

# Previous versions that also need to be built and packaged since compiled
# software may depend on it.
PVERS="3.2.1 3.3"

LDFLAGS+=" $SSPFLAGS"

export MAKE

# libffi has historically been linked with libtool's -nostdlib.
# The exact reason for this unclear but historic commit messages indicate that
# it may be related to C++ throw/catch across the library interface.
# We should try and clarify the exact reason but we retain the same link
# behaviour.

post_make() {
    typeset arch="$1"
    logmsg "--- rebuilding libraries with -nostdlib"
    pushd $TRIPLET64 >/dev/null || logerr "pushd"
    if [ $arch = 'i386' ]; then
        libtool_nostdlib libtool "-lc -lssp_ns"
    else
        libtool_nostdlib libtool "-lc"
    fi
    logcmd $MAKE clean all || logerr "Rebuild with -nostdlib failed"
    popd >/dev/null
}

tests() {
    nm $TMPDIR/$BUILDDIR/$TRIPLET64/.libs/libffi.so | $EGREP '\|_(init|fini)' \
        && logerr "libffi was linked against standard libraries."
}

init
prep_build

# Build previous versions
save_variables BUILDDIR EXTRACTED_SRC
for pver in $PVERS; do
    note -n "Building previous version: $pver"
    set_builddir $PROG-$pver
    download_source -dependency $PROG $PROG $pver
    patch_source patches-`echo $pver | cut -d. -f1-2`
    if ((EXTRACT_MODE == 0)); then
        build
        tests
    fi
done
restore_variables BUILDDIR EXTRACTED_SRC

note -n "Building current version: $VER"
download_source $PROG $PROG $VER
patch_source
build
tests
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
