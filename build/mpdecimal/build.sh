#!/usr/bin/bash

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

# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=mpdecimal
VER=4.0.1
PKG=library/mpdecimal
SUMMARY="Arbitrary precision decimal floating point library"
DESC="A complete implementation of the General Decimal Arithmetic Specification"

CONFIGURE_OPTS="
    --disable-cxx
    --disable-static
    --disable-doc
"

# The Makefile places LDFLAGS before the objects, so the archive has to be
# rescanned
LDFLAGS[i386]+=" -Wl,-z,rescan -lssp_ns"

TESTSUITE_SED="
    /URL:https:\/\//d
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
