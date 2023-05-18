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
# Copyright 2011-2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=gawk
VER=5.2.2
PKG=text/gawk
SUMMARY="GNU awk"
DESC="gawk - GNU implementation of awk"

RUN_DEPENDS_IPS="system/prerequisite/gnu"

set_arch 64
set_standard XPG6

CPPFLAGS[amd64]+=" -I/usr/include/gmp"

HARDLINK_TARGETS=usr/bin/gawk

build_init() {
    for arch in $CROSS_ARCH; do
        CPPFLAGS[$arch]+=" -I${SYSROOT[$arch]}/$PREFIX/include/gmp"
    done
}

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
