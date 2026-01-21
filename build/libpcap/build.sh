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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=libpcap
VER=1.10.6
PKG=system/library/pcap
SUMMARY="libpcap - a packet capture library"
DESC="$SUMMARY"

CONFIGURE_OPTS="
    --mandir=/usr/share/man
    --with-pcap=dlpi
"

CFLAGS[aarch64]+=" -mtls-dialect=trad"
LDFLAGS+=" $SSPFLAGS"

build_init() {
    CPPFLAGS[aarch64]+=" -I${SYSROOT[aarch64]}/usr/include"
    LDFLAGS[aarch64]+=" -L${SYSROOT[aarch64]}/usr/lib"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
