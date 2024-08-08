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
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=readline
VER=8.2.13
PKG=library/readline
SUMMARY="GNU readline"
DESC="GNU readline library"

# Previous versions that also need to be built and packaged since compiled
# software may depend on it.
PVERS="6.3 7.0"

# Needed for X/Open curses/termcap
set_standard -xcurses XPG6

CONFIGURE_OPTS="--disable-static"
LDFLAGS+=" $SSPFLAGS"

init
prep_build

# Build previous versions

# Skip previous versions for cross compilation
pre_build() { ! cross_arch $1; }

save_variables BUILDDIR EXTRACTED_SRC
for pver in $PVERS; do
    [ -z "$FLAVOR" -o "$FLAVOR" = $pver ] || continue
    note -n "Building previous version: $pver"
    set_builddir $PROG-$pver
    download_source -dependency $PROG $PROG $pver
    patch_source patches-${pver%%.*}
    ((EXTRACT_MODE == 0)) && build
done
restore_variables BUILDDIR EXTRACTED_SRC
unset -f pre_build

[ -z "$FLAVOR" -o "$FLAVOR" = $VER ] || exit 0

note -n "Building current version: $VER"
download_source $PROG $PROG $VER
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
