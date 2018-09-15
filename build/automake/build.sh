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
# Copyright 2011-2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=automake
VER=1.16.1
VERHUMAN=$VER
PKG=developer/build/automake
SUMMARY="GNU Automake"
DESC="GNU Automake - A Makefile generator"

BUILD_DEPENDS_IPS="compress/xz developer/build/autoconf"
RUN_DEPENDS_IPS="developer/macro/gnu-m4 runtime/perl"
HARDLINK_TARGETS="usr/bin/aclocal usr/bin/automake"

set_arch 32

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
PATH=/usr/gnu/bin:$PATH run_testsuite check
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
