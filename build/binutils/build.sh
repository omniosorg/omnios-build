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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/arch.sh
. ../../lib/build.sh

PROG=binutils
VER=2.41
PKG=developer/gnu-binutils
SUMMARY="GNU binary utilities"
DESC="A set of programming tools for creating and managing binary programs, "
DESC+="object files, libraries, etc."

set_arch 64
CTF_FLAGS+=" -s"

HARDLINK_TARGETS="
    usr/bin/gar
    usr/bin/gas
    usr/bin/gld
    usr/bin/gld.gold
    usr/bin/gnm
    usr/bin/gobjcopy
    usr/bin/gobjdump
    usr/bin/granlib
    usr/bin/greadelf
    usr/bin/gstrip
"

CONFIGURE_OPTS="
    --exec-prefix=/usr/gnu
    --program-prefix=g
    --enable-gold=yes
    --enable-largefile
    --with-system-zlib
"

# Program header data segments are RWX on illumos for at least 32-bit
CONFIGURE_OPTS+=" --enable-warn-rwx-segments=no"

XFORM_ARGS="-D GNU_ARCH=${TRIPLETS[amd64]}"

# stop binutils 2.34 from building info files
MAKE_ARGS="MAKEINFO=/usr/bin/true"
MAKE_INSTALL_ARGS="$MAKE_ARGS"

basic_tests() {
    logmsg "--- basic tests"
    # Limited sanity checks
    [ `$DESTDIR/usr/bin/gld --print-output-format` = elf64-x86-64-sol2 ] \
        || logerr "gld output format test failed"
    # These targets are required for the ilumos-omnios UEFI build.
    # https://illumos.topicbox.com/groups/developer/T5f37e8c8f0687062-Mcec43129fb017b70a035e5fd
    for target in pei-i386 pei-x86-64; do
        $DESTDIR$USRBIN/gobjdump -i | grep -qw "$target" \
            || logerr "output format $target not supported."
    done
}

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf -oot
build
basic_tests
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
