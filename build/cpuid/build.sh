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

# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=cpuid
VER=1.8.2
PKG=system/cpuid
SUMMARY="A simple CPUID decoder/dumper for x86/x86_64"
DESC="A program which can dump and extract information from the x86 "
DESC+="CPUID instruction"

set_arch 64

configure_amd64() {
    MAKE_ARGS_WS="CC=\"gcc -m64 $CFLAGS ${CFLAGS[amd64]}\""
    # cpuid uses lower case $prefix
    MAKE_INSTALL_ARGS_WS="$MAKE_ARGS_WS prefix=$PREFIX"
}

init
download_source $PROG $VER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
