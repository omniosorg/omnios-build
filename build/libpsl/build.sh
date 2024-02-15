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
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=libpsl
VER=0.21.5
PKG=library/libpsl
SUMMARY="C library for the Public Suffix List"
DESC="Library for access to the collection of TLD suffixes"

CONFIGURE_OPTS+="
    --disable-static
    --disable-runtime
    --enable-builtin
"

forgo_isaexec

export MAKE

TESTSUITE_SED="
    /^libtool:/d
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
