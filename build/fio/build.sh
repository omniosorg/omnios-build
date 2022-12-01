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
# Copyright 2011-2013 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
#
# Copyright (c) 2014, 2016 by Delphix. All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=fio
VER=3.33
PKG=system/test/fio
SUMMARY="Flexible IO Tester"
DESC="A tool that is able to simulate a given I/O workload"

RUN_DEPENDS_IPS+="
    runtime/python-$PYTHONPKGVER
"

set_builddir "$PROG-$PROG-$VER"
set_arch 64

CONFIGURE_OPTS[amd64]="
    --prefix=$PREFIX
    --extra-cflags=-m64
    --disable-native
"

SKIP_LICENCES=fio

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf-like
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
