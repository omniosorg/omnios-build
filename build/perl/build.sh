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
# Copyright 2011-2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
# We need this for the Sun assembler
LANG=C
export LANG
SHELL=/usr/bin/bash
export SHELL

# Load support functions
. ../../lib/functions.sh

case $DEPVER in
    "")
        DEPVER=5.26.2
        logmsg "no version specified, using $DEPVER"
        ;;
esac

PROG=perl
VER=$DEPVER
NODOTVER=$(echo $DEPVER| sed -e's/\.//g;')
SVER=${VER%.*}
PKG=runtime/perl-$NODOTVER ##IGNORE##
SUMMARY="Perl $SVER Programming Language"
DESC="$SUMMARY"
PREFIX=/usr/perl5/${SVER}

BUILD_DEPENDS_IPS="text/gnu-sed"

TESTSUITE_SED="
    /ExtUtils::Command/d
"

#
# Perl build configuration options that are common to each
# of the 32 and 64 bit variants.
#
PERL_BUILD_OPTS_COMMON="-des \
    -Dusethreads \
    -Duseshrplib \
    -Dusedtrace \
    -Dusemultiplicity \
    -Duselargefiles \
    -Duse64bitint \
    -Dmyhostname=localhost \
    -Umydomain \
    -Umyuname \
    -Dcf_by=omnios-builder \
    -Dcf_email=sa@omniosce.org \
    -Dcc=gcc \
    -Dld=/usr/ccs/bin/ld \
    -Doptimize=-O3"

filelist() {
    pushd $DESTDIR > /dev/null
    logmsg "Creating file list"

    find . | cut -c3- | sed '/^$/d' | sort > $TMPDIR/$1
    popd > /dev/null
}

mkmog() {
    while read f; do
        echo "<transform file dir link hardlink path=^$f\$ -> drop>"
    done
}

build_mogs() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building MOG files"

    # perl.32.bit
    # perl.all.bit

    # 64-bit-only files
    comm -13 $TMPDIR/perl.32.bit $TMPDIR/perl.all.bit > $TMPDIR/files.64

    # man/pod files
    egrep '/man/|\.pod$' $TMPDIR/perl.32.bit > $TMPDIR/files.doc

    # 32-bit only files (remove docs)
    fgrep -vf $TMPDIR/files.doc $TMPDIR/perl.32.bit > $TMPDIR/files.32

    # Perl package (no docs, no 64-bit)
    cat $TMPDIR/files.{64,doc} | mkmog > $TMPDIR/perl.mog

    # Doc package (docs only)
    cat $TMPDIR/files.{32,64} | mkmog > $TMPDIR/perl-docs.mog

    # 64-bit package
    cat $TMPDIR/files.{32,doc} | mkmog > $TMPDIR/perl-64.mog

    popd > /dev/null
}

links() {
    logmsg "Creating symlinks"
    logcmd mkdir -p $DESTDIR/usr/bin
    logcmd mkdir -p $DESTDIR/usr/perl5/bin

    find $DESTDIR/$PREFIX/bin -maxdepth 1 -type f -perm -o+x | while read path
    do
        file=$(basename $path)

        [ "$file" = "perl$VER" ] && lfile=perl$SVER || lfile=$file
        logcmd ln -s \
            ../perl5/${SVER}/bin/$file $DESTDIR/usr/bin/$lfile
        logcmd ln -s \
            ../${SVER}/bin/$file $DESTDIR/usr/perl5/bin/$lfile
    done
}

build32() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building 32-bit"

    logmsg "--- make (dist)clean"
    logcmd make distclean || \
        logmsg "--- *** WARNING *** make (dist)clean Failed"

    logmsg "--- configure (32-bit)"
    logcmd $SHELL Configure ${PERL_BUILD_OPTS_COMMON} \
        -Dccflags="-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_TS_ERRNO" \
        -Dprefix=${PREFIX} \
        -Dvendorprefix=${PREFIX} \
        -Dbin=${PREFIX}/bin/${ISAPART} \
        -Dsitebin=${PREFIX}/bin/${ISAPART} \
        -Dvendorbin=${PREFIX}/bin/${ISAPART} \
        -Dscriptdir=${PREFIX}/bin \
        -Dsitescript=${PREFIX}/bin \
        -Dvendorscript=${PREFIX}/bin \
        -Dprivlib=${PREFIX}/lib \
        -Dsitelib=/usr/perl5/site_perl/${SVER} \
        -Dvendorlib=/usr/perl5/vendor_perl/${SVER} \
        || logerr "--- Configure failed"
    logcmd gsed -i 's/-fstack-protector-strong//g;' config.sh

    logmsg "--- make"
    logcmd gmake -j 8 || \
    logcmd gmake || \
        logerr "--- Make failed"

    run_testsuite test

    logmsg "--- make install"
    logcmd gmake install DESTDIR=${DESTDIR} || \
        logerr "--- Make install failed"

    # We make the isastubs after 32bit so we can see them in the file list
    make_isa_stub

    # Similarly for the links to usr/bin etc.
    links

    filelist perl.32.bit
    popd > /dev/null
}

build64() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building 64-bit"

    logmsg "--- make (dist)clean"
    logcmd make distclean || \
        logmsg "--- *** WARNING *** make (dist)clean Failed"

    logmsg "--- configure (64-bit)"
    logcmd $SHELL Configure ${PERL_BUILD_OPTS_COMMON} \
        -Dccflags="-D_LARGEFILE64_SOURCE -m64 -D_TS_ERRNO" \
        -Dlddlflags="-G -64" \
        -Dprefix=${PREFIX} \
        -Dvendorprefix=${PREFIX} \
        -Dbin=${PREFIX}/bin/${ISAPART64} \
        -Dsitebin=${PREFIX}/bin/${ISAPART64} \
        -Dvendorbin=${PREFIX}/bin/${ISAPART64} \
        -Dscriptdir=${PREFIX}/bin \
        -Dsitescript=${PREFIX}/bin \
        -Dvendorscript=${PREFIX}/bin \
        -Dprivlib=${PREFIX}/lib \
        -Dsitelib=/usr/perl5/site_perl/${SVER} \
        -Dvendorlib=/usr/perl5/vendor_perl/${SVER} \
        || logerr "--- Configure failed"
    logcmd gsed -i 's/-fstack-protector-strong//g;' config.sh
    logcmd gsed -i 's/mydomain="\.undef"/mydomain="undef"/g;' config.sh
    logcmd gsed -i -e '/^lddlflags/{s/-G -m64//;}' config.sh

    logmsg "--- make"
    logcmd gmake -j 8 || \
    logcmd gmake || \
        logerr "--- Make failed"

    run_testsuite test "" "testsuite64.log"

    logmsg "--- make install"
    logcmd gmake install DESTDIR=${DESTDIR} || \
        logerr "--- Make install failed"

    pushd $DESTDIR/$PREFIX/bin > /dev/null
    logcmd gsed -i "s:usr/perl5/${SVER}/bin/amd64:usr/perl5/${SVER}/bin:g" \
        `find . -type f | xargs file | grep script | cut -f1 -d:`
    popd > /dev/null
    popd > /dev/null
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
filelist perl.all.bit
build_mogs

PKG=runtime/perl
SUMMARY="Perl $SVER Programming Language"
DESC="$SUMMARY"
DEPENDS_IPS="system/library/g++-runtime system/library/math system/library"
make_package $TMPDIR/perl.mog

PKG=runtime/perl/manual
SUMMARY="Perl $SVER Programming Language Docs"
DESC="$SUMMARY"
DEPENDS_IPS="=runtime/perl@${VER},${SUNOSVER}-${PVER} runtime/perl@${VER},${SUNOSVER}-${PVER}"
HARDLINK_TARGETS="usr/perl5/$SVER/man/man1/perlbug.1"
make_package $TMPDIR/perl-docs.mog

PKG=runtime/perl-64
SUMMARY="Perl $SVER Programming Language (64-bit)"
DESC="$SUMMARY"
DEPENDS_IPS="=runtime/perl@${VER},${SUNOSVER}-${PVER} runtime/perl@${VER},${SUNOSVER}-${PVER}"
HARDLINK_TARGETS=
make_package $TMPDIR/perl-64.mog

clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
