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

PROG=xterm
VER=352
PKG=terminal/resize
SUMMARY="resize - adjust terminal settings to current window size"
DESC="Set environment and terminal settings to current window size"

SKIP_LICENCES=xterm

set_arch 64

build() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building 64-bit"

    CPPFLAGS+=" -I."
    CPPFLAGS+=" -I$TMPDIR/openwin/X11/include"

    logcmd $GCC $CFLAGS ${CFLAGS[amd64]} $CPPFLAGS \
        -o resize resize.c version.c xstrings.c -lncurses \
        || logerr "build failed"

    logcmd mkdir -p $DESTDIR/$PREFIX/bin || logerr "mkdir bin"
    logcmd mkdir -p $DESTDIR/$PREFIX/share/man/man1 || logerr "mkdir man"
    logcmd cp resize $DESTDIR/$PREFIX/bin/ || logerr "copy into bin"
    sed < resize.man > $DESTDIR/$PREFIX/share/man/man1/resize.1 "
            s/__app_version__/$VER/g
        " || logerr "copy resize.man"

    popd > /dev/null
}

init
prep_build
download_source $PROG $PROG $VER
BUILDDIR=openwin download_source Xstuff openwin
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
