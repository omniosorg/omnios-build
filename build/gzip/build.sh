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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=gzip
VER=1.9
VERHUMAN=$VER
PKG=compress/gzip
SUMMARY="The GNU Zip (gzip) compression utility"
DESC="$SUMMARY $VER"

set_arch 32
CONFIGURE_OPTS="
    --infodir=/usr/sfw/share/info
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
prep_build
build
run_testsuite check
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
