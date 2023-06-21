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

# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=system
VER=0.5.11
PKG=system/defaults
SUMMARY="$DISTRO default system parameters"
DESC="$SUMMARY"

pre_build() {
    make_install_$1
    false
}

make_install() {
    logmsg "Generating system file"

    logcmd mkdir -p $DESTDIR/etc/system.d/ || logerr "mkdir failed"
    # Begin the file with an underscore so that it does not take
    # precedence over fragments delivered by packages or added by
    # a system administrator.
    logcmd cp $SRCDIR/files/system \
        $DESTDIR/etc/system.d/_omnios:system:defaults \
        || logerr "copy failed"
    ((EXTRACT_MODE)) && exit
}

init
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
