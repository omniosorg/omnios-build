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

# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=lz4
PKG=compress/lz4
VER=1.10.0
SUMMARY="LZ4"
DESC="Extremely fast compression"

# we build/ship 32 and 64-bit libraries but only 64-bit binaries
pre_configure() {
    typeset arch=$1

    MAKE_ARGS_WS="
        CFLAGS=\"$CFLAGS ${CFLAGS[$arch]}\"
        LDFLAGS=\"$LDFLAGS ${LDFLAGS[$arch]}\"
    "

    # No configure
    false
}

pre_install() {
    typeset arch=${1:?arch}

    save_variable MAKE_INSTALL_ARGS
    case $arch in
        i386)
            MAKE_INSTALL_ARGS+=" LIBDIR=$PREFIX/lib BINDIR=$PREFIX/bin/i386"
            ;;
        amd64)
            MAKE_INSTALL_ARGS+=" LIBDIR=$PREFIX/lib/$arch"
            ;;
        *)
            MAKE_INSTALL_ARGS+=" LIBDIR=$PREFIX/lib"
            ;;
    esac
}

post_install() {
    restore_variable MAKE_INSTALL_ARGS
}

MAKE_INSTALL_ARGS="
    INSTALL=$GNUBIN/install
    PREFIX=$PREFIX
"

MAKE_TESTSUITE_ARGS="$MAKE_INSTALL_ARGS -k"

TESTSUITE_SED="
    /Lorem ipsum/,/nemo doloremque/d
    s/[^[:print:]]//g
    s/  *$//
    /^make.* directory /d
    /^gcc/d
    /gnu\/bin\/make/d
    /ln -sf/d
    /^\+/d
    /^Read : /d
    /^Decompressed/d
    /Compressed .* bytes into .* bytes ==>/d
    /^Completed in/d
    s^[0-9][0-9]*\.[0-9]* MB/s^X MB/s^g
    /-rw-r/d
    /byte.*copied.*B\/s/d
    /LZ4 command line interface 64-bits/d
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
