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

#
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.
#

. ../../lib/build.sh

PROG=aarch64-fw
PKG=system/firmware/aarch64
VER=20250501
SUMMARY="Firmware components for aarch64"
DESC="Firmware blobs necessary for OmniOS aarch64"

PKG_ARCH=aarch64
# This is only built for aarch64
if [ "$CLIBUILDARCH" != $PKG_ARCH ]; then
   logmsg "$PKG is not built for this architecture"
   exit 0
fi

# Respect environmental overrides for these to ease development.
: ${KAYAK_SOURCE_REPO:=$OOCEGITHUB/kayak}
: ${KAYAK_SOURCE_BRANCH:=r$RELVER}

SKIP_LICENCES=Broadcom

clone_source() {
    clone_github_source kayak \
        "$KAYAK_SOURCE_REPO" "$KAYAK_SOURCE_BRANCH" "$KAYAK_CLONE"

    gdir=$TMPDIR/$BUILDDIR/kayak
    VER=$REVSTAMP
    VERHUMAN="${COMMIT:0:7} from $REVDATE"
    ((EXTRACT_MODE)) && exit
    append_builddir kayak
}

MAKE_ARGS=rpi-bins

set_crossgcc() { false; }
pre_configure() { false; }

make_install() {
    set -eE; trap 'logerr Installation failed at $BASH_LINENO' ERR

    typeset fw=$DESTDIR/usr/share/firmware
    typeset lic=$TMPDIR/licences

    $RM -rf $lic/
    $MKDIR -p $fw/ $lic/

    logmsg "-- installing licences"
    $CP bin/u-boot.licences/gpl-2.0.txt $lic/
    $CP bin/bl31.licence $lic/
    $CP bin/rpi-firmware/boot/COPYING.linux $lic/
    $CP bin/rpi-firmware/boot/LICENCE.broadcom $lic/

    logmsg "-- installing QEMU,virt firmware"
    tgt=$fw/QEMU,virt
    $MKDIR -p $tgt
    $CP bin/u-boot.qemu_arm64_defconfig $tgt/u-boot.bin

    logmsg "-- installing RaspberryPi,4 firmware"
    tgt=$fw/RaspberryPi,4
    $MKDIR -p $tgt/overlays
    $CP bin/u-boot.rpi_4_defconfig $tgt/u-boot.bin
    $CP bin/bl31.bin $tgt/
    for f in \
        bootcode.bin \
        fixup4cd.dat \
        start4cd.elf \
        bcm2711-rpi-4-b.dtb \
        bcm2712-rpi-5-b.dtb
    do
        $CP bin/rpi-firmware/boot/$f $tgt/
    done
    $CP bin/rpi-firmware/boot/overlays/* $tgt/overlays

    set +eE; trap - ERR
}

init
prep_build
clone_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
