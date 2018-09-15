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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PKG=system/library/gcc-runtime
PROG=libgcc_s
VER=8
VERHUMAN=$VER
SUMMARY="GNU compiler runtime dependencies"
DESC="$SUMMARY"

init
prep_build

# Abort if any of the following commands fail
set -o errexit
pushd $DESTDIR >/dev/null

# To keep all of the logic in one place, links are not created in the .mog

full=libgcc_s.so.1      # Same for all gcc versions

for v in `seq 5 $VER`; do
    logmsg "-- GCC $v - $full"
    logcmd mkdir -p usr/gcc/$v/lib/$ISAPART64
    logcmd ln -s $ISAPART64 usr/gcc/$v/lib/64
    if [ -f /opt/gcc-$v/lib/$full ]; then
        logcmd cp /opt/gcc-$v/lib/$full usr/gcc/$v/lib/$full
        logcmd cp /opt/gcc-$v/lib/$ISAPART64/$full \
            usr/gcc/$v/lib/$ISAPART64/$full
    else
        logcmd cp /usr/gcc/$v/lib/$full usr/gcc/$v/lib/$full
        logcmd cp /usr/gcc/$v/lib/$ISAPART64/$full \
            usr/gcc/$v/lib/$ISAPART64/$full
    fi
    logcmd ln -s $full usr/gcc/$v/lib/libgcc_s.so
    logcmd ln -s $full usr/gcc/$v/lib/$ISAPART64/libgcc_s.so
done

mkdir -p usr/lib/$ISAPART64
logcmd ln -s ../gcc/$DEFAULT_GCC_VER/lib/$full usr/lib/$full
logcmd ln -s ../../gcc/$DEFAULT_GCC_VER/lib/$ISAPART64/$full \
    usr/lib/$ISAPART64/$full
logcmd ln -s $full usr/lib/libgcc_s.so
logcmd ln -s $full usr/lib/$ISAPART64/libgcc_s.so

popd >/dev/null
set +o errexit

make_package runtime.mog
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
