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

# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=brotli
VER=1.0.9
PKG=compress/brotli
SUMMARY="Brotli compress"
DESC="Brotli is a generic-purpose lossless compression algorithm"

BUILD_DEPENDS_IPS="
    ooce/developer/cmake
"

XFORM_ARGS+=" -DPREFIX=${PREFIX#/}"

CONFIGURE_OPTS="
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DCMAKE_VERBOSE_MAKEFILE=1
"
CONFIGURE_OPTS[i386]=
CONFIGURE_OPTS[amd64]="
    -DCMAKE_INSTALL_LIBDIR=lib/amd64
    -DCMAKE_LIBRARY_ARCHITECTURE=amd64
"

post_install() {
    # Install man pages. There does not seem to be an install target for this.
    for s in 1 3; do
        logcmd mkdir -p $DESTDIR/$PREFIX/share/man/man$s || logerr "mkdir"
        logcmd cp $TMPDIR/$EXTRACTED_SRC/docs/*.$s \
            $DESTDIR/$PREFIX/share/man/man$s/ \
            || logerr "cp section $s man pages"
    done
}

init
download_source $PROG v$VER
patch_source
prep_build cmake
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
