#!/usr/bin/bash
#
# {{{ CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END }}}
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/build.sh

PKG=kvm     ##IGNORE## - filled in later
# This is pretty meaningless, and should be "0.5.11" but we messed that up
# by starting with "1.0.x" so this'll do.  There should be no need to change
# this going forward.
VER=1.0.5.11
KERNEL_SOURCE=$PREBUILT_ILLUMOS
PROTO_AREA=$KERNEL_SOURCE/proto/root_i386
PROG=illumos-kvm
SUMMARY="placeholder; reset below"
DESC="$SUMMARY"

# These are the dependencies for both the module and the cmds
BUILD_DEPENDS_IPS="
    archiver/gnu-tar
    developer/versioning/git
    file/gnu-coreutils
"
SKIP_LICENCES='qemu.license'
SKIP_SSP_CHECK=1

set_gccver $ILLUMOS_GCC_VER
set_arch 64

# Unset the prefix because we actually DO want things in kernel etc
PREFIX=

# Respect environmental overrides for these to ease development.
: ${KVM_SOURCE_REPO:=$OOCEGITHUB/illumos-kvm}
: ${KVM_SOURCE_BRANCH:=r$RELVER}
: ${KVM_CMD_SOURCE_REPO:=$OOCEGITHUB/illumos-kvm-cmd}
: ${KVM_CMD_SOURCE_BRANCH:=r$RELVER}

clone_source() {
    clone_github_source -dependency illumos-kvm \
        "$KVM_SOURCE_REPO" "$KVM_SOURCE_BRANCH" "$KVM_CLONE"
    KVM_COMMIT="`git -C $TMPDIR/$BUILDDIR/illumos-kvm \
        log -1 --format=format:%H`"
    clone_github_source -dependency illumos-kvm-cmd \
        "$KVM_CMD_SOURCE_REPO" "$KVM_CMD_SOURCE_BRANCH" "$KVM_CMD_CLONE"
    KVM_CMD_COMMIT="`git -C $TMPDIR/$BUILDDIR/illumos-kvm-cmd \
        log -1 --format=format:%H`"
    ((EXTRACT_MODE)) && exit
}

# Check this once at the start
check_for_prebuilt
# Fetch the source
init
clone_source

###########################################################################
# Kernel module build

configure_arch() { :; }

make_arch() {
    logcmd $MAKE \
        KERNEL_SOURCE=$KERNEL_SOURCE \
        PROTO_AREA=$PROTO_AREA \
        CC=$GCC \
        PRIMARY_COMPILER_VER=$GCCVER \
        || logerr "--- Make failed"
    logcmd cp $KERNEL_SOURCE/usr/src/OPENSOLARIS.LICENSE \
        $SRCDIR/OPENSOLARIS.LICENSE \
        || logerr "--- failed to copy CDDL from kernel sources"
}

save_function clean_up _clean_up
clean_up() {
    _clean_up
    [ -f $SRCDIR/OPENSOLARIS.LICENSE ] \
        && logcmd rm -f $SRCDIR/OPENSOLARIS.LICENSE
    return 0
}

fix_drivers() {
    logcmd mv $DESTDIR/usr/kernel $DESTDIR/ || \
        logerr "--- couldn't move kernel bits into /"
}

PROG=illumos-kvm
PKG=driver/virtualization/kvm
set_builddir "$BUILDDIR/$PROG"
echo "TMPDIR: $TMPDIR"
echo "BUILDDIR: $BUILDDIR"

prep_build
build -noctf    # The build scripts already take care of CTF for the driver
fix_drivers
SUMMARY="illumos KVM kernel driver ($PROG ${KVM_COMMIT:0:10})"
DESC="KVM is the kernel virtual machine, a framework for the in-kernel "
DESC+="acceleration of QEMU."
make_versionsbuild $PROG
make_package kvm.mog
clean_up

###########################################################################
# KVM utilities

unset SKIP_SSP_CHECK

configure_arch() {
    PREFIX=/usr
    CC=$GCC
    export KERNEL_SOURCE KVM_DIR PREFIX CC
}

make_arch() {
    logmsg "--- build.sh"
    logcmd ./build.sh || logerr "--- build.sh failed"
}

make_install() {
    logmsg "--- make install"
    logcmd $MAKE DESTDIR=${DESTDIR} V=1 install || \
        logerr "--- Make install failed"
}

PROG=illumos-kvm-cmd
PKG=system/kvm
KVM_DIR="$TMPDIR/$BUILDDIR"
set_builddir "$BUILDDIR-cmd"

prep_build
build
SUMMARY="illumos KVM utilities ($PROG ${KVM_CMD_COMMIT:0:10})"
make_package kvm-cmd.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
