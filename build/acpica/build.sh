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

. ../../lib/functions.sh

PROG=acpica-unix
VER=20180810
VERHUMAN=$VER
PKG=developer/acpi/compiler
SUMMARY="ACPI Component Architecture compiler"
DESC="$SUMMARY"

BUILDARCH=32

extract_licence() {
    # Horrible - need to extract the licence from a source file.
    # We choose the BSD licence
    logmsg "-- extracting licence"
    sed -n < $TMPDIR/$BUILDDIR/source/compiler/aslmain.c \
        > $TMPDIR/$BUILDDIR/LICENCE '
        /Redistribution and use in source and binary/,/DAMAGE/p
    '
}

# No configure
configure32() {
    export CC=gcc
    export M4=gm4
}

make_prog32() {
    # Build expects m4 to be the GNU version
    PATH=/usr/gnu/bin:$PATH logcmd $MAKE CC=$CC iasl \
        || logerr "--- Build failed"
}

init
download_source acpica $PROG $VER
cp $SRCDIR/files/acsolaris.h $TMPDIR/$BUILDDIR/source/include/platform
patch_source
prep_build
build
extract_licence
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
