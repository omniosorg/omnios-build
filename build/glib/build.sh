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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=glib
VER=2.58.0
PKG=library/glib2
SUMMARY="GNOME utility library"
DESC="$SUMMARY"

DEPENDS_IPS="
    runtime/python-27
    runtime/perl
"

CFLAGS+=" -D_XPG6"
LDFLAGS+=" -Wl,-z,ignore"

CONFIGURE_OPTS="
    --disable-fam
    --disable-dtrace
    --with-threads=posix
    --disable-dependency-tracking
"

# With gcc 6 and above, -Werror_format=2 produces errors like:
#   error: format not a string literal, arguments not checked
# Tell configure that this flag doesn't exist for the compiler.
CONFIGURE_OPTS+="
    cc_cv_CFLAGS__Werror_format_2=no
"

# As of glib 2.58.0, the sys/auxv.h header is spotted and then it is assumed
# that we have getauxval() and the Linux glibc-specific AT_SECURE; we don't.
CONFIGURE_OPTS+="
    ac_cv_header_sys_auxv_h=no
"

# glib 2.58.0 does not contain a built autotools. This could be deliberate
# since they are moving to Meson/ninja or it could be fixed in the next
# release.
build_autotools() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    [ -x configure ] && return
    logmsg "-- Running autogen.sh"
    # The OmniOS `which` command produces output on stdout if the file is
    # not found. Adjust script accordingly.
    logcmd sed -i '/^GTKDOCIZE=/s/=.*/=/' autogen.sh
    NOCONFIGURE=1 logcmd ./autogen.sh || logerr "Failed to run autogen.sh"
    popd > /dev/null
}

TESTSUITE_FILTER='^[A-Z#][A-Z ]'

init
download_source $PROG $PROG $VER
build_autotools
patch_source
run_autoreconf
prep_build
build
run_testsuite check
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
