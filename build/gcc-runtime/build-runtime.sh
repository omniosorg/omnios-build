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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh
. common.sh

PKG=system/library/gcc-runtime
PROG=libgcc_s
VER=12
SUMMARY="GNU compiler runtime dependencies"
DESC="$SUMMARY"

BMI_EXPECTED=1

init
prep_build
shopt -s extglob

# Abort if any of the following commands fail
set -o errexit
pushd $DESTDIR >/dev/null

# To keep all of the logic in one place, links are not created in the .mog

libs="libgcc_s libatomic libgomp libssp"

mkdir -p usr/lib/amd64

for v in `seq 5 $VER`; do
    install_lib $v "$libs"
    # The gcc-runtime package provides the 64 -> amd64 links
    logcmd ln -s amd64 usr/gcc/$v/lib/64
done

install_unversioned $SHARED_GCC_VER "$libs"

# And special-case libssp.so.0.0.0
lib=libssp.so.0.0.0
logcmd ln -sf ../gcc/$SHARED_GCC_VER/lib/$lib usr/lib/$lib
logcmd ln -sf ../../gcc/$SHARED_GCC_VER/lib/amd64/$lib \
    usr/lib/amd64/$lib

popd >/dev/null
set +o errexit

((EXTRACT_MODE)) && exit
make_package runtime.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
