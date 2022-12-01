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

PROG=cdrtools
VER=3.01
PKG=media/cdrtools
SUMMARY="CD creation utilities"
DESC="$SUMMARY"

set_arch 32
objdir=i386-sunos5-gcc32

make_clean() {
    logcmd ./.clean
}

# cdrtools doesn't use configure in the normal way, just make will invoke
# configure automatically.
configure_arch() { :; }

MAKE=dmake
MAKE_ARGS="CCOM=gcc32"
MAKE_ARGS_WS="
    COPTX=\"$CTF_CFLAGS $SSPFLAGS\"
    LDOPTX=\"$CTF_CFLAGS $SSPFLAGS\"
"
MAKE_INSTALL_ARGS="$MAKE_ARGS"

make_install() {
    pushd $DESTDIR >/dev/null

    logcmd mkdir -p etc/security/exec_attr.d
    logcmd mkdir -p usr/bin
    logcmd mkdir -p usr/share/man/man1
    logcmd mkdir -p usr/share/man/man8

    logcmd cp $SRCDIR/files/exec_attr etc/security/exec_attr.d/cdrecord

    logcmd cp $TMPDIR/$BUILDDIR/mkisofs/OBJ/$objdir/mkisofs \
        usr/bin/mkisofs || logerr "install mkisofs failed"
    logcmd cp $TMPDIR/$BUILDDIR/mkisofs/mkisofs.8 usr/share/man/man8/mkisofs.8 \
        || logerr "install mkisofs.8 failed"

    for cmd in cdda2wav cdrecord readcd ; do
        logcmd cp $SRCDIR/files/$cmd usr/bin/$cmd || logerr "cp $cmd failed"
        logcmd cp $TMPDIR/$BUILDDIR/$cmd/OBJ/$objdir/$cmd \
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

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
