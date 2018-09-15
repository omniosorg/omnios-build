#!/usr/bin/bash
#
# {{{ CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END }}}
#
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=screen
VER=4.6.2
PKG=terminal/screen
SUMMARY="GNU Screen terminal multiplexer"
DESC="$SUMMARY"

set_arch 32
CONFIGURE_OPTS="
	--with-sys-screenrc=/etc/screenrc
	--enable-colors256
	LDFLAGS=-lxnet
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
prep_build
build
tests
strip_install
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
