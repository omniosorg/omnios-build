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
# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#

. ../../lib/functions.sh

PROG=devpro-libmtsk
VER=20060131
PKG=system/library/mtsk
VER=0.5.11
SUMMARY="Microtasking Libraries"
DESC="$SUMMARY"

build() {
    mkdir -p $DESTDIR/lib/amd64 || logerr "mkdir failed"
    rsync -a $SRCDIR/files/lib/ $DESTDIR/lib/
}

init
prep_build
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
