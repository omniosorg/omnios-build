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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=mpfr
VER=4.0.1
VERHUMAN=$VER
PKG=library/mpfr
SUMMARY="The GNU multiple-precision floating-point computation library"
DESC="$SUMMARY"

CONFIGURE_OPTS+="
    --with-gmp-include=$PREFIX/include/gmp
"

# As of MPFR 4.0.0, the configure script detects libquadmath and then tries
# to link it against testcases. We don't have libquadmath...
export ac_cv_lib_quadmath_main=no

TESTSUITE_FILTER='^[A-Z#][A-Z ]'

init
download_source $PROG $PROG $VER
prep_build
build
run_testsuite check
make_isa_stub
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
