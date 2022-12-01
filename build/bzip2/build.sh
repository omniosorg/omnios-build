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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=bzip2
VER=1.0.8
PKG=compress/bzip2
SUMMARY="The bzip compression utility"
DESC="A patent free high-quality data compressor"

SKIP_LICENCES=bzip2
XFORM_ARGS="-D VER=$VER"

forgo_isaexec

# We don't use configure, so explicitly export PREFIX
PREFIX=/usr
export PREFIX
export CC

base_CFLAGS="-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -Wall -Winline"

post_clean() {
    logcmd $MAKE -f Makefile-libbz2_so clean
}

# No configure
configure_arch() { :; }

pre_make() {
    typeset arch=${1:?arch}

    # We need to build the shared lib using a second Makefile
    logmsg "--- make (shared lib)"
    CFLAGS="-fPIC $CFLAGS ${CFLAGS[$arch]}" \
        LDFLAGS="$LDFLAGS ${LDFLAGS[$arch]}" \
        logcmd $MAKE $MAKE_JOBS -f Makefile-libbz2_so || \
        logerr "--- Make failed (shared lib)"

    save_variables CFLAGS LDFLAGS
    case $arch in
        i386)
            export BINISA=
            export LIBISA=
            export xCFLAGS="$CFLAGS ${CFLAGS[i386]} $base_CFLAGS"
            export xLDFLAGS="$LDFLAGS ${LDFLAGS[i386]}"
            ;;
        amd64)
            export BINISA=
            export LIBISA=amd64
            export xCFLAGS="$CFLAGS ${CFLAGS[amd64]} $base_CFLAGS"
            export xLDFLAGS="$LDFLAGS ${LDFLAGS[amd64]}"
            ;;
    esac
    unset CFLAGS LDFLAGS
    export CFLAGS="$xCFLAGS"
    export LDFLAGS="$xLDFLAGS"
}

post_make() {
    restore_variables CFLAGS LDFLAGS
}

post_install() {
    logcmd cp $TMPDIR/$BUILDDIR/bzip2-shared $DESTDIR/usr/bin/bzip2 \
        || logerr "Cannot copy shared bzip2 into place"
}

TESTSUITE_SED="
    /in business/q
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
