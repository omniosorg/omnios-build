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
#
. ../../lib/build.sh

PROG=tar
VER=1.34
PKG=archiver/gnu-tar
SUMMARY="gtar - GNU tar"
DESC="GNU tar - A utility used to store, backup, and transport files (gtar)"

RUN_DEPENDS_IPS="
    system/prerequisite/gnu
    system/extended-system-utilities
    compress/gzip
    compress/bzip2
    compress/xz
    compress/zstd
"

set_arch 64

CONFIGURE_OPTS="
    --program-prefix=g
    --with-rmt=/usr/sbin/rmt
    --with-zstd=/usr/bin/zstd
"
# The configure script checks to see if eaccess() is present in libgen and if
# so it links libgen into the final binary. However, we also have faccessat()
# and that is used in preference to eaccess(). libgen is therefore an
# unecessary library.
CONFIGURE_OPTS[WS]="ac_cv_search_eaccess=\"none required\""

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
