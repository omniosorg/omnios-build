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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../../lib/functions.sh

PKG=library/python-3/ply-310
PROG=ply
inherit_ver python39/$PROG
SUMMARY="ply - Python lex and yacc"
DESC="$SUMMARY"

. $SRCDIR/../common.sh

make_licence() {
    awk '/Copyright/,/DAMAGE.$/{print}' $TMPDIR/$BUILDDIR/README.md > \
        $TMPDIR/$BUILDDIR/LICENCE
}

init
download_source pymodules/$PROG $PROG $VER
patch_source
prep_build
python_build
make_licence
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
