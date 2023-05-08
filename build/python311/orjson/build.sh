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
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
#
. ../../../lib/build.sh

PKG=library/python-3/orjson-311
PROG=orjson
VER=3.8.12
SUMMARY="orjson"
DESC="A fast, correct JSON library for Python."

. $SRCDIR/../common.sh

PATH+=:$OOCEBIN

install() {
    logmsg "Installing"
    pushd $TMPDIR/$BUILDDIR >/dev/null

    logcmd mkdir -p $DESTDIR/$PYTHONVENDOR || logerr "mkdir"
    logcmd cp target/release/lib$PROG.so \
        $DESTDIR/$PYTHONVENDOR/$PROG.cpython-$PYTHONPKGVER.so \
        || logerr "cp failed"

    popd >/dev/null
}

init
download_source pymodules/$PROG $VER
patch_source
prep_build
build_rust
install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
