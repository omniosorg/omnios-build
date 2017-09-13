#!/usr/bin/bash
#
# CDDL HEADER START
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
# CDDL HEADER END
#
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2017 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh
. $SRCDIR/common.sh

PROG=libstdc++
VER=$GCCVER
VERHUMAN=$VER
PKG=system/library/g++-5-runtime
SUMMARY="g++ runtime dependencies libstc++/libssp"
DESC="$SUMMARY"

LOGFILE+=".$PROG"

BUILD_DEPENDS_IPS="$PKGV"

DEPENDS_IPS="system/library/gcc-$GCCMAJOR-runtime"

# This stuff is in its own domain
PKGPREFIX=""

PREFIX=$OPT

init
prep_build
mkdir -p $TMPDIR/$BUILDDIR
for license in COPYING.RUNTIME COPYING.LIB COPYING3.LIB
do
    logcmd cp $SRCDIR/files/$license $TMPDIR/$BUILDDIR/$license || \
        logerr "Cannot copy licence: $license"
done

mkdir -p $DESTDIR/usr/lib
mkdir -p $DESTDIR/usr/lib/amd64

##################################################################
LIB=libstdc++.so
LIBVER=6.0.21
XFORM_ARGS+=" -DSTDCVER=$LIBVER"

# Copy in legacy library versions

for v in 6.0.13 6.0.16 6.0.17 6.0.18; do
	if [ -f /usr/lib/$LIB.$v ]; then
		cp /usr/lib/$LIB.$v $DESTDIR/usr/lib/$LIB.$v
	else
		logerr "/usr/lib/libstdc++.so.$v not found"
	fi

	if [ -f /usr/lib/amd64/$LIB.$v ]; then
		cp /usr/lib/amd64/$LIB.$v $DESTDIR/usr/lib/amd64/$LIB.$v
	else
		logerr "/usr/lib/amd64/libstdc++.so.$v not found"
	fi
done

# and current version
cp $OPT/lib/$LIB.$LIBVER $DESTDIR/usr/lib/$LIB.$LIBVER \
    || logerr "Failed to copy $LIBVER"
cp $OPT/lib/amd64/$LIB.$LIBVER $DESTDIR/usr/lib/amd64/$LIB.$LIBVER \
    || logerr "Failed to copy $LIBVER (amd64)"

##################################################################
LIB=libssp.so
LIBVER=0.0.0
cp $OPT/lib/$LIB.$LIBVER $DESTDIR/usr/lib/$LIB.$LIBVER.gcc$GCCMAJOR
cp $OPT/lib/amd64/$LIB.$LIBVER $DESTDIR/usr/lib/amd64/$LIB.$LIBVER.gcc$GCCMAJOR

make_package runtime++.mog depends.mog
clean_up

