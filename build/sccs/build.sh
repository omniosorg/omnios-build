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

# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=sccs
VER=5.09
DASHREV=1
PKG=developer/versioning/sccs
SUMMARY="Source Code Control System (SCCS)"
DESC="The POSIX standard Source Code Control System (SCCS)"

set_arch 32
MAKE=dmake
NO_PARALLEL_MAKE=1

HARDLINK_TARGETS="
    usr/ccs/bin/cdc
    usr/ccs/bin/sact
"

# sccs uses the schily build environment so neither the clean nor configure
# step are required.
make_clean() { :; }
configure_arch() { :; }

MAKE="dmake"
MAKE_ARGS="CCOM=gcc32"
MAKE_ARGS_WS="
    COPTX=\"$CTF_CFLAGS $SSPFLAGS -fpermissive\"
    LDOPTX=\"$CTF_CFLAGS $SSPFLAGS -fpermissive\"
"
MAKE_INSTALL_ARGS="$MAKE_ARGS"

run_test() {
    $EGREP -s '#[[:space:]]*define[[:space:]]*SIZEOF_INT[[:space:]]*4$' \
        $TMPDIR/$BUILDDIR/include/schily/xmconfig.h \
        || logerr "Configure failed to detect type sizes"
}

init
prep_build
download_source $PROG $PROG $VER
patch_source
build
run_test
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
