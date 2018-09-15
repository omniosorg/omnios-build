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
. ../../lib/functions.sh

PROG=Python
VER=3.5.6
PKG=runtime/python-35
MVER=${VER%.*}
SUMMARY="$PROG $SMVER"
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
XFORM_ARGS="-D PYTHONVER=$MVER"

HARDLINK_TARGETS="
    usr/bin/python3.5
"

set_arch 64

export CCSHARED="-fPIC"
LDFLAGS64="-L/usr/gnu/lib/amd64 -R/usr/gnu/lib/amd64"
CPPFLAGS+=" -I/usr/include/ncurses -D_LARGEFILE64_SOURCE"
CPPFLAGS64="`pkg-config --cflags libffi`"
CC+=' -m64'
export DFLAGS=-64
MAKE_ARGS="
    DFLAGS=-64
    DESTSHARED=/usr/lib/python$MVER/lib-dynload
"
MAKE_INSTALL_ARGS=DESTSHARED=/usr/lib/python$MVER/lib-dynload

CONFIGURE_OPTS="
    --enable-shared
    --with-dtrace
    --with-system-ffi
    --with-system-expat
    --enable-ipv6
    --without-ensurepip
    ac_cv_func_getentropy=no
"

# We patch auto* files so need to re-generate
preprep_build() {
    run_autoheader
    run_autoconf
    # New file from dtrace patch
    chmod +x $TMPDIR/$BUILDDIR/Include/pydtrace_offsets.sh \
        || logerr "Could not set pydtrace_offsets.sh executable"
}

TESTSUITE_SED="
    1,/tests OK/ {
        /tests OK/p
        d
    }
"

launch_testsuite() {
    export EXTRATESTOPTS="-uall,-network,-audio,-gui,-largefile"
    # Some tests have non-ASCII characters
    _LC_ALL=$LC_ALL
    export LC_ALL=en_US.UTF-8
    LC_ALL=$LC_ALL run_testsuite "$@"
    export LC_ALL=$_LC_ALL
}

test_dtrace() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    $PFEXEC $SRCDIR/files/run-dtrace-tests | tee $SRCDIR/testsuite-d.log
    popd
}

init
download_source $PROG $PROG $VER
patch_source
preprep_build
prep_build
build
strip_install
launch_testsuite
test_dtrace
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
