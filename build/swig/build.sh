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
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=swig
VER=4.4.1
PKG=developer/swig
SUMMARY="The Simplified Wrapper and Interface Generator (swig)"
DESC="A compiler that integrates C and C++ with languages including Perl, "
DESC+="Python, Tcl, Ruby, PHP, Java, C#, D, Go, Lua, Octave, R, "
DESC+="Scheme (Guile, MzScheme/Racket), Scilab, Ocaml."

set_arch 64

CONFIGURE_OPTS="--disable-ccache"

# SWIG supports a number of languages. Only test the ones shipped with core.
TEST_TARGETS="
    partialcheck-perl5-test-suite
    partialcheck-python-test-suite
"

PKGDIFF_HELPER="
    s:$PROG/[0-9]\.[0-9]\.[0-9]:$PROG/VERSION:
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite "$TEST_TARGETS"
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
