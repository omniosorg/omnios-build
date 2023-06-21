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

# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=notices
VER=0.5.11
PKG=release/notices
SUMMARY="$DISTRO licensing information"
DESC="$DISTRO /etc/notices files"

set_arch 64

pre_build() {
    make_install_$1
    # Override default build
    false
}

make_install() {
    logmsg "Generating notice files"

    pushd $DESTDIR >/dev/null

    logcmd mkdir -p etc/notices || logerr "-- mkdir failed"
    sed < $SRCDIR/files/COPYRIGHT > etc/notices/COPYRIGHT "
        s~@@COPYRIGHT@@~`copyright_string`~
    "

    popd >/dev/null
}

init
prep_build
build
make_package notices.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
