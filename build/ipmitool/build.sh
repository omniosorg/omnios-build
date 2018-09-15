#!/usr/bin/bash
#
# {{{ CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END }}}
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=ipmitool
VER=1.8.18
VERHUMAN=$VER
PKG=system/management/ipmitool
SUMMARY="IPMI management tool"
DESC="A utility for managing and configuring devices that support the "
DESC+="Intelligent Platform Management Interface"

BUILD_DEPENDS_IPS="driver/ipmi developer/build/libtool"

set_arch 32
CONFIGURE_OPTS_32+=" --bindir=/usr/sbin --sbindir=/usr/lib"
CONFIGURE_OPTS+="
    --mandir=/usr/share/man
    --enable-intf-free=yes
    --enable-intf-usb=no
    --enable-solaris-opt
"

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
prep_build
run_autoconf
build
install_smf network ipmievd.xml svc-ipmievd
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
