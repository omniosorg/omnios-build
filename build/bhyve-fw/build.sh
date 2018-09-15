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

# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

BUILD_DEPENDS_IPS="
    developer/acpi/compiler
    developer/nasm
"

PROG=uefi-edk2
PKG=system/bhyve/firmware
VER=20180309
VERHUMAN=$VER
SUMMARY="UEFI-EDK2(+CSM) firmware for bhyve"
DESC="$SUMMARY"

# Respect environmental overrides for these to ease development.
: ${EDK2_SOURCE_REPO:=$GITHUB/$PROG}
: ${EDK2_SOURCE_BRANCH:=master}

# Extend VER so that the temporary build directory is branch specific.
# Branch names can include '/' so remove them.
VER+="-${EDK2_SOURCE_BRANCH//\//_}"

export GCCPATH=/opt/gcc-4.4.4

MAKE_ARGS="
        AS=/usr/bin/gas
        AR=/usr/bin/gar
        LD=/usr/bin/gld
        OBJCOPY=/usr/bin/gobjcopy
        CC=${GCCPATH}/bin/gcc
        CXX=${GCCPATH}/bin/g++
"

export OOGCC_BIN=$GCCPATH/bin/
export IASL_PREFIX=/usr/sbin/
export NASM_PREFIX=/usr/bin/

clone_source() {
    clone_github_source $PROG \
        "$EDK2_SOURCE_REPO" "$EDK2_SOURCE_BRANCH" "$EDK2_CLONE"
}

edksetup() {
    pushd $TMPDIR/$BUILDDIR/$PROG > /dev/null || logerr "--- chdir failed"
    source edksetup.sh
    popd > /dev/null
}

cleanup() {
    logmsg "-- Cleaning source tree"

    pushd $TMPDIR/$BUILDDIR/$PROG > /dev/null || logerr "--- chdir failed"

    logcmd gmake $MAKE_ARGS ARCH=X64 -C BaseTools clean
    rm -rf Build Conf/{target,build_rule,tools_def}.txt Conf/.cache 2>/dev/null

    popd > /dev/null
}

build_tools() {
    logmsg "-- Building tools"

    pushd $TMPDIR/$BUILDDIR/$PROG > /dev/null || logerr "--- chdir failed"

    # The code isn't able to detect the build architecture - it doesn't
    # expect `uname -m` to return `i86pc`
    logcmd gmake $MAKE_ARGS ARCH=X64 -C BaseTools \
        || logerr "--- BaseTools build failed"

    popd > /dev/null
}

build() {
    pushd $TMPDIR/$BUILDDIR/$PROG > /dev/null || logerr "--- chdir failed"

    [ "$1" = "-csm" ] && csm=1 || csm=0

    BUILD_ARGS="-DDEBUG_ON_SERIAL_PORT=TRUE -DFD_SIZE_2MB"
    [ $csm -eq 1 ] && BUILD_ARGS+=" -DCSM_ENABLE=TRUE"
    export BUILD_ARGS

    for mode in RELEASE DEBUG; do
        [[ "$FLAVOR" = *DEBUG* && $mode = RELEASE ]] && continue
        [[ "$FLAVOR" = *RELEASE* && $mode = DEBUG ]] && continue
        logmsg "-- Building $mode firmware"

        case $mode in
            RELEASE)    dport=0x2f8; level=CRIT ;;
            DEBUG)      dport=0x3f8; level=INFO ;;
        esac
        logcmd sed -i "/PcdDebugIoPort|0x[0-9A-Fa-f]/s/0x[0-9A-Fa-f]*/$dport/" \
            BhyvePkg/BhyvePkg.dec || logerr "sed BhyvePkg.dec"
        logcmd sed -i "/DEBUG_PORT=0x/s/0x.*/$dport/" \
            BhyvePkg/Csm/BhyveCsm16/GNUmakefile || logerr "sed GNUmakefile"
        logcmd sed -i "/DebugLevel = DBG/s/DBG_.*/DBG_$level;/" \
            BhyvePkg/Csm/BhyveCsm16/Printf.c || logerr "sed Printf.c"

        if [ $csm -eq 1 ]; then
            logmsg "-- Building compatibility support module (CSM)"
            logcmd gmake $MAKE_ARGS -C BhyvePkg/Csm/BhyveCsm16/ clean all \
                || logerr "--- CSM build failed"
        fi

        logcmd `which build` \
            -t OOGCC -a X64 -b $mode \
            -p BhyvePkg/BhyvePkgX64.dsc \
            $BUILD_ARGS || logerr "--- $mode build failed"
    done

    popd > /dev/null
}

install() {
    suffix="$1"
    pushd $TMPDIR/$BUILDDIR/$PROG > /dev/null || logerr "--- chdir failed"
    logcmd mkdir -p $DESTDIR/usr/share/bhyve/firmware
    [ -f $DESTDIR/LICENCE ] || cp OvmfPkg/License.txt $DESTDIR/LICENCE
    for mode in RELEASE DEBUG; do
        logcmd cp Build/BhyveX64/${mode}_OOGCC/FV/BHYVE.fd \
            $DESTDIR/usr/share/bhyve/firmware/BHYVE_$mode$suffix.fd
    done
    popd > /dev/null
}

init
prep_build
clone_source

cleanup
build_tools
edksetup

if [[ -z "$FLAVOR" || "$FLAVOR" = *UEFI* ]]; then
    # Build UEFI firmware
    note "UEFI Firmware"
    build
    install
fi

if [[ -z "$FLAVOR" || "$FLAVOR" = *CSM* ]]; then
    # Build UEFI+CSM firmware
    note "UEFI+CSM Firmware"
    build -csm
    install _CSM
fi

# Reset version for package creation
VER=$VERHUMAN
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
