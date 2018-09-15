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

# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=cpuid
VER=1.7.1
VERHUMAN=$VER
PKG=system/cpuid
SUMMARY="A simple CPUID decoder/dumper for x86/x86_64"
DESC="A program which can dump and extract information from the x86 CPUID instruction"

set_arch 64

# No configure
configure64() { :; }

# cpuid uses lower case $prefix
MAKE_INSTALL_ARGS="prefix=$PREFIX"

init
download_source $PROG $VER
patch_source
prep_build
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
