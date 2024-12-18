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
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=Python
VER=3.13.1
PKG=runtime/python-313
MVER=${VER%.*}
SUMMARY="$PROG $MVER"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="
    developer/build/autoconf
    developer/pkg-config
    ooce/developer/autoconf-archive
"
# The python ctypes module runs '/usr/bin/dump' from here.
RUN_DEPENDS_IPS="
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

# To expose the CMSG_ macros and new recvmsg() semantics for the socket module
set_standard XPG6

# Save arguments to the stack so that the mdb/pstack plugin can find them.
CFLAGS[amd64]+=" -msave-args"
CFLAGS[aarch64]+=" -mtls-dialect=trad"

export CCSHARED="-fPIC"
CPPFLAGS+=" -I/usr/include/ncurses"
export DFLAGS=-64
MAKE_ARGS="
    DFLAGS=-64
    DESTSHARED=/usr/lib/python$MVER/lib-dynload
"
MAKE_INSTALL_ARGS=DESTSHARED=/usr/lib/python$MVER/lib-dynload

CONFIGURE_OPTS="
    --enable-shared
    --with-system-expat
    --enable-ipv6
    --without-ensurepip
"

CONFIGURE_OPTS[amd64]+="
    --enable-optimizations
    --with-dtrace
"

CONFIGURE_OPTS[aarch64]+="
    --build=${TRIPLETS[amd64]%.*}
    --with-build-python=$PYTHON
    ac_cv_file__dev_ptmx=yes
    ac_cv_file__dev_ptc=no
"

# See https://bugs.python.org/issue25003
# There is (was?) a bug in Python which massively slowed down os.urandom()
# due to the introduction of a call to getentropy() which blocks until there
# is sufficient entropy, and this affected pkg(7) significantly.
# We tell Python that we don't have getentropy(); Solaris does the same.
CONFIGURE_OPTS+=" ac_cv_func_getentropy=no "

# hstrerror() is present in -lresolv, but if configure decides it's available
# then it uses it in a number of modules, which then don't link.
# Versions of Python < 3.11 did not detect this function but the new checks
# in 3.11 are less robust and think it's there even when it isn't.
# https://github.com/python/cpython/issues/89886#issuecomment-1106100113
CONFIGURE_OPTS+=" ac_cv_func_hstrerror=no"

# XXX
CONFIGURE_OPTS+=" ac_cv_readline_rl_startup_hook_takes_args=no"

export DTRACE_CPP=$GCCPATH/bin/cpp

CURSES_CFLAGS="-DHAVE_NCURSESW -D_XOPEN_SOURCE_EXTENDED"
LIBREADLINE_LIBS="-zrecord -lreadline -lncurses"
export CURSES_CFLAGS LIBREADLINE_LIBS

build_init() {
    typeset s=${SYSROOT[aarch64]}

    addpath PKG_CONFIG_PATH[aarch64] $s/usr/lib/pkgconfig
    CONFIGURE_OPTS[aarch64]+=" --with-openssl=$s/usr"
}

pre_configure() {
    typeset arch="$1"

    save_variable CC

    PKG_CONFIG_PATH="${PKG_CONFIG_PATH[$arch]}" \
        PANEL_LIBS=`pkg-config --libs panel`
    export PANEL_LIBS

    ! cross_arch $arch && return

    CC+=" --sysroot=${SYSROOT[$arch]}"
}

post_configure() {
    restore_variable CC
}

post_install() {
    python_compile \
        -o0 -o1 -o2 \
        -x 'bad_coding|badsyntax|site-packages|lib2to3/tests/data'
}

TESTSUITE_SED="
    1,/Tests result:/ {
        /Tests result:/p
        d
    }
    / slowest tests:/,/^$/d
    /Total duration/d
    /^make:/d
"

launch_testsuite() {
    # Test selection
    EXTRATESTOPTS="-uall,-audio,-gui,-largefile,-network -w"
    EXTRATESTOPTS+=" --ignorefile $SRCDIR/files/test.exclude"
    export EXTRATESTOPTS
    if [ -z "$SKIP_TESTSUITE" ] && ( [ -n "$BATCH" ] || ask_to_testsuite ); then
        # The compilall test (rightly) gets upset if we force timestamps
        save_variable FORCE_PYC_TIMESTAMP
        unset FORCE_PYC_TIMESTAMP
        BATCH=1 run_testsuite "$@" </dev/null
        restore_variable FORCE_PYC_TIMESTAMP
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
        # Reset ownership on the python cache directories/files which will
        # have been created with root ownership.
        $PFEXEC chown -R "`stat -c %U $SRCDIR`" .
        popd >/dev/null
    done
    sed "$TESTSUITE_SED" < $logf > $SRCDIR/testsuite-d.log
    [ -s $SRCDIR/testsuite-d.log ] \
        || echo "dtrace tests have failed" >> $SRCDIR/testsuite-d.log
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
