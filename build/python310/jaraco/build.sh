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

. ../../../lib/functions.sh

PKG=library/python-3/jaraco-310
PROG=jaraco
inherit_ver python39/$PROG
SUMMARY="jaraco"
DESC="A bundle of jaraco python modules"

. $SRCDIR/../common.sh

typeset -A packages
packages[classes]=3.2.1
packages[collections]=3.3.0
packages[functools]=3.3.0
packages[text]=3.5.0

init
prep_build

for pkg in "${!packages[@]}"; do
    ver=${packages[$pkg]}
    BUILDDIR=$PROG.$pkg-$ver

    note -n "Building $PROG.$pkg"
    download_source pymodules/$PROG.$pkg $PROG.$pkg $ver
    python_build
done

EXTRACTED_SRC=$BUILDDIR make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
