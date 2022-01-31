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
#
. ../../lib/functions.sh

PROG=expat
VER=2.4.4
PKG=library/expat
SUMMARY="XML parser library"
DESC="Fast streaming XML parser written in C"

CONFIGURE_OPTS_64+=" --includedir=/usr/include"

save_function make_clean _make_clean
make_clean() {
    # As of expat 2.2.4, distclean removes the generated xmlwf.1
    # man page too so that it is re-generated during build using
    # docbook2X. We don't have docbook2X so preserve the file.
    [ -f doc/xmlwf.1~ ] || cp doc/xmlwf.1 doc/xmlwf.1~
    _make_clean
    [ -f doc/xmlwf.1 ] || cp doc/xmlwf.1~ doc/xmlwf.1
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
