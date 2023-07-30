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
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../../lib/build.sh

PKG=library/python-3/typing-extensions-311
PROG=typing-extensions
VER=4.7.1
SUMMARY="Python typing extensions"
DESC="Backported and Experimental Type Hints for Python 3.6+"

. $SRCDIR/../common.sh

set_builddir ${PROG/-/_}-$VER

init
download_source pymodules/$PROG ${PROG/-/_} $VER
patch_source
prep_build
python_build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
