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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=lzip
VER=1.23
PKG=compress/lzip
SUMMARY="Lzip"
DESC="Lossless data compressor"

set_arch 64

# XXX - this is too early for many of these options, is it needed?
#CONFIGURE_OPTS[amd64_WS]="
#    CXX=\"$CXX\"
#    CPPFLAGS=\"$CPPFLAGS $CPPFLAGS64\"
#    CXXFLAGS=\"$CXXFLAGS $CXXFLAGS64\"
#    LDFLAGS=\"$LDFLAGS $LDFLAGS[amd64]\"
#"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build -noctf # C++
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
