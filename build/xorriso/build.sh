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

# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=xorriso
VER=1.5.6.pl02
PKG=media/xorriso
SUMMARY="GNU xorriso"
DESC="$SUMMARY - ISO 9660 Rock Ridge Filesystem Manipulator"

set_arch 64
set_builddir $PROG-${VER/%.pl*}

XFORM_ARGS+=" -DPREFIX=${PREFIX#/}"

pre_build() {
    typeset arch=$1

    if cross_arch $arch; then
        set_patchdir patches.$arch
    else
        set_patchdir patches
    fi
    true
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
