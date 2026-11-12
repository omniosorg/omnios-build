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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=flex
VER=2.6.5
PKG=developer/lexer/flex
SUMMARY="$PROG - A fast lexical analyser generator"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="developer/macro/gnu-m4"

set_cstandard gnu17

CONFIGURE_OPTS="
	--mandir=$PREFIX/share/man
	--infodir=$PREFIX/share/info
"
CONFIGURE_OPTS[amd64]+=" --includedir=/usr/include"
CONFIGURE_OPTS[aarch64]+=" CC_FOR_BUILD=$GCC"
CONFIGURE_OPTS[aarch64]+=" CFLAGS_FOR_BUILD=-std=gnu17"

# The configure script makes the wrong assumption about malloc/realloc when
# cross compiling.
CONFIGURE_OPTS[aarch64]+=" ac_cv_func_malloc_0_nonnull=yes"
CONFIGURE_OPTS[aarch64]+=" ac_cv_func_realloc_0_nonnull=yes"

# No need to link the old libintl as it is these days just a filter to libc
CONFIGURE_OPTS+=" gt_cv_func_gnugettext1_libc=yes"

MAKE_ARGS+=' dist_doc_DATA= '
MAKE_INSTALL_ARGS+=' dist_doc_DATA= '
TESTSUITE_FILTER='^(PASS|FAIL|XFAIL|XPASS|SKIP|ERROR|# |Testsuite)'

init
download_source $PROG $PROG $VER
patch_source
# The man page depends on the scanner skeleton, which is patched, and
# rebuilding it would need help2man.
run_inbuild $TOUCH doc/flex.1
prep_build
build
PATH=$GNUBIN:$PATH run_testsuite check tests
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
