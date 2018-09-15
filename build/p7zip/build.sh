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
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=p7zip
VER=16.02
VERHUMAN=$VER
PKG=compress/p7zip
SUMMARY="The p7zip compression and archiving utility"
DESC="$SUMMARY"

SRCVER="${VER}_src_all"
BUILDDIR=${PROG}_${VER}
BUILDARCH=32

RUN_DEPENDS_IPS="
    system/library/g++-runtime
    system/library/gcc-runtime
    shell/bash
"

configure32() {
    DEST_HOME=$PREFIX
    DEST_SHARE_DOC=$DEST_HOME/share/doc/p7zip
    DEST_MAN=$DEST_HOME/share/man
    export DEST_HOME DEST_BIN DEST_SHARE DEST_SHARE_DOC DEST_MAN
}

make_prog() {
    [[ -n $NO_PARALLEL_MAKE ]] && MAKE_JOBS=""

    logmsg "Making 64 bit version"
    logcmd $MAKE $MAKE_JOBS OPTFLAGS="-D_LARGEFILE64_SOURCE -m64" all3 || \
        logerr "--- 64bit make failed"

    DEST_BIN=$DEST_HOME/bin/$ISAPART64
    DEST_SHARE=$DEST_HOME/lib/amd64
    export DEST_BIN DEST_SHARE
    logmsg "Installing 64 bit version"
    logcmd $MAKE $MAKE_JOBS OPTFLAGS="-D_LARGEFILE64_SOURCE -m64" \
        install DEST_DIR="$DESTDIR" || \
        logerr "--- 64bit make install failed"

    logmsg "--- make clean"
    logcmd $MAKE clean

    logmsg "Making 32 bit version"
    logmsg "--- make"
    logcmd $MAKE $MAKE_JOBS all3 || \
        logerr "--- Make failed"

    DEST_BIN=$DEST_HOME/bin/$ISAPART
    DEST_SHARE=$DEST_HOME/lib
    export DEST_BIN DEST_SHARE
    logmsg "Installing 32 bit version"
    logcmd $MAKE $MAKE_JOBS install DEST_DIR="$DESTDIR" || \
        logerr "--- 32bit make install failed"
}

build32() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building it all 32/64"
    export ISALIST="$ISAPART"
    make_clean
    configure32
    logcmd cp makefile.solaris_x86 makefile.machine
    make_prog32
    popd > /dev/null
    unset ISALIST
    export ISALIST
}

# Also include the shell wrapper for gzip-style compatibility
install_sh_wrapper() {
    pushd $TMPDIR/$BUILDDIR/contrib/gzip-like_CLI_wrapper_for_7z/ > /dev/null
    logmsg "Installing p7zip shell wrapper"
    logcmd cp p7zip $DESTDIR/usr/bin/ || \
        logerr "--- Failed: unable to copy p7zip script"
    logcmd cp man1/p7zip.1 $DESTDIR/$DEST_MAN/man1/ || \
        logerr "--- Failed: unable to copy p7zip man page"
    popd > /dev/null
}

init
download_source $PROG ${PROG}_${SRCVER}
patch_source
prep_build
build
run_testsuite test
install_sh_wrapper
make_isa_stub
make_package
chmod -R u+w $DESTDIR
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
