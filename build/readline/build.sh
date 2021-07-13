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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=readline
VER=8.1
PATCHLEVEL=1
PKG=library/readline
SUMMARY="GNU readline"
DESC="GNU readline library"

# Previous versions that also need to be built and packaged since compiled
# software may depend on it.
PVERS="6.3 7.0"

CONFIGURE_OPTS="--disable-static"
LDFLAGS+=" $SSPFLAGS"

init
prep_build

# Build previous versions
save_variables BUILDDIR EXTRACTED_SRC
for pver in $PVERS; do
    note -n "Building previous version: $pver"
    set_builddir $PROG-$pver
    download_source $PROG $PROG $pver
    patch_source patches-${pver%%.*}
    build
done
restore_variables BUILDDIR EXTRACTED_SRC

note -n "Building current version: $VER"
download_source $PROG $PROG $VER
patch_source
build
[ -n "$PATCHLEVEL" ] && VER+=".$PATCHLEVEL"
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
