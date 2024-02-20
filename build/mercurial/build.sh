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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=mercurial
VER=6.6.3
PKG=developer/versioning/mercurial
SUMMARY="Mercurial source control management"
DESC="Free, distributed source control management tool"

RUN_DEPENDS_IPS="web/curl library/security/openssl"

# Force using the legacy setup.py backend as the PEP518 build fails
# to install. This will presumably be fixed upstream at some point.
PYTHON_BUILD_BACKEND=setuppy

# Mercurial bundles a zstd python module which is a fat binary supporting
# different architectures.
BMI_EXPECTED=1
# The various bundled python modules have shared objects with no SONAME.
NO_SONAME_EXPECTED=1

PKGDIFF_HELPER='
    s:(vendor-packages/[^-]*)-[0-9.]*:\1-VERSION:g
'

init
download_source $PROG $PROG $VER
patch_source
prep_build
python_build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
