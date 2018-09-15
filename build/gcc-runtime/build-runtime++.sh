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

PKG=system/library/g++-runtime
PROG=libstdc++
VER=8
VERHUMAN=$VER
SUMMARY="GNU C++ compiler runtime dependencies"
DESC="$SUMMARY"

init
prep_build
shopt -s extglob

# Abort if any of the following commands fail
set -o errexit
pushd $DESTDIR >/dev/null

# To keep all of the logic in one place, links are not created in the .mog

mkdir -p usr/lib/$ISAPART64

for v in `seq 5 $VER`; do
    logcmd mkdir -p usr/gcc/$v/lib/$ISAPART64
    for lib in libstdc++ libssp; do
        # Find the library file in this gcc version
        full=
        if [ -d /opt/gcc-$v/lib ]; then
            for l in /opt/gcc-$v/lib/$lib.so.*; do
                # There is a libstdc++.so.6.0.xx-gdb.py
                [[ $l = *.py ]] && continue
                [ -f $l -a ! -h $l ] && full=$l && break
            done
        else
            for l in /usr/gcc/$v/lib/$lib.so.*; do
                [[ $l = *.py ]] && continue
                [ -f $l -a ! -h $l ] && full=$l && break
            done
        fi
        [ -f $full ] || logerr "No $lib lib for gcc-$v"
        full=`basename $full`                          # libxxxx.so.1.2.3
        maj=${full/%.+([0-9]).+([0-9])/}               # libxxxx.so.1

        logmsg "-- GCC $v - $full ($maj)"

        if [ -f /opt/gcc-$v/lib/$full ]; then
            logcmd cp /opt/gcc-$v/lib/$full usr/gcc/$v/lib/$full
            logcmd cp /opt/gcc-$v/lib/$ISAPART64/$full \
                usr/gcc/$v/lib/$ISAPART64/$full
        else
            logcmd cp /usr/gcc/$v/lib/$full usr/gcc/$v/lib/$full
            logcmd cp /usr/gcc/$v/lib/$ISAPART64/$full \
                usr/gcc/$v/lib/$ISAPART64/$full
        fi

        # Now sort out the links

        # Link versioned libraries to /usr/lib - latest gcc version will win in
        # the case that two deliver the same versioned file.
        logcmd ln -sf ../gcc/$v/lib/$full usr/lib/$full
        logcmd ln -sf $full usr/lib/$maj
        logcmd ln -sf ../../gcc/$v/lib/$ISAPART64/$full usr/lib/$ISAPART64/$full
        logcmd ln -sf $full usr/lib/$ISAPART64/$maj

        logcmd ln -s $full usr/gcc/$v/lib/$maj
        logcmd ln -s $full usr/gcc/$v/lib/$ISAPART64/$maj
        logcmd ln -s $maj usr/gcc/$v/lib/$lib.so
        logcmd ln -s $maj usr/gcc/$v/lib/$ISAPART64/$lib.so

        # And now link in the main .so version for the current gcc

        logcmd ln -sf $maj usr/lib/$lib.so
        logcmd ln -sf ../gcc/$DEFAULT_GCC_VER/lib/$maj usr/lib/$maj
        logcmd ln -sf $maj usr/lib/$ISAPART64/$lib.so
        logcmd ln -sf ../../gcc/$DEFAULT_GCC_VER/lib/$ISAPART64/$maj \
            usr/lib/$ISAPART64/$maj
    done
done

# And special-case libssl.so.0.0.0
lib=libssp.so.0.0.0
logcmd ln -sf ../gcc/$DEFAULT_GCC_VER/lib/$lib usr/lib/$lib
logcmd ln -sf ../../gcc/$DEFAULT_GCC_VER/lib/$ISAPART64/$lib \
    usr/lib/$ISAPART64/$lib

# Copy in legacy versions in case old code is linked against them
mkdir -p usr/gcc/legacy/lib/$ISAPART64
for lver in `seq 13 25`; do
    [ -f /usr/lib/libstdc++.so.6.0.$lver ] || continue
    # Already provided by non-legacy
    [ -f usr/lib/libstdc++.so.6.0.$lver ] && continue
    logmsg "-- Installing legacy libstdc++.so.6.0.$lver"
    logcmd cp /usr/lib/libstdc++.so.6.0.$lver usr/gcc/legacy/lib
    logcmd cp /usr/lib/$ISAPART64/libstdc++.so.6.0.$lver \
        usr/gcc/legacy/lib/$ISAPART64
done

for f in usr/gcc/legacy/lib/lib*; do
    bf=`basename $f`
    ln -sf ../gcc/legacy/lib/$bf usr/lib/$bf
    ln -sf ../../gcc/legacy/lib/$ISAPART64/$bf usr/lib/$ISAPART64/$bf
done

popd >/dev/null
set +o errexit

make_package runtime++.mog
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
