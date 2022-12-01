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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=ipmitool
VER=1.8.19
PKG=system/management/ipmitool
SUMMARY="IPMI management tool"
DESC="A utility for managing and configuring devices that support the "
DESC+="Intelligent Platform Management Interface"

BUILD_DEPENDS_IPS="driver/ipmi developer/build/libtool"

set_arch 64

set_builddir $PROG-${PROG^^}_${VER//./_}

CONFIGURE_OPTS[amd64]+=" --bindir=/usr/sbin --sbindir=/usr/lib"
CONFIGURE_OPTS+="
    --mandir=/usr/share/man
    --enable-intf-free=yes
    --enable-intf-usb=no
    --enable-solaris-opt
"

init
download_source $PROG ${PROG^^}_${VER//./_}
patch_source
run_autoreconf -fi
prep_build
build
install_smf network ipmievd.xml svc-ipmievd
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
