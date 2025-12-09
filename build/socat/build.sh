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

# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=socat
VER=1.8.1.0
PKG=network/socat
SUMMARY="Multipurpose socket relay"
DESC="socat is a relay for bidirectional data transfer between two "
DESC+="independent data channels."

set_arch 64

save_function patch_source _patch_source
patch_source() {
    # socat ships a symlink from configure.in to configure.ac which
    # confuses patch rebasing and autoreconf
    run_inbuild rm -f configure.in
    _patch_source "$@"
    run_autoconf
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
