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

PKG=library/python-3/cryptography-312
PROG=cryptography
inherit_ver python313/cryptography
SUMMARY="Cryptographic recipes and primitives"
DESC="$SUMMARY"

. $SRCDIR/../common.sh

if [ "$BUILDARCH" = aarch64 ]; then
    # This is the last version that does not require rust to build, so we use
    # that for aarch64 for now.
    VER=3.4.8
    export CRYPTOGRAPHY_DONT_BUILD_RUST=1
    set_patchdir patches.aarch64
fi

RUN_DEPENDS_IPS+="
    library/python-$PYMVER/six-$SPYVER
    library/python-$PYMVER/cffi-$SPYVER
    library/python-$PYMVER/asn1crypto-$SPYVER
    library/python-$PYMVER/idna-$SPYVER
"

# As of version 3.4, the cryptography module includes Rust code
BUILD_DEPENDS_IPS+="
    library/python-$PYMVER/setuptools-rust-$SPYVER
"

PATH+=:$OOCEBIN

# This package uses cffi as part of the build, and so the usual python cross
# compilation method (using the `crossenv` module) does not work.
# Somewhat surprisingly, this simple workaround does, although we have to
# use a compiler wrapper to strip options that are not applicable to
# the cross compiler and are otherwise picked by cffi from the native system
# info.
python_build_aarch64() {
    typeset arch=aarch64

    set_crossgcc $arch

    CFLAGS[$arch]+=" -mtls-dialect=trad"

    CC=$SRCDIR/files/gcc.aarch64 \
       PLATFORM=$arch \
       DESTDIR="$DESTDIR.$arch" \
       python_build_arch $arch
}

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
