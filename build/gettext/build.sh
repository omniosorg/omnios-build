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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=gettext
VER=0.22.3
PKG=text/gnu-gettext
SUMMARY="gettext - GNU gettext utility"
DESC="GNU gettext - GNU gettext utility"

set_arch 64

RUN_DEPENDS_IPS="system/prerequisite/gnu developer/macro/gnu-m4"

CONFIGURE_OPTS="
    --infodir=$PREFIX/share/info
    --disable-java
    --disable-libasprintf
    --without-emacs
    --disable-openmp
    --disable-static
    --disable-shared
"

TESTSUITE_FILTER='^[A-Z#][A-Z ]'

PKGDIFF_HELPER='
    s:usr/share/gettext-[0-9.]*:usr/share/gettext-VERSION:
'

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
