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

# Copyright 2020 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

BUILD_DEPENDS_IPS="
    developer/acpi
    developer/nasm
"

PROG=uefi-edk2
PKG=system/bhyve/firmware
VER=20200501
SUMMARY="UEFI-EDK2(+CSM) firmware for bhyve"
DESC="$SUMMARY"

init
prep_build

fwdir=$DESTDIR/usr/share/bhyve/firmware
XFORM_ARGS+=" -D FWDIR=usr/share/bhyve/firmware"
logcmd mkdir -p $fwdir

export GMAKE=/usr/bin/gmake
export GAS=/usr/bin/gas
export GAR=/usr/bin/gar
export GLD=/usr/bin/gld
export GOBJCOPY=/usr/bin/gobjcopy

# set firmware versions for symlinks
XFORM_ARGS+=" -D UEFIVER=2.70 -D CSMVER=2.40"

# Since the firmware builds will run in parallel in the background,
# put them in a new task which will be killed on interrupt.
newtask -c $$
trap "pkill -T0; exit" SIGINT

# Build the UEFI firmware

tag=il-edk2-stable202005-1
XFORM_ARGS+=" -D UEFITAG=$tag"

(
    if [ -z "$FLAVOR" -o "$FLAVOR" = UEFI ]; then
        set_gccver $DEFAULT_GCC_VER
        set_builddir uefi-edk2-$tag
        download_source bhyve-fw uefi-edk2 $tag
        pushd $TMPDIR/$BUILDDIR >/dev/null
        logcmd cp OvmfPkg/License.txt $fwdir/LICENCE.$tag.OvmfPkg
        logcmd cp BhyvePkg/License.txt $fwdir/LICENCE.$tag.BhyvePkg
        for v in RELEASE DEBUG; do
            [ -n "$DEPVER" -a "$DEPVER" != $v ] && continue
            note "Building UEFI $v firmware"
            logcmd ./build clean
            logcmd ./build $v || logerr "UEFI $v build failed"
            logcmd cp Build/BhyveX64/${v}_ILLGCC/FV/BHYVE_CODE.fd \
                $fwdir/BHYVE_$v.fd \
                || logerr "Copy firmware failed"
        done
        popd >/dev/null
    fi
) &

# At present, the CSM firmware is still built from the old 2014 branch
# using gcc 4.

tag=il-udk2014.sp1-2
XFORM_ARGS+=" -D CSMTAG=$tag"

(
    if [ -z "$FLAVOR" -o "$FLAVOR" = CSM ]; then
        set_gccver 4.4.4
        set_builddir uefi-edk2-$tag
        download_source bhyve-fw uefi-edk2 $tag
        pushd $TMPDIR/$BUILDDIR >/dev/null
        logcmd cp OvmfPkg/License.txt $fwdir/LICENCE.$tag.OvmfPkg
        for v in RELEASE DEBUG; do
            [ -n "$DEPVER" -a "$DEPVER" != $v ] && continue
            note "Building CSM $v firmware"
            logcmd ./build clean
            logcmd bash -x ./build -csm $v || logerr "CSM $v build failed"
            logcmd cp Build/BhyveX64/${v}_ILLGCC/FV/BHYVE.fd \
                $fwdir/BHYVE_${v}_CSM.fd \
                || logerr "Copy firmware failed"
        done
        popd >/dev/null
    fi
) &

# Both firmware branches are built in parallel, wait for them to finish
wait

make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
