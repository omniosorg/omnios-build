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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=tuntap
VER=1.3.3
PKG=driver/tuntap
SUMMARY="TUN/TAP driver for $DISTRO"
DESC="TUN/TAP driver for $DISTRO based on the Universal TUN/TAP Driver"

set_arch 64

# Ensure that the standard function prologue remains at the very start of a
# function, so DTrace fbt will instrument the right place.
CFLAGS+=" -fno-shrink-wrap"

# Build the kernel module with retpolines and other settings that are used in
# illumos-omnios
CFLAGS+=" -ffreestanding -mcmodel=kernel"
CFLAGS+=" -mno-mmx -mno-sse -mno-red-zone"
CFLAGS+=" -mindirect-branch=thunk-extern"
CFLAGS+=" -mindirect-branch-register"

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
