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

# Copyright 2011-2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=perl
PKG=runtime/perl
VER=5.32.1
DASHREV=2
MAJVER=${VER%.*}
SUMMARY="Perl $MAJVER Programming Language"
DESC="A highly capable, feature-rich programming language"

set_arch 64
CTF_FLAGS+=" -s"

PREFIX=/usr/perl5/$MAJVER

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DPROG=$PROG
    -DVERSION=$MAJVER
"

HARDLINK_TARGETS="
    ${PREFIX#/}/bin/$PROG$VER
    ${PREFIX#/}/bin/${PROG}thanks
    ${PREFIX#/}/man/man1/${PROG}thanks.1
"

BUILD_DEPENDS_IPS="text/gnu-sed"

TESTSUITE_SED="
    /ExtUtils::Command/d
"

configure64() {
    logmsg "--- configure (64-bit)"
    logcmd $SHELL Configure \
        -des \
        -Dusethreads \
        -Duseshrplib \
        -Dusedtrace \
        -Dusemultiplicity \
        -Duselargefiles \
        -Duse64bitall \
        -Dmyhostname=localhost \
        -Umydomain \
        -Umyuname \
        -Dcf_by=omnios-builder \
        -Dcf_email=$PUBLISHER_EMAIL \
        -Dcc=gcc \
        -Dld=/usr/ccs/bin/ld \
        -Doptimize="-O3 $CTF_CFLAGS" \
        -Dprefix=${PREFIX} \
        -Dvendorprefix=${PREFIX} \
        -Dbin=${PREFIX}/bin \
        -Dsitebin=${PREFIX}/bin \
        -Dvendorbin=${PREFIX}/bin \
        -Dscriptdir=${PREFIX}/bin \
        -Dsitescript=${PREFIX}/bin \
        -Dvendorscript=${PREFIX}/bin \
        -Dprivlib=${PREFIX}/lib \
        -Dsitelib=/usr/perl5/site_perl/$MAJVER \
        -Dvendorlib=/usr/perl5/vendor_perl/$MAJVER \
        -Ulocincpth= \
        -Uloclibpth= \
        -Dlibpth="/lib/$ISAPART64 /usr/lib/$ISAPART64" \
        -Dlibs="-lsocket -lnsl -lm -lc" \
        || logerr "--- Configure failed"

    logcmd sed -i "
        s/mydomain=\"\.undef\"/mydomain=\"undef\"/g
        s!^libpth=.*!libpth=\"/lib/$ISAPART64 /usr/lib/$ISAPART64\"!g
    " config.sh
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
