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

# Copyright 2011-2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=perl
PKG=runtime/perl
VER=5.42.0
MAJVER=${VER%.*}
SUMMARY="Perl $MAJVER Programming Language"
DESC="A highly capable, feature-rich programming language"

# https://github.com/arsv/perl-cross/releases
CROSSVER=1.6.2

set_arch 64
CTF_FLAGS+=" -s"

PREFIX=/usr/perl5/$MAJVER

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DPROG=$PROG
    -DVER=$VER
    -DVERSION=$MAJVER
"

# Perl bundles a lot of shared objects with its extensions
NO_SONAME_EXPECTED=1

HARDLINK_TARGETS="
    ${PREFIX#/}/bin/$PROG$VER
    ${PREFIX#/}/bin/${PROG}thanks
    ${PREFIX#/}/man/man1/${PROG}thanks.1
"

BUILD_DEPENDS_IPS="text/gnu-sed"

TESTSUITE_SED="
    /ExtUtils::Command/d
"

configure_amd64() {
    logmsg "--- configure (64-bit)"
    # A note about 'myuname'. In previous OmniOS releases this was set to be
    # undefined, but as of the r151041 bloody cycle it has been set to 'sunos'.
    # In particular, this makes some modules make better choices about things
    # like compiler flags (Crypt::OpenSSL:X509 is one), but there is a risk
    # that some modules might assume that myuname=='sunos' => Sun studio
    # rather than checking 'ccname'.
    logcmd $SHELL Configure \
        -des \
        -Dusethreads \
        -Duseshrplib \
        -Dusedtrace \
        -Dusemultiplicity \
        -Duselargefiles \
        -Duse64bitall \
        -Dmyhostname=localhost \
        -Umydomain \
        -Dmyuname=sunos \
        -Dcf_by=$DISTRO_LC-builder \
        -Dcf_email=$PUBLISHER_EMAIL \
        -Dcc=gcc \
        -Dld=/usr/ccs/bin/ld \
        -Doptimize="-O3 $CTF_CFLAGS" \
        -Dprefix=${PREFIX} \
        -Dvendorprefix=${PREFIX} \
        -Dbin=${PREFIX}/bin \
        -Dsitebin=${PREFIX}/bin \
        -Dvendorbin=${PREFIX}/bin \
        -Dscriptdir=${PREFIX}/bin \
        -Dsitescript=${PREFIX}/bin \
        -Dvendorscript=${PREFIX}/bin \
        -Dprivlib=${PREFIX}/lib \
        -Dsitelib=/usr/perl5/site_perl/$MAJVER \
        -Dvendorlib=/usr/perl5/vendor_perl/$MAJVER \
        -Ulocincpth= \
        -Uloclibpth= \
        -Dlibpth="/lib/amd64 /usr/lib/amd64" \
        -Dlibs="-lsocket -lnsl -lm -lc" \
        || logerr "--- Configure failed"

    logcmd sed -i "
        s/mydomain=\"\.undef\"/mydomain=\"undef\"/g
        s!^libpth=.*!libpth=\"/lib/amd64 /usr/lib/amd64\"!g
    " config.sh
}

configure_aarch64() {
    # perl-cross requires GNU tools
    export PATH="$GNUBIN:$PATH"

    patch_source patches-aarch64

    logmsg "--- configure (64-bit)"
    # A note about 'myuname'. In previous OmniOS releases this was set to be
    # undefined, but as of the r151041 bloody cycle it has been set to 'sunos'.
    # In particular, this makes some modules make better choices about things
    # like compiler flags (Crypt::OpenSSL:X509 is one), but there is a risk
    # that some modules might assume that myuname=='sunos' => Sun studio
    # rather than checking 'ccname'.
    logcmd $CONFIGURE_CMD \
        --target=${TRIPLETS[aarch64]} \
        --man1dir="$PREFIX/man/man1" \
        --man3dir="$PREFIX/man/man3" \
        --with-cc=gcc \
        --with-cpp="gcc -E" \
        --with-ld=gcc \
        --host-libs="m" \
        --host-set-osname=solaris \
        --host-cc=/opt/gcc-$DEFAULT_GCC_VER/bin/gcc \
        -Dccdlflags= \
        -Dusethreads \
        -Duseshrplib \
        -Dusemultiplicity \
        -Duselargefiles \
        -Duse64bitall \
        -Dmyhostname=localhost \
        -Umydomain \
        -Dmyuname=sunos \
        -Dosname=solaris \
        -Dcf_by=$DISTRO_LC-builder \
        -Dcf_email=$PUBLISHER_EMAIL \
        -Doptimize="-O3 $CTF_CFLAGS" \
        -Dprefix=${PREFIX} \
        -Dvendorprefix=${PREFIX} \
        -Dbin=${PREFIX}/bin \
        -Dsitebin=${PREFIX}/bin \
        -Dvendorbin=${PREFIX}/bin \
        -Dscriptdir=${PREFIX}/bin \
        -Dsitescript=${PREFIX}/bin \
        -Dvendorscript=${PREFIX}/bin \
        -Dprivlib=${PREFIX}/lib \
        -Dsitelib=/usr/perl5/site_perl/$MAJVER \
        -Dvendorlib=/usr/perl5/vendor_perl/$MAJVER \
        -Darchlib=${PREFIX}/lib/aarch64-solaris-64 \
        -Ulocincpth= \
        -Uloclibpth= \
        -Dlibpth="/lib /usr/lib" \
        -Dlibs="-lsocket -lnsl -lm -lc" \
        || logerr "--- Configure failed"

    logcmd sed -i "
        s/mydomain=\"\.undef\"/mydomain=\"undef\"/g
        s!^libpth=.*!libpth=\"/lib /usr/lib\"!g
        s/^d_setenv=.*/d_setenv='undef'/g
        s/^d_unsetenv=.*/d_unsetenv='undef'/g
        s/^ccdlflags=.*/ccdlflags=''/g
    " config.sh

    logcmd sed -i "
        s/^d_setenv=.*/d_setenv='undef'/g
        s/^d_unsetenv=.*/d_unsetenv='undef'/g
        s/^ccdlflags=.*/ccdlflags=''/g
    " xconfig.sh

    logcmd sed -i "
        s/^perl\$x: LDFLAGS += -Wl,-E/perl\$x: LDFLAGS += -lsocket/g
    " Makefile
}

pre_build() {
    ! cross_arch $1 && return

    save_variables BUILDDIR EXTRACTED_SRC
    set_builddir $PROG-cross-$CROSSVER
    download_source $PROG $PROG-cross $CROSSVER
    patch_source patches-$PROG-cross
    restore_variables BUILDDIR EXTRACTED_SRC

    logcmd $RSYNC -a $TMPDIR/$PROG-cross-$CROSSVER/* $TMPDIR/$PROG-$VER/ \
        || logerr "rsync perl-cross failed"

}

post_install() {
    ! cross_arch $1 && return

    logmsg "creating hardlink"
    logcmd $LN $DESTDIR/$PREFIX/bin/$PROG $DESTDIR/$PREFIX/bin/$PROG$VER \
        || logerr "creating hardlink failed"
}


init
download_source $PROG $PROG $VER
patch_source
prep_build
build
PATH="$GNUBIN:$PATH" run_testsuite
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
