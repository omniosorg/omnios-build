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
#
. ../../../lib/build.sh

PKG=library/python-3/rapidjson-313
PROG=rapidjson
inherit_ver python312/rapidjson
SUMMARY="rapidjson - Python interface to RapidJSON"
DESC="RapidJSON is an extremely fast C++ JSON parser and serialization library"
DESC+="; this module wraps it into a Python 3 extension"

. $SRCDIR/../common.sh

CFLAGS[aarch64]+=" -fpermissive"

set_builddir python_$PROG-$VER

init
download_source pymodules/$PROG python_$PROG $VER
patch_source
prep_build
python_build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
