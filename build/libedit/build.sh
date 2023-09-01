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

# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=libedit
VER=20230828-3.1
PKG=library/libedit
SUMMARY="Editline Library (libedit)"
DESC="Command line editor library providing generic line editing, history "
DESC+="and tokenisation functions."

CONFIGURE_OPTS="--disable-static"
CPPFLAGS+=" -I/usr/include/ncurses"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
VERHUMAN=$VER VER=${VER#*-} make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
