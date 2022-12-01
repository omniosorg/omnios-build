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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=jexec
VER=0.5.11
PKG=runtime/java/jexec
SUMMARY="Java executable jar launcher"
DESC="Helper for the kernel's java exec handler"

set_arch 64

# This code is not complicated enough to trigger SSP
SKIP_SSP_CHECK=1

build_amd64() {
    mkdir -p $DESTDIR/$PREFIX/libexec/amd64
    logcmd $CC $CFLAGS ${CFLAGS[64]} \
        -o $DESTDIR/$PREFIX/libexec/amd64/$PROG \
        $SRCDIR/files/$PROG.c \
        || logerr "$PROG build failed"
}

init
prep_build
((EXTRACT_MODE)) && exit
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
