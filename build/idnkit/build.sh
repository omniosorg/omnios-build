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
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=idnkit
VER=2.3
PKG=library/idnkit
SUMMARY="Internationalized Domain Name kit (idnkit/JPNIC)"
DESC="Internationalized Domain Name kit (idnkit/JPNIC)"

CONFIGURE_OPTS="--disable-static --mandir=/usr/share/man"
LIBTOOL_NOSTDLIB=libtool
LIBTOOL_NOSTDLIB_EXTRAS="-lc -lssp_ns"

post_install() {
    typeset arch=$1

    # Include libraries from idnkit1
    ver=1.0.2
    case $arch in
        i386)
            for lib in idnkit idnkitlite; do
                logcmd cp /usr/lib/lib$lib.so.$ver $DESTDIR/usr/lib/
                logcmd ln -s lib$lib.so.$ver $DESTDIR/usr/lib/lib$lib.so.1
            done
            ;;
        amd64)
            for lib in idnkit idnkitlite; do
                logcmd cp /usr/lib/amd64/lib$lib.so.$ver $DESTDIR/usr/lib/amd64/
                logcmd ln -s lib$lib.so.$ver $DESTDIR/usr/lib/amd64/lib$lib.so.1
            done
            ;;
    esac

    [ $arch = i386 ] && return

    make_isa_stub

    manifest_start $TMPDIR/manifest.idnkit.bin
    manifest_add_dir $PREFIX/bin i386 amd64
    manifest_finalise $TMPDIR/manifest.idnkit.bin $PREFIX

    manifest_uniq $TMPDIR/manifest.idnkit{,.bin}
    manifest_finalise $TMPDIR/manifest.idnkit $PREFIX
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build

###########################################################################

make_package -seed $TMPDIR/manifest.idnkit

PKG=network/dns/idnconv
SUMMARY="Internationalized Domain Name Support Utilities"
DESC="Internationalized Domain Name Support Utilities"
[ "$FLAVOR" != libsandheaders ] \
    && make_package -seed $TMPDIR/manifest.idnkit.bin bin.mog

###########################################################################

clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
