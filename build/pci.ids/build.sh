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
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=pci.ids
PKG=system/pciutils/pci.ids
SUMMARY="Repository of all known IDs used in PCI devices"
DESC="Repository of all known IDs used in PCI devices: IDs of vendors, "
DESC+="devices, subsystems and device classes. It is used in various programs "
DESC+="(like pciutils) to display full human-readable names instead of "
DESC+="cryptic numeric codes."

# We require a built illumos tree alongside this. This is where our compat
# symlink will point, so we determine the package version from there.
FORMAT=2.2
PCIIDS=usr/src/data/hwdata/$PROG
check_for_prebuilt $PCIIDS
SNAPDATE=`$NAWK '
    $2 == "Version:" {
        gsub(/\./, "")
        print $3
    }' $PREBUILT_ILLUMOS/$PCIIDS`
VER=${FORMAT}.${SNAPDATE}
VERHUMAN="v$FORMAT snapshot from $SNAPDATE"

create_manifest()
{
    local mf=$1
    cat << EOM > $mf
set name=pkg.fmri \
 value=pkg://\$(PKGPUBLISHER)/system/pciutils/$PROG@$VER,\$(SUNOSVER)-\$(PVER)
set name=pkg.summary value="$SUMMARY"
set name=pkg.description value="$DESC"
set name=pkg.human-version value="$VER"
set name=publisher value=\$(PKGPUBEMAIL)

link path=usr/share/pci.ids target=hwdata/pci.ids

license ../../LICENSE license=CDDL
EOM
}

init
prep_build

manifest=$TMPDIR/$PKGE.p5m
create_manifest $manifest
publish_manifest $PKG $manifest
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
