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
# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=glib
VER=2.60.4
PKG=library/glib2
SUMMARY="GNOME utility library"
DESC="The GNOME general-purpose utility library"

RUN_DEPENDS_IPS="
    runtime/python-$PYTHONPKGVER
    runtime/perl-64
"

# use GNU msgfmt; otherwise the build fails
PATH="/usr/gnu/bin:$PATH:/opt/ooce/bin"

# With gcc 6 and above, -Werror_format=2 produces errors like:
#   error: format not a string literal, arguments not checked
# Tell configure that this flag doesn't exist for the compiler.
CFLAGS+=" -Wno-error=format-nonliteral -Wno-error=format=2"

# Required to enable the POSIX variants of getpwuid_r and getpwnam_r
# See comment in /usr/include/pwd.h
CFLAGS+=" -D_XPG6 -D_POSIX_PTHREAD_SEMANTICS"

LDFLAGS+=" -Wl,-z,ignore"

CONFIGURE_OPTS="
    --prefix=$PREFIX
    -Dfam=false
    -Dxattr=false
    -Dforce_posix_threads=true
    -Ddtrace=false
    -Db_asneeded=false
"
CONFIGURE_OPTS_32="
    --bindir=$PREFIX/bin
    --libdir=$PREFIX/lib
"
CONFIGURE_OPTS_64="
    --bindir=$PREFIX/bin
    --libdir=$PREFIX/lib/$ISAPART64
"

clean_testsuite() {
    local tf=`mktemp`
    run_testsuite test "" $tf
    [ ! -s $tf ] && rm -f $tf && return
    nawk '
        # Strip failed test output
        /^The output from .* first failed/ { exit }
        # Found a test
        /^ *[0-9][0-9]*\/[0-9]/ {
            # Remove elapsed time
            sub(/ *[0-9][0-9]*\.[0-9][0-9] s .*/, "")
            # Remove sequence number
            sub(/ *[0-9]*\/[0-9]* */, "")
            print | "sort"
            flag = 1
            next
        }
        flag { close "sort" }
        { print }
    ' < $tf > $SRCDIR/testsuite.log
    rm -f $tf
}

make_clean() {
    logmsg "--- make (dist)clean"
    [ -d $TMPDIR/$BUILDDIR ] && logcmd rm -rf $TMPDIR/$BUILDDIR
}

init
download_source $PROG $PROG $VER
patch_source
prep_build meson
build
clean_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
