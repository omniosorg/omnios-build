#!/usr/bin/bash
#
#  {{{ CDDL HEADER START
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#
# CDDL HEADER END  }}}
#
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=mpfr
VER=4.2.1
PKG=library/mpfr
SUMMARY="The GNU multiple-precision floating-point computation library"
DESC="$SUMMARY"

CONFIGURE_OPTS+=" --disable-static"
CONFIGURE_OPTS[i386]+=" --with-gmp-include=$PREFIX/include/gmp"
CONFIGURE_OPTS[amd64]+=" --with-gmp-include=$PREFIX/include/gmp"

build_init() {
    for arch in $CROSS_ARCH; do
        CONFIGURE_OPTS+="
            --with-gmp-include=${SYSROOT[$arch]}/$PREFIX/include/gmp
        "
    done
}

TESTSUITE_FILTER='^[A-Z#][A-Z ]'

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
