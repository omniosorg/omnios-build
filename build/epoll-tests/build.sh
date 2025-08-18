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

PROG=epoll-test-suite
VER=20240808
PKG=system/test/epolltest
SUMMARY="epoll Test Suite"
DESC="Various functional and stress tests designed to verify the operation of "
DESC+="an epoll implementation."

# Respect environmental overrides for these to ease development.
: ${SOURCE_REPO:=$OOCEGITHUB/$PROG}
: ${SOURCE_BRANCH:=$VER}

SUBDIRS="functional stress"
PREFIX=/opt
INSTDIR=$PREFIX/epoll-tests

RUN_DEPENDS_IPS+=" system/test/testrunner"
SKIP_SSP_CHECK=1

XFORM_ARGS+="
    -DPREFIX=${PREFIX#/}
    -DINSTDIR=${INSTDIR#/}
"

clone_source() {
    clone_github_source $PROG "$SOURCE_REPO" "$SOURCE_BRANCH" "$EPOLL_TEST_CLONE"
    append_builddir $PROG
    ((EXTRACT_MODE)) && exit
}

pre_configure() { false; }

make_clean() {
    for dir in $SUBDIRS; do
        logmsg "-- cleaning $dir"
        logcmd $MAKE -C $dir clean
    done
}

save_function make_arch _make_arch
make_arch() {
    typeset arch=$1

    for dir in $SUBDIRS; do
        logmsg "-- building $dir tests"
        MAKE_ARGS+=" -C $dir" _make_arch $arch
    done
}

make_install() {
    logcmd $MKDIR -p $DESTDIR/$INSTDIR || logerr "Failed to create $INSTDIR"
    for dir in $SUBDIRS; do
        tgt=$DESTDIR/$INSTDIR/tests/$dir
        logcmd $MKDIR -p $tgt || logerr "Failed to create $tgt"
        for xf in $dir/*; do
            [ -x "$xf" ] || continue
            logcmd $CP $xf $tgt/ || logerr "Failed to copy $xf"
        done
    done
}

init
clone_source
patch_source
prep_build
build -noctf
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
