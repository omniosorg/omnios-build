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

PROG=unzip
VER=6.0
PKG=compress/unzip
SUMMARY="The Info-Zip (unzip) compression utility"
DESC="$SUMMARY"

set_builddir "$PROG${VER//./}"
set_arch 64

HARDLINK_TARGETS="
    usr/bin/unzip
"
SKIP_LICENCES="*"

# Copied from upstream's pkg makefile
export LOCAL_UNZIP="-DUNICODE_SUPPORT -DNO_WORKING_ISPRINT -DUNICODE_WCHAR"

configure_amd64() {
    export i386
    MAKE_ARGS_WS="
        CC=\"gcc $CFLAGS ${CFLAGS[amd64]}\"
    "
}

BASE_MAKE_ARGS="-f unix/Makefile"
MAKE_ARGS="$BASE_MAKE_ARGS generic IZ_BZIP2=bzip2"
MAKE_INSTALL_ARGS="$BASE_MAKE_ARGS install"

init
download_source $PROG $PROG${VER//./}
patch_source
prep_build
MAKE_INSTALL_ARGS+=" prefix=$DESTDIR$PREFIX"
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
