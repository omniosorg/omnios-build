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
# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=pci.ids
FORMAT=2.2

PCIIDS=usr/src/data/hwdata/$PROG
check_for_prebuilt $PCIIDS
logcmd cp $PREBUILT_ILLUMOS/$PCIIDS $SRCDIR/$PROG

SNAPDATE=`nawk '
    $2 == "Version:" {
        gsub(/\./, "")
        print $3
    }' $SRCDIR/$PROG`
VER=${FORMAT}.${SNAPDATE}
VERHUMAN="v$FORMAT snapshot from $SNAPDATE"
PKG=system/pciutils/pci.ids
SUMMARY="Repository of all known IDs used in PCI devices"
DESC="Repository of all known IDs used in PCI devices: IDs of vendors, devices, subsystems and device classes. It is used in various programs (like pciutils) to display full human-readable names instead of cryptic numeric codes."

BUILDARCH=32

# Nothing to configure or build, just package
make_install() {
    logmsg "--- make install"
    logcmd mkdir -p $DESTDIR$PREFIX/share || \
        logerr "------ Failed to create destination directory."
    logcmd cp -p ${PROG}.gz $DESTDIR$PREFIX/share/ || \
        logerr "------ Failed to copy file into place."
}
build32() {
    pushd $TMPDIR > /dev/null
    gzip -c $SRCDIR/$PROG > ${PROG}.gz
    make_install
    popd > /dev/null
}

init
prep_build
build
make_package
clean_up
logcmd rm -f $SRCDIR/$PROG

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
