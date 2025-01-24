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

# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=lzlib
PKG=library/lzlib
VER=1.15
SUMMARY="Data compression library"
DESC="$SUMMARY providing in-memory LZMA (de-)compression functions"

CONFIGURE_OPTS="
    --disable-static
"

SKIP_LICENCES=lzlib

build_init() {
    for arch in $BUILDARCH; do
        CONFIGURE_OPTS[${arch}_WS]="
            CC=\"$CC\"
            CPPFLAGS=\"$CPPFLAGS ${CPPFLAGS[$arch]}\"
            CFLAGS=\"$CFLAGS ${CFLAGS[$arch]}\"
            LDFLAGS=\"$LDFLAGS ${LDFLAGS[$arch]}\"
        "
    done
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
