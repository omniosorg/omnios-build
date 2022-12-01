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

# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=glib
VER=2.74.2
PKG=library/glib2
SUMMARY="GNOME utility library"
DESC="The GNOME general-purpose utility library"

RUN_DEPENDS_IPS="
    runtime/python-$PYTHONPKGVER
    runtime/perl
"

# ninja does not support the --quiet option
MAKE_TESTSUITE_ARGS=

# use GNU msgfmt; otherwise the build fails
PATH="$GNUBIN:$PATH:$OOCEBIN"

# With gcc 6 and above, -Werror_format=2 produces errors like:
#   error: format not a string literal, arguments not checked
# Tell configure that this flag doesn't exist for the compiler.
CFLAGS+=" -Wno-error=format-nonliteral -Wno-error=format=2"

# Required to enable the POSIX variants of getpwuid_r and getpwnam_r
# See comment in /usr/include/pwd.h
set_standard POSIX

LDFLAGS+=" -Wl,-z,ignore"
LDFLAGS[i386]+=" -lssp_ns"

CONFIGURE_OPTS="
    --prefix=$PREFIX
    -Dxattr=false
    -Dforce_posix_threads=true
    -Ddtrace=false
    -Db_asneeded=false
"
CONFIGURE_OPTS[i386]="
    --bindir=$PREFIX/bin
    --libdir=$PREFIX/lib
"
CONFIGURE_OPTS[amd64]="
    --bindir=$PREFIX/bin
    --libdir=$PREFIX/lib/amd64
"

clean_testsuite() {
    local tf=testsuite.log.$$
    run_testsuite test "" $tf
    [ -s $SRCDIR/$tf ] && nawk '
        # Strip failed test output
        /^The output from .* first failed/,/Summary of Failures/ { next }
        /^Full log written/ { exit }
        # Found a test
        /^ *[0-9][0-9]*\/[0-9][0-9]* / {
            # Remove elapsed time
            sub(/ *[0-9][0-9]*\.[0-9][0-9]* *s/, "")
            # Remove sequence number
            sub(/ *[0-9]*\/[0-9]* */, "")
            if (trailer)
                print
            else
                print | "sort"
            next
        }
        /Summary of Failures/ {
            close "sort"
            trailer = 1
            print ""
        }
        trailer { print }
    ' < $SRCDIR/$tf > $SRCDIR/testsuite.log
    logcmd mv $SRCDIR/$tf $TMPDIR/
}

fix_rpaths() {
    # A recent update to Meson has resulted in the libraries ending up with
    # populated runpaths which causes the illumos build check_rtime to
    # (rightly) complain. Strip them here.
    fd lib $DESTDIR -e so | while read so; do
        logcmd /usr/bin/elfedit -e 'dyn:delete RUNPATH' $so
        logcmd /usr/bin/elfedit -e 'dyn:delete RPATH' $so
    done
}

init
download_source $PROG $PROG $VER
patch_source
prep_build meson
build
fix_rpaths
clean_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
