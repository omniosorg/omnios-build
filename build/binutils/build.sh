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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=binutils
VER=2.31.1
VERHUMAN=$VER
PKG=developer/gnu-binutils
SUMMARY="$PROG - a collection of binary tools"
DESC="$SUMMARY"

[ "$BUILDARCH" = "both" ] && BUILDARCH=32

HARDLINK_TARGETS="
    usr/bin/i386/gar
    usr/bin/i386/gas
    usr/bin/i386/gld
    usr/bin/i386/gld.gold
    usr/bin/i386/gnm
    usr/bin/i386/gobjcopy
    usr/bin/i386/gobjdump
    usr/bin/i386/granlib
    usr/bin/i386/greadelf
    usr/bin/i386/gstrip
"

CONFIGURE_OPTS="
    --exec-prefix=/usr/gnu
    --program-prefix=g
    --enable-gold=yes
    --enable-largefile
    --with-system-zlib
"

# Without specifying the shell as bash here, the generated linker
# emulation files get truncated scripts.
# We already export SHELL=bash in config.sh but that doesn't seem
# to be enough.
MAKE_ARGS+=" SHELL=/bin/bash"

basic_tests() {
    logmsg "--- basic tests"
    # Limited sanity checks
    [ `$DESTDIR/usr/bin/gld --print-output-format` = elf32-i386-sol2 ] \
        || logerr "gld output format test failed"
    # These targets are required for the ilumos-omnios UEFI build.
    # https://illumos.topicbox.com/groups/developer/T5f37e8c8f0687062-Mcec43129fb017b70a035e5fd
    for target in pe-i386 pei-i386 pe-x86-64 pei-x86-64; do
        $DESTDIR/usr/bin/gobjdump -i | grep -qw "$target" \
            || logerr "output format $target not supported."
    done
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
basic_tests
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
