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
# Load support functions
. ../../lib/functions.sh

PROG=Python
VER=2.7.15
PKG=runtime/python-27
SUMMARY="$PROG ${VER%.*}"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="developer/build/autoconf developer/pkg-config"
RUN_DEPENDS_IPS="
    compress/bzip2
    database/sqlite-3
    library/expat
    library/libffi
    library/libxml2
    library/ncurses
    library/readline
    library/security/openssl
    library/zlib
    system/library/gcc-runtime
"
XFORM_ARGS="-D PYTHONVER=$PYTHONVER"

CC=gcc
CXX=g++

export CCSHARED="-fPIC"
LDFLAGS32="-L/usr/gnu/lib -R/usr/gnu/lib"
LDFLAGS64="-L/usr/gnu/lib/amd64 -R/usr/gnu/lib/amd64"
CPPFLAGS+=" -I/usr/include/ncurses -D_LARGEFILE64_SOURCE"
CPPFLAGS64="`pkg-config --cflags libffi`"
CPPFLAGS32="${CPPFLAGS64/amd64?/}"
CONFIGURE_OPTS="
    --enable-shared
    --with-dtrace
    --with-system-ffi
    --with-system-expat
    --enable-ipv6
    ac_cv_func_getentropy=no
"

preprep_build() {
    run_autoheader
    run_autoconf
    # New file from dtrace patch
    chmod +x $TMPDIR/$BUILDDIR/Include/pydtrace_offsets.sh \
        || logerr "Could not set pydtrace_offsets.sh executable"
}

# Need to set CC='$CC -m64' for 64-bit build
save_function configure64 _configure64
configure64() {
    CC="$CC -m64" _configure64
}

make_prog32() {
    logmsg "--- make"
    logcmd $MAKE $MAKE_JOBS DFLAGS=-32 || logerr "--- Make failed"
}

make_prog64() {
    logmsg "--- make"
    logcmd $MAKE $MAKE_JOBS DFLAGS=-64 \
        DESTSHARED=/usr/lib/python2.7/lib-dynload || logerr "--- Make failed"
}

# Two parts of python are architecture dependant. This function saves the
# installed versions after each arch build for later manipulation.
save_arch() {
    bits=$1
    pushd $DESTDIR > /dev/null || logerr "cd $DESTDIR"
    # Save arch-specific sysconfigdata
    mv usr/lib/python2.7/_sysconfigdata{.py,-$bits.py} \
        || logerr "Cannot archive $bits-bit sysconfigdata"
    # Save arch-specific pyconfig.h
    mv usr/include/python2.7/pyconfig{.h,-$bits.h} \
        || logerr "Cannot archive $bits-bit pyconfig.h"
    popd > /dev/null
}

generate_archdeps() {
    # Copy in arch-detecting pyconfig.h
    cp $SRCDIR/files/pyconfig.h $DESTDIR/usr/include/python2.7/pyconfig.h \
        || logerr "Cannot install pyconfig.h"

    # Generate 32/64-bit agile _sysconfigdata.py
    pushd $DESTDIR/usr/lib/python2.7 > /dev/null || logerr "Cannot cd"
    cat << EOM > _sysconfigdata.py
import sys

if sys.maxsize > 2**32:
`sed 's/^/    /' < _sysconfigdata-64.py`
else:
`sed 's/^/    /' < _sysconfigdata-32.py`
EOM
    [ -f _sysconfigdata.pyc ] && rm -f _sysconfigdata.pyc
    popd > /dev/null
}

TESTSUITE_SED="
    s/.*load avg: .*\] /  /
    /DeprecationWarning.*exc_clear/d
    s/ passed in [0-9].*//
    /No differences encountered/d
"

make_install32() {
    make_install
    save_arch 32
    run_testsuite test "" testsuite-32.log
}

make_install64() {
    logmsg "--- make install (64)"
    logcmd $MAKE DESTDIR=${DESTDIR} install \
        DESTSHARED=/usr/lib/python2.7/lib-dynload || \
        logerr "--- Make install failed"
    save_arch 64
    run_testsuite
}

init
download_source $PROG $PROG $VER
patch_source
preprep_build
prep_build
build
generate_archdeps
make_isa_stub
strip_install
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
