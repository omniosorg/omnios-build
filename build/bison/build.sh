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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=bison
VER=3.8.2
PKG=developer/parser/bison
SUMMARY="General-purpose parser generator"
DESC="A general-purpose parser generator that converts an annotated "
DESC+="context-free grammar into a deterministic or generalised parser"

set_arch 64
set_standard XPG6

CONFIGURE_OPTS="--disable-yacc"
export M4=/usr/bin/gm4

TESTSUITE_SED="
    /^gmake/d
    /CXX/d
    /CC/d
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
PATH=$GNUBIN:$OOCEBIN:$PATH run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
