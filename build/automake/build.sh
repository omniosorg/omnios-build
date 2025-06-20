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

# Copyright 2011-2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=automake
VER=1.18
PKG=developer/build/automake
SUMMARY="GNU Automake"
DESC="GNU Automake - A Makefile generator"

BUILD_DEPENDS_IPS="compress/xz developer/build/autoconf"
RUN_DEPENDS_IPS="developer/macro/gnu-m4 runtime/perl"
HARDLINK_TARGETS="usr/bin/aclocal usr/bin/automake"
MAKE_TESTSUITE_ARGS_WS="
    LEX=flex
    YACC=\"bison -y\"
"

set_arch 64

PKGDIFF_HELPER="
    s:$PROG-1\.[0-9][0-9]:${PROG}VER:
    s:aclocal-1\.[0-9][0-9]:${PROG}VER:
"

TESTSUITE_SED="
    /\/bash -n t\//d
    /\/bash -n contrib\/t\//d
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
PATH=$GNUBIN:$PATH run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
