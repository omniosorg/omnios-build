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

PKG=library/python-3/setuptools-rust-313
PROG=setuptools_rust
VER=1.11.0
SUMMARY="Python setuptools rust extension plugin"
DESC="Compile and distribute Python extensions written in rust as easily "
DESC+="as if they were written in C."

. $SRCDIR/../common.sh

RUN_DEPENDS_IPS+="
    library/python-$PYMVER/setuptools-$SPYVER
    library/python-$PYMVER/semantic-version-$SPYVER
    library/python-$PYMVER/tomli-$SPYVER
    library/python-$PYMVER/typing-extensions-$SPYVER
"

init
download_source pymodules/${PROG/_/-} $PROG-$VER
patch_source
prep_build
python_build
make_package $SRCDIR/../common.mog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
