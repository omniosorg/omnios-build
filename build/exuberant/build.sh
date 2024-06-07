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

. ../../lib/build.sh

PROG=exuberant-ctags
VER=5.8
PKG=developer/exuberant-ctags
SUMMARY="exuberant ctags"
DESC="Generates an index (or tag) file of language objects found in source "
DESC+="files that allows these items to be quickly and easily located by a "
DESC+="text editor or other utility"

set_arch 64
set_builddir ctags-$VER

MAKE_INSTALL_ARGS="-e CTAGS_PROG=ctags-exuberant"

init
download_source $PROG ctags $VER
patch_source
prep_build autoconf -autoreconf
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
