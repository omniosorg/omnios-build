#!/usr/bin/bash
#
# {{{ CDDL HEADER START
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source.  A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#
# CDDL HEADER END }}}
#
# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=dhcp
VER=4.4.1
VERHUMAN=$VER
PKG=network/service/isc-dhcp
SUMMARY="ISC DHCP"
DESC="$SUMMARY $VER"

DEPENDS_IPS="system/library"

set_arch 64

# Doesn't work with parallel gmake
NO_PARALLEL_MAKE=1

# This exposes msghdr.msg_control & msghdr.msg_controllen
CFLAGS+=" -D_XPG4_2 -fstack-check"
LDFLAGS="-zaslr"

CONFIGURE_OPTS="
    --enable-use-sockets
    --enable-ipv4-pktinfo
"

# With the move of inet_aton and friends from libnsl to libc, configure
# no longer detects that -lnsl is required; however it is still required for
# gethostbyaddr() amongst others.
CONFIGURE_OPTS+=" ac_cv_search_inet_aton=-lnsl "

pre_package() {
    # Make empty lease files. They get preserve=true in local.mog.
    logcmd mkdir -p $DESTDIR/var/db || logerr "mkdir of $DESTDIR/var/db failed"
    logcmd touch $DESTDIR/var/db/dhcpd.leases
    logcmd touch $DESTDIR/var/db/dhcpd6.leases
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
install_smf network isc-dhcp.xml dhcrelay
pre_package
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
