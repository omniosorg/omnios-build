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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=Python
VER=3.10.7
PKG=runtime/python-310
MVER=${VER%.*}
SUMMARY="$PROG $MVER"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="
    developer/build/autoconf
    developer/pkg-config
    ooce/developer/autoconf-archive
"
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
XFORM_ARGS="-D PYTHONVER=$MVER"

HARDLINK_TARGETS="
    usr/bin/python$MVER
"
SKIP_RTIME_CHECK=1
NO_SONAME_EXPECTED=1

set_python_version $MVER
set_arch 64

export CCSHARED="-fPIC"
CPPFLAGS+=" -I/usr/include/ncurses -D_LARGEFILE64_SOURCE"
CPPFLAGS+=" -DSKIP_ZIP_PATH"
CPPFLAGS64="`pkg-config --cflags libffi`"
CC+=' -m64'
export DFLAGS=-64
MAKE_ARGS="
    DFLAGS=-64
    DESTSHARED=/usr/lib/python$MVER/lib-dynload
"
MAKE_INSTALL_ARGS=DESTSHARED=/usr/lib/python$MVER/lib-dynload
# When building the standard library, there is only a bootstrap version of
# some modules around. The system setuptools package uses functions that
# are not present in that bootstrap so we tell the build to use the internal
# version.
# https://github.com/pypa/setuptools/issues/3007
export SETUPTOOLS_USE_DISTUTILS=stdlib

CONFIGURE_OPTS="
    --enable-shared
    --with-dtrace
    --with-system-ffi
    --with-system-expat
    --enable-ipv6
    --without-ensurepip
    --enable-optimizations
    ac_cv_func_getentropy=no
"

TESTSUITE_SED="
    1,/tests* OK/ {
        /tests* OK/p
        d
    }
    /Total duration/d
"

launch_testsuite() {
    # Test selection
    EXTRATESTOPTS="-uall,-audio,-gui,-largefile,-network"
    EXTRATESTOPTS+=" --ignorefile $SRCDIR/files/test.exclude"
    # Run single-threaded
    EXTRATESTOPTS+=" -j 1"
    export EXTRATESTOPTS
    if [ -z "$SKIP_TESTSUITE" ] && ( [ -n "$BATCH" ] || ask_to_testsuite ); then
        # Some tests have non-ASCII characters
        _LC_ALL=$LC_ALL
        export LC_ALL=en_US.UTF-8
        BATCH=1 LC_ALL=$LC_ALL run_testsuite "$@" < /dev/null
        export LC_ALL=$_LC_ALL
    else
        SKIP_TESTSUITE=1    # skip the dtrace tests too
    fi
}

test_dtrace() {
    # Dtrace tests require elevated privileges. They will have been skipped
    # as part of the full testsuite run.

    [ -n "$SKIP_TESTSUITE" ] && return

    typeset logf=$TMPDIR/testsuite-d.log
    :> $logf
    for dir in $TMPDIR/$BUILDDIR; do
        pushd $dir >/dev/null || logerr "chdir $dir"
        $PFEXEC $MAKE test TESTOPTS=test_dtrace | tee -a $logf
        # Reset ownership on the python 3 cache directories/files which will
        # have been created with root ownership.
        $PFEXEC chown -R "`stat -c %U $SRCDIR`" .
        popd >/dev/null
    done
    sed "$TESTSUITE_SED" < $logf > $SRCDIR/testsuite-d.log
}

save_function build _build
build() {
    logcmd rsync -ac --delete $TMPDIR/$BUILDDIR{,.debug}/ \
        || logerr "Failed to create debug copy of build directory"

    note -n "Building prod $PROG"
    logcmd rm -rf $DESTDIR.prod
    logcmd mkdir -p $DESTDIR.prod
    DESTDIR+=".prod" _build

    note -n "Building debug $PROG"
    CONFIGURE_OPTS=${CONFIGURE_OPTS/enable-optimizations/disable-optimizations}
    pushd $TMPDIR/$BUILDDIR.debug >/dev/null
    patch_file patches ustack.patch
    popd >/dev/null
    logcmd rm -rf $DESTDIR.debug
    logcmd mkdir -p $DESTDIR.debug
    BUILDDIR+=".debug" DESTDIR+=".debug" _build

    # The packages built from these two destination trees will be merged
    # after publication using a variant to separate them. We want files which
    # are identical across the trees to only appear once in the package and
    # without a variant tag; therefore they must match in all attributes
    # including timestamp. Go through and update the debug package timestamps
    # to match the production one. This is only necessary for python modules
    # since only these get published with timestamps.
    find "$DESTDIR.debug" -type f -name \*.py | while read f; do
        pf="${f/.debug/.prod}"
        [ -f "$pf" ] && logcmd touch -r "$pf" "$f"
    done
}

save_function make_package _make_package
make_package() {
    save_variable PKGSRVR
    for variant in prod debug; do
        note -n "Publishing $variant $PROG"
        repo=$TMPDIR/repo.$variant
        PKGSRVR=file://$repo
        logcmd rm -rf $repo
        init_repo
        if [ $variant = debug ]; then
            DESTDIR+=".$variant" SKIP_PKG_DIFF=1 BATCH=1 _make_package
        else
            DESTDIR+=".$variant" SKIP_PKG_DIFF=1 _make_package
        fi
    done
    restore_variable PKGSRVR

    note -n "Merging prod and debug packages"

    logcmd pkgmerge -d $PKGSRVR \
        -s debug.python=false,$TMPDIR/repo.prod/ \
        -s debug.python=true,$TMPDIR/repo.debug/ \
        || logerr "pkgmerge failed"

    [ -z "$SKIP_PKG_DIFF" ] && diff_latest $PKG
}

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf -autoreconf
build
launch_testsuite
test_dtrace
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
