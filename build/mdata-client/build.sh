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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=mdata-client
VER=20170105
VERHUMAN=$VER
PKG=system/management/mdata-client
SUMMARY="Cross-platform metadata client tools for use in SDC guests (both Zones and KVM)"
DESC="Metadata retrieval and manipulation tools for use within guests of the SmartOS (and SDC) hypervisor. These guests may be either SmartOS Zones or KVM virtual machines."

set_arch 32

# There is no configure step here
CONFIGURE_CMD=true

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
