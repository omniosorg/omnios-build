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
#
. ../../lib/build.sh

PROG=libtool
VER=2.4.6
PKG=developer/build/libtool  ##IGNORE##
SUMMARY="unused; replaced below"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="autoconf automake"

# The "binaries" here are just shell scripts so arch doesn't matter
# The includes also are not arch-dependent
CONFIGURE_OPTS="
    --bindir=$PREFIX/bin
    --includedir=$PREFIX/include
    --disable-static
"

# The libltdl library encodes a search path for library files that is correct
# for 32-bit processes, but needs to be amended for 64-bit processes so that it
# matches the system default.
CONFIGURE_OPTS[amd64]+="
    LT_SYS_LIBRARY_PATH=/lib/amd64:/usr/lib/amd64
"

build_manifests() {
    manifest_start $TMPDIR/manifest.libltdl
    manifest_add_dir $PREFIX/lib amd64
    manifest_finalise $TMPDIR/manifest.libltdl $PREFIX
    manifest_uniq $TMPDIR/manifest.{libtool,libltdl}
    manifest_finalise $TMPDIR/manifest.libtool $PREFIX
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
build_manifests

PKG=developer/build/libtool
SUMMARY="GNU libtool utility"
DESC="GNU libtool - library support utility"
make_package -seed $TMPDIR/manifest.libtool libtool.mog

PKG=library/libtool/libltdl
SUMMARY="GNU libtool dlopen wrapper"
DESC="GNU libtool dlopen wrapper - libltdl"
make_package -seed $TMPDIR/manifest.libltdl libltdl.mog

clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
