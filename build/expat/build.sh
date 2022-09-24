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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=expat
VER=2.4.9
PKG=library/expat
SUMMARY="XML parser library"
DESC="Fast streaming XML parser written in C"

forgo_isaexec

CONFIGURE_OPTS="--disable-static"

TESTSUITE_SED="
    /^[^#]/d
"
PKGDIFF_HELPER="
    s:$PROG-2\.[0-9]\.[0-9]:$PROG-VERSION:
"

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf -oot
build -multi
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
