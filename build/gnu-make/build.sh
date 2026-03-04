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

# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=make
VER=4.4.1
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

post_install() {
    pushd $TMPDIR >/dev/null
    env - $DESTDIR/$PREFIX/bin/gmake -p 2>/dev/null \
        | $EGREP '^(CC|CXX)' | $EGREP / \
        && logerr "CC or CXX contains an absolute path"
    popd >/dev/null
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
