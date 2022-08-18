#!/usr/bin/bash

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

# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=xz
VER=5.2.6
PKG=compress/xz
SUMMARY="XZ Utils - general-purpose data compression software"
DESC="Free general-purpose data compression software with a "
DESC+="high compression ratio"

SKIP_LICENCES=xz

forgo_isaexec

save_function configure32 _configure32
configure32() {
    _configure32 "$@"
    logcmd gmake -C $TMPDIR/$BUILDDIR/src/liblzma foo
}

save_function configure64 _configure64
configure64() {
    _configure64 "$@"
    logcmd gmake -C $TMPDIR/$BUILDDIR/src/liblzma foo
}

TESTSUITE_SED="/libtool/d"

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
prep_build
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
