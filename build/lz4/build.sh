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

# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=lz4
PKG=compress/lz4
VER=1.9.4
SUMMARY="LZ4"
DESC="Extremely fast compression"

# we build/ship 32 and 64-bit libraries but only 64-bit binaries
configure_i386() {
    MAKE_ARGS_WS="
        CFLAGS=\"$CFLAGS ${CFLAGS[i386]}\"
        LDFLAGS=\"$LDFLAGS ${LDFLAGS[i386]}\"
    "
}

configure_amd64() {
    MAKE_ARGS_WS="
        CFLAGS=\"$CFLAGS ${CFLAGS[amd64]}\"
        LDFLAGS=\"$LDFLAGS ${LDFLAGS[amd64]}\"
    "
}

MAKE_INSTALL_ARGS="
    INSTALL=$GNUBIN/install
    PREFIX=$PREFIX
"
MAKE_INSTALL_ARGS_32="LIBDIR=$PREFIX/lib BINDIR=$PREFIX/bin/i386"
MAKE_INSTALL_ARGS_64="LIBDIR=$PREFIX/lib/amd64"

MAKE_TESTSUITE_ARGS="$MAKE_INSTALL_ARGS -k"

TESTSUITE_SED="
    s/[^[:print:]]//g
    /ln -sf/d
    /^Read : /d
    /^Decompressed/d
    /Compressed .* bytes into .* bytes ==>/d
    /^Completed in/d
    /^gmake.* directory /d
    /^gcc/d
    s^[0-9][0-9]*\.[0-9]* MB/s^X MB/s^g
    /-rw-r/d
    /byte.*copied.*B\/s/d
    /LZ4 command line interface 64-bits/d
    s/  *$//
    /[Aa]ll tests completed/d
    /^Seed =/d
    s/[0-9][0-9]* bytes/X bytes/g
    /ratio[ :].*%$/d
    /^[0-9][0-9][0-9][0-9]\/[0-9][0-9]\/[0-9][0-9] [0-9][0-9]:[0-9][0-9]:/d
    /^Ran [0-9][0-9]* tests in/d
"

init
download_source $PROG "v$VER"
patch_source
prep_build
build
PATH=$GNUBIN:$PATH run_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
