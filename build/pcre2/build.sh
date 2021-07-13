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

# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=pcre2
VER=10.37
PKG=library/pcre2
SUMMARY="Perl-Compatible Regular Expressions, version 2"
DESC="The PCRE library is a set of functions that implement regular expression"
DESC+=" pattern matching using the same syntax and semantics as Perl 5"

# 10.37 - libpcre-posix.so changed from .2 to .3 as a set of compatibility
#         functions was removed. We continue to build and provide
#         libpcre-posix.so.2 for existing software linked against it.
#      https://vcs.pcre.org/pcre2/code/trunk/src/pcre2posix.c?r1=1176&r2=1306
PVERS="10.36"

CONFIGURE_OPTS="
	--localstatedir=/var
	--disable-static
	--enable-rebuild-chartables
	--enable-newline-is-any
	--disable-stack-for-recursion
	--with-link-size=4
	--with-match-limit=10000000
	--with-pic
"

init
prep_build

# Build previous versions
save_variables BUILDDIR EXTRACTED_SRC
for pver in $PVERS; do
    note -n "Building previous version: $pver"
    set_builddir $PROG-$pver
    download_source pcre $PROG $pver
    patch_source patches-${pver%%.*}
    build
done
restore_variables BUILDDIR EXTRACTED_SRC

note -n "Building current version: $VER"
download_source pcre $PROG $VER
patch_source
build
run_testsuite check
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
