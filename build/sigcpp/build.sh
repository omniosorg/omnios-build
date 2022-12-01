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

# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=libsigc++
VER=3.2.0
PKG=library/c++/sigcpp
SUMMARY="$PROG"
DESC="A library that implements typesafe callback system for standard C++"

export MAKE
CONFIGURE_OPTS="--includedir=/usr/include"
LDFLAGS[i386]+=" -lssp_ns"

TESTSUITE_SED="
    s/  *[0-9]\.[0-9]*s$//
    s/  *$//
    /Full log written/d
"

init
download_source $PROG $PROG $VER
patch_source
prep_build meson
build -noctf    # C++
run_testsuite
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
