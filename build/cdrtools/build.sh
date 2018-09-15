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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=cdrtools
VER=3.01
VERHUMAN=$VER
PKG=media/cdrtools
SUMMARY="CD creation utilities"
DESC="$SUMMARY"

DEPENDS_IPS="system/library system/library/gcc-runtime"

export MAKE=/usr/bin/make

set_arch 32

make_clean() {
    logcmd ./.clean
}

# cdrtools doesn't use configure in the normal way, just make will invoke
# configure automatically.
configure32() {
    export CC
    MAKE_ARGS="CC=$CC"
}

make_install() {
    pushd $DESTDIR >/dev/null

    logcmd mkdir -p etc/security/exec_attr.d
    logcmd mkdir -p usr/bin
    logcmd mkdir -p usr/share/man/man1
    logcmd mkdir -p usr/share/man/man8

    logcmd cp $SRCDIR/files/exec_attr etc/security/exec_attr.d/cdrecord

    logcmd cp $TMPDIR/$BUILDDIR/mkisofs/OBJ/i386-sunos5-gcc/mkisofs \
        usr/bin/mkisofs || logerr "install mkisofs failed"
    logcmd cp $TMPDIR/$BUILDDIR/mkisofs/mkisofs.8 usr/share/man/man8/mkisofs.8 \
        || logerr "install mkisofs.8 failed"

    for cmd in cdda2wav cdrecord readcd ; do
        logcmd cp $SRCDIR/files/$cmd usr/bin/$cmd || logerr "cp $cmd failed"
        logcmd cp $TMPDIR/$BUILDDIR/$cmd/OBJ/i386-sunos5-gcc/$cmd \
            usr/bin/$cmd.bin || logerr "cp $cmd.bin failed"
        logcmd cp $TMPDIR/$BUILDDIR/$cmd/$cmd.1 usr/share/man/man1/$cmd.1 \
            || logerr "cp $cmd.1 failed"
    done

    popd >/dev/null
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
