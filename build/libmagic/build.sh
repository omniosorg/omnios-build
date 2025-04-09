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
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=file
VER=5.46
PKG=library/libmagic
SUMMARY="File type guessing library"
DESC="Library for determining the type of data contained in a file"

forgo_isaexec

XFORM_ARGS+=" -DPREFIX=${PREFIX#/}"

CONFIGURE_OPTS="
    --disable-static
"

pre_build() {
    typeset arch=$1

    ! cross_arch $arch && return

    MAKE_ARGS+=" FILE_COMPILE=/usr/bin/ds-file"
}

post_install() {
    typeset arch=$1

    [ $arch = i386 ] && return

    manifest_start $TMPDIR/manifest.libmagic
    manifest_add_dir $PREFIX/lib pkgconfig $arch $arch/pkgconfig
    manifest_add_dir $PREFIX/include
    manifest_add_dir $PREFIX/share/misc
    manifest_add_dir $PREFIX/share/man man3 man4
    manifest_uniq $TMPDIR/manifest.{file,libmagic}
    manifest_finalise $TMPDIR/manifest.file $PREFIX
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build

make_package -seed $TMPDIR/manifest.libmagic

if [ "$FLAVOR" != libsandheaders ]; then
    PKG=system/file
    SUMMARY="Darwinsys file - a file type guesser"
    DESC=${DESC/Library/Command-line utility}
    make_package -seed $TMPDIR/manifest.file file.mog
fi

clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
