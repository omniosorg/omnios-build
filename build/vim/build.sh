#!/usr/bin/bash
#
# {{{ CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END }}}
#
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=vim
VER=8.1
PKG=editor/vim
SUMMARY="Vi IMproved"
DESC="$SUMMARY"

SVER=${VER//./}
BUILDDIR=$PROG$SVER

set_arch 64

XFORM_ARGS+=" -D SVER=$SVER"

# VIM 8.0 source exposes either a bug in illumos msgfmt(1), OR it contains
# a GNU-ism we are strict about.  Either way, use GNU msgfmt for now.
export MSGFMT=/usr/gnu/bin/msgfmt

CONFIGURE_OPTS="
    --with-features=huge
    --without-x
    --disable-gui
    --disable-gtktest
"

extract_licence() {
    sed -n < $DESTDIR/usr/share/vim/vim$SVER/doc/uganda.txt \
           > $DESTDIR/usr/share/vim/vim$SVER/LICENCE '
        /=== begin of license ===/,/=== end of license ===/p
    '
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
extract_licence
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
