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
#
. ../../lib/build.sh
. common.sh

PKG=system/library/g++-runtime
PROG=libstdc++
VER=12
SUMMARY="GNU C++ compiler runtime dependencies"
DESC="$SUMMARY"

init
prep_build
shopt -s extglob

# Abort if any of the following commands fail
set -o errexit
pushd $DESTDIR >/dev/null

# To keep all of the logic in one place, links are not created in the .mog

mkdir -p usr/lib/amd64

libs="libstdc++"

for v in `seq 5 $VER`; do
    install_lib $v "$libs"
done

install_unversioned $SHARED_GCC_VER "$libs"

# Copy in legacy versions in case old code is linked against them
mkdir -p usr/gcc/legacy/lib/amd64
for lver in `seq 13 $max`; do
    [ -f /usr/lib/libstdc++.so.6.0.$lver ] || continue
    # Already provided by non-legacy
    [ -f usr/lib/libstdc++.so.6.0.$lver ] && continue
    logmsg "-- Installing legacy libstdc++.so.6.0.$lver"
    logcmd cp /usr/lib/libstdc++.so.6.0.$lver usr/gcc/legacy/lib/
    logcmd cp /usr/lib/amd64/libstdc++.so.6.0.$lver \
        usr/gcc/legacy/lib/amd64/
    checksum usr/gcc/legacy/lib/libstdc++.so.6.0.$lver
    checksum usr/gcc/legacy/lib/amd64/libstdc++.so.6.0.$lver
done

for f in usr/gcc/legacy/lib/lib*; do
    bf=`basename $f`
    ln -sf ../gcc/legacy/lib/$bf usr/lib/$bf
    ln -sf ../../gcc/legacy/lib/amd64/$bf usr/lib/amd64/$bf
done

popd >/dev/null
set +o errexit

((EXTRACT_MODE)) && exit
make_package runtime.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
