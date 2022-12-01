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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=Python
VER=2.7.18
PKG=runtime/python-27
SUMMARY="$PROG ${VER%.*}"
DESC="$SUMMARY"

set_python_version $PYTHON2VER

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
    developer/object-file
"
XFORM_ARGS="-D PYTHONVER=$PYTHONVER"

CC=gcc
CXX=g++

NO_SONAME_EXPECTED=1

export CCSHARED="-fPIC"
LDFLAGS[i386]+=" -L/usr/gnu/lib -R/usr/gnu/lib"
LDFLAGS[amd64]+=" -L/usr/gnu/lib/amd64 -R/usr/gnu/lib/amd64"
LDFLAGS+=" $SSPFLAGS"
CPPFLAGS+=" -I/usr/include/ncurses -D_LARGEFILE64_SOURCE"
CPPFLAGS[amd64]="`pkg-config --cflags libffi`"
CPPFLAGS[i386]="${CPPFLAGS[amd64]/amd64?/}"
CONFIGURE_OPTS="
    --enable-shared
    --with-dtrace
    --with-system-ffi
    --with-system-expat
    --enable-ipv6
    ac_cv_func_getentropy=no
"

preprep_build() {
    run_autoreconf -fi
    # New file from dtrace patch
    chmod +x $TMPDIR/$BUILDDIR/Include/pydtrace_offsets.sh \
        || logerr "Could not set pydtrace_offsets.sh executable"
}

# Need to set CC='$CC -m64' for 64-bit build
save_function configure_amd64 _configure_amd64
configure_amd64() {
    CC="$CC -m64" _configure_amd64
}

make_prog_i386() {
    logmsg "--- make"
    logcmd $MAKE $MAKE_JOBS DFLAGS=-32 || logerr "--- Make failed"
}

make_prog_amd64() {
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

make_install_i386() {
    make_install
    save_arch 32
    run_testsuite test "" testsuite-32.log
}

make_install_amd64() {
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
make_package -legacy
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
