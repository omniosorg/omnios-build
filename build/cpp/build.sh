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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=cpp
VER=20220808
PKG=developer/macro/cpp
SUMMARY="The C Pre-Processor (cpp)"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="developer/parser/bison"
SKIP_LICENCES="*.licence"

# cpp does not work properly when built 64-bit
set_arch 32

configure_i386() {
    export CFLAGS+=" $CFLAGS32"
}

init
download_source cpp $VER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
