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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=libxml2
VER=2.10.0
PKG=library/libxml2
SUMMARY="XML C parser and toolkit"
DESC="Portable XML parser and toolkit library"

RUN_DEPENDS_IPS="compress/xz library/zlib"

XFORM_ARGS="-D VER=$VER"

CONFIGURE_OPTS+=" --without-python"

TESTSUITE_FILTER="^(Total|[Tt]esting|Ran)"

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
prep_build
build
run_testsuite check
make_isa_stub
make_package local.mog final.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
