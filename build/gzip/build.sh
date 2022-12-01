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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=gzip
VER=1.12
PKG=compress/gzip
SUMMARY="GNU zip"
DESC="The GNU Zip (gzip) compression utility"

set_arch 64
CONFIGURE_OPTS="
    --infodir=/usr/share/info
"

# /usr/bin/uncompress is a hardlink to gunzip but is also delivered by
# system/extended-system-utilities. We therefore need to drop the version
# delivered with gzip but since it's a hardlink it is sometimes identified as
# a 'file' action and sometimes as 'hardlink'. Specify that gunzip should
# always be the target allowing uncompress to be dropped in local.mog
HARDLINK_TARGETS=usr/bin/gunzip

# OmniOS renames the z* utilities to gz* so we have to update the docs
rename_in_docs() {
    logmsg "Renaming z->gz references in documentation"
    pushd $TMPDIR/$BUILDDIR > /dev/null
    for file in *.1 z*.in; do
        logcmd sed -i -f $SRCDIR/renaming.sed $file
    done
    popd > /dev/null
}

init
download_source $PROG $PROG $VER
patch_source
rename_in_docs
prep_build autoconf -oot
build -multi
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
