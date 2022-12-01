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

PROG=lzlib
PKG=library/lzlib
VER=1.13
SUMMARY="Data compression library"
DESC="$SUMMARY providing in-memory LZMA (de-)compression functions"

CONFIGURE_OPTS="
    --disable-static
"

SKIP_LICENCES=lzlib

pre_build() {
    [ -z "$1" ] || return

    CONFIGURE_OPTS[i386_WS]="
        CC=\"$CC\"
        CPPFLAGS=\"$CPPFLAGS ${CPPFLAGS[i386]}\"
        CFLAGS=\"$CFLAGS ${CFLAGS[i386]}\"
        LDFLAGS=\"$LDFLAGS ${LDFLAGS[i386]}\"
    "
    CONFIGURE_OPTS[amd64_WS]="
        CC=\"$CC\"
        CPPFLAGS=\"$CPPFLAGS ${CPPFLAGS[amd64]}\"
        CFLAGS=\"$CFLAGS ${CFLAGS[amd64]}\"
        LDFLAGS=\"$LDFLAGS ${LDFLAGS[amd64]}\"
    "
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
