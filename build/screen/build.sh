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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=screen
VER=4.9.1
PKG=terminal/screen
SUMMARY="GNU Screen terminal multiplexer"
DESC="A full-screen window manager that multiplexes a physical "
DESC+="terminal between several processes"

set_arch 64
# msg_controllen member of struct msghdr
set_standard XPG4v2

CONFIGURE_OPTS_WS="
    --with-sys-screenrc=/etc/screenrc
    --enable-colors256
    LDFLAGS=\"-m64 -lxnet\"
"

save_function make_install make_install_orig
make_install() {
    make_install_orig
    logmsg "Installing /etc/screenrc"
    logcmd mkdir $DESTDIR/etc || logerr "-- Failed to mkdir $DESTDIR/etc"
    sed '
        # Remove header that says it is an example that should be installed
        # in /etc
        1,/^$/ {
            /^#/d
        }
        /^#autodetach off/c\
autodetach on\
defscrollback 1000
        /^#startup_message off/s/#//
    ' < etc/etcscreenrc > $DESTDIR/etc/screenrc
}

tests() {
    curses=`ldd $DESTDIR/$PREFIX/bin/screen | nawk '/curses/ { print $1}'`
    [ "$curses" = "libncurses.so.6" ] || \
        logerr "Wrong curses version linked ($curses)"
}

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
prep_build
build
tests
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
