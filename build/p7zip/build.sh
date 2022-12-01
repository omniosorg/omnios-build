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

PROG=p7zip
VER=16.02
PKG=compress/p7zip
SUMMARY="The p7zip compression and archiving utility"
DESC="$SUMMARY"

SRCVER="${VER}_src_all"
set_builddir "${PROG}_${VER}"

forgo_isaexec

RUN_DEPENDS_IPS="
    system/library/g++-runtime
    system/library/gcc-runtime
    shell/bash
"

NO_SONAME_EXPECTED=1
SKIP_SSP_CHECK=1
SKIP_LICENCES=unRar

DEST_HOME=$PREFIX
DEST_SHARE_DOC=$DEST_HOME/share/doc/p7zip
DEST_MAN=$DEST_HOME/share/man
export DEST_HOME DEST_BIN DEST_SHARE DEST_SHARE_DOC DEST_MAN

MAKE_ARGS=all3

configure_i386() {
    logcmd cp makefile.solaris_x86 makefile.machine

    MAKE_ARGS_WS="OPTFLAGS=\"-D_LARGEFILE64_SOURCE ${CFLAGS[i386]} $CFLAGS\""

    MAKE_INSTALL_ARGS_WS="
        $MAKE_ARGS_WS
        DEST_DIR=\"$DESTDIR\"
        DEST_BIN=$DEST_HOME/bin
        DEST_SHARE=$DEST_HOME/lib
    "
}

configure_amd64() {
    MAKE_ARGS_WS="OPTFLAGS=\"-D_LARGEFILE64_SOURCE ${CFLAGS[amd64]} $CFLAGS\""

    MAKE_INSTALL_ARGS_WS="
        $MAKE_ARGS_WS
        DEST_DIR=\"$DESTDIR\"
        DEST_BIN=$DEST_HOME/bin
        DEST_SHARE=$DEST_HOME/lib/amd64
    "
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

TESTSUITE_SED="
    s/[0-9]* CPUs x64/CPUs x64/
    /^REP=/d
    /check\/\.\./d
"

init
download_source $PROG ${PROG}_${SRCVER}
patch_source
prep_build
build -noctf    # C++
run_testsuite test
install_sh_wrapper
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
