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
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

. ../../../lib/build.sh

PKG=library/python-3/referencing-313
PROG=referencing
VER=0.37.0
SUMMARY="JSON referencing and dereferencing for Python"
DESC="An implementation-agnostic implementation of JSON reference resolution"

. $SRCDIR/../common.sh

RUN_DEPENDS_IPS+="
    library/python-$PYMVER/attrs-$SPYVER
    library/python-$PYMVER/rpds-py-$SPYVER
"

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package $SRCDIR/../common.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
