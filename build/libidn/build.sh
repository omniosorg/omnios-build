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
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=libidn
VER=1.43
PKG=library/libidn
SUMMARY="The Internationalized Domains Library"
DESC="IDN - The Internationalized Domains Library"

# The library major version changed from 11 to 12 with 1.35. We need to
# continue shipping the older version of the library to support anything
# linked against it.
PVERS="1.34"

CONFIGURE_OPTS="--disable-static"
MAKE_ARGS="MAKEINFO=/usr/bin/true"
MAKE_INSTALL_ARGS="$MAKE_ARGS"

set_standard XPG6

# The build generates a .png file using `dot` from graphviz. We don't ship
# this but it's easier to let it generate than manage the required patches to
# the build files.
PATH+=:$OOCEBIN

init
prep_build

# Build previous versions

# Skip previous versions for cross compilation
pre_build() { ! cross_arch $1; }

save_variables BUILDDIR EXTRACTED_SRC
for pver in $PVERS; do
    note -n "Building previous version: $pver"
    set_builddir $PROG-$pver
    download_source $PROG $PROG $pver
    patch_source
    build
done
restore_variables BUILDDIR EXTRACTED_SRC
unset -f pre_build

note -n "Building current version: $VER"
download_source $PROG $PROG $VER
patch_source
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
