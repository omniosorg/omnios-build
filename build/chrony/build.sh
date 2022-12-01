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

PROG=chrony
VER=4.3
PKG=service/network/chrony
SUMMARY="Network time services"
DESC="A versatile implementation of the Network Time Protocol (NTP)"
NETTLEVER=3.8.1

set_arch 64

XFORM_ARGS="
    -DPROG=$PROG
    -DNETTLEVER=$NETTLEVER
"

init
prep_build

#########################################################################
# Download and build a static version of nettle

save_buildenv

CONFIGURE_OPTS="--disable-shared"
CPPFLAGS="-I/usr/include/gmp"

build_dependency nettle nettle-$NETTLEVER \
    nettle nettle $NETTLEVER

restore_buildenv

CPPFLAGS="-I$DEPROOT$PREFIX/include"
LDFLAGS[amd64]+=" -L$DEPROOT$PREFIX/lib/amd64"
addpath PKG_CONFIG_PATH[amd64] $DEPROOT$PREFIX/lib/amd64/pkgconfig

#########################################################################

post_configure() {
    for flag in $EXPECTED_OPTIONS; do
        $EGREP -s "$flag 1" config.h || logerr "$flag not set"
    done
}

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --sysconfdir=/etc/inet
    --with-user=$PROG
    --enable-ntp-signd
"

TESTSUITE_FILTER="^Testing"

EXPECTED_OPTIONS="FEAT_READLINE FEAT_SECHASH FEAT_IPV6 FEAT_SIGND"

download_source $PROG $PROG $VER
patch_source
build
run_testsuite check
install_smf network chrony.xml
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
