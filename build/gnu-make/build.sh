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

PROG=make
VER=4.2.1
VERHUMAN=$VER
PKG=developer/build/gnu-make
SUMMARY="gmake - GNU make"
DESC="GNU make - A utility used to build software"

RUN_DEPENDS_IPS="system/prerequisite/gnu"

set_arch 64
CONFIGURE_OPTS="--program-prefix=g"

TESTSUITE_SED="
    /-srcdir/d
    /Making /d
    /on SunOS/d
    /getloadavg/d
    /getlogin_r/d
    /load average/d
    /1-minute/d
    /~~~~~~~~~/d
"

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi      # As Makefile.am has been modified
prep_build
build
run_testsuite check
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
