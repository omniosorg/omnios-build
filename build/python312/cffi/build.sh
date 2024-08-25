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
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../../lib/build.sh

PKG=library/python-3/cffi-312
PROG=cffi
VER=1.17.0
SUMMARY="cffi"
DESC="Foreign Function Interface for Python calling C code"

. $SRCDIR/../common.sh

CFLAGS[aarch64]+=" -mtls-dialect=trad"

RUN_DEPENDS_IPS+="
    library/python-$PYMVER/pycparser-$SPYVER
"

REMOVE_PREVIOUS=1

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
