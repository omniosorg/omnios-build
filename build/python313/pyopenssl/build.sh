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
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.
#
. ../../../lib/build.sh

PKG=library/python-3/pyopenssl-313
PROG=pyopenssl
VER=24.3.0
SUMMARY="pyOpenSSL - Python interface to the OpenSSL library"
DESC="$SUMMARY"

. $SRCDIR/../common.sh

RUN_DEPENDS_IPS+=" library/python-$PYMVER/cryptography-$SPYVER"

if [ "$BUILDARCH" = aarch64 ]; then
    # This is the last version that does work with the version-locked
    # cryptography for aarch64
    VER=24.2.1
    set_patchdir patches.aarch64
fi

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
