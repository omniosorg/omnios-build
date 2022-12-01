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

# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh
. common.sh

PKG=system/library/gccgo-runtime
PROG=gccgo
VER=11
SUMMARY="GNU go runtime dependencies"
DESC="$SUMMARY"

# These libraries only came in with gcc 9 so use this as the baseline for
# the unversioned links in usr/lib
SHARED_GCC_VER=9

init
prep_build
shopt -s extglob

# Abort if any of the following commands fail
set -o errexit
pushd $DESTDIR >/dev/null

# To keep all of the logic in one place, links are not created in the .mog

libs="libgo"

mkdir -p usr/lib/amd64

for v in `seq 9 $VER`; do
    install_lib $v "$libs"
done

install_unversioned $SHARED_GCC_VER "$libs"

popd >/dev/null
set +o errexit

((EXTRACT_MODE)) && exit
make_package runtime.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
