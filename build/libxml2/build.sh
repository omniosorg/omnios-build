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
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=libxml2
VER=2.14.3
PKG=library/libxml2
SUMMARY="XML C parser and toolkit"
DESC="Portable XML parser and toolkit library"

# 2.14 - Binary compatibility is restricted to versions 2.14 or newer. On ELF
#        systems, the soname was bumped from libxml2.so.2 to libxml2.so.16.
#        We continue to ship the last version from before this switch.
PVERS="2.13.8"

RUN_DEPENDS_IPS="compress/xz library/zlib"

CONFIGURE_OPTS+="
    --disable-static
    --without-python
    --with-legacy
    --with-lzma
    --with-zlib
    --with-http
"

TESTSUITE_FILTER="^(Total|[Tt]esting|Ran)"

CFLAGS[aarch64]+=" -mtls-dialect=trad"

init
prep_build

# Skip previous versions for cross compilation
pre_build() { ! cross_arch $1; }

# Build previous versions
save_variables BUILDDIR EXTRACTED_SRC
for pver in $PVERS; do
    note -n "Building previous version: $pver"
    set_builddir $PROG-$pver
    download_source -dependency $PROG $PROG $pver
    patch_source patches-${pver%%.*}
    ((EXTRACT_MODE == 0)) && build
done
restore_variables BUILDDIR EXTRACTED_SRC
unset -f pre_build

note -n "Building current version: $VER"
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
build
run_testsuite check
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
