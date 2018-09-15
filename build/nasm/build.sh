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

#
. ../../lib/functions.sh

PROG=nasm
VER=2.13.03
VERHUMAN=$VER
PKG=developer/nasm
SUMMARY="The Netwide Assembler"
DESC="$SUMMARY"

set_arch 32

init
download_source $PROG $PROG $VER
patch_source
prep_build
# Nasm uses INSTALLROOT instead of the more standard DESTDIR
MAKE_INSTALL_ARGS="INSTALLROOT=$DESTDIR"
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
