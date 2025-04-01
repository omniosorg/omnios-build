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
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../../lib/build.sh

PKG=library/python-3/setuptools-313
PROG=setuptools
VER=78.1.0
SUMMARY="Python package management"
DESC="Easily download, build, install, upgrade, and uninstall Python packages"

. $SRCDIR/../common.sh

if [ "$FLAVOR" = bootstrap ]; then
    # When bootstrapping a new python version, we need to break the cyclic
    # dependency between setuptools and pip. Build without pip and do not add
    # the dependency.
    PYTHON_BUILD_BACKEND=setuppy
else
    RUN_DEPENDS_IPS+=" library/python-$PYMVER/pip-$SPYVER"
fi

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_package $SRCDIR/../common.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
