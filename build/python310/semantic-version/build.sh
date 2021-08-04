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
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../../lib/functions.sh

PKG=library/python-3/semantic-version-310
PROG=semantic_version
inherit_ver python39/${PROG//_/-}
SUMMARY="A library implementing the 'SemVer' scheme."
DESC="This small python library provides a few tools to handle SemVer in "
DESC+="Python. It follows strictly the 2.0.0 version of the SemVer scheme."

. $SRCDIR/../common.sh

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package $SRCDIR/../common.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
