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

. ../../lib/functions.sh

PROG=openjdk
VER=11
UPDATE=15
BUILD=10
PKG=runtime/java/openjdk11
SUMMARY="openjdk $VER"
DESC="Open-source implementation of the eleventh edition of the "
DESC+="Java SE Platform"

# check ooce/fonts/liberation for current version
LIBERATIONFONTSVER=2.1.5
SKIP_LICENCES="SILv1.1"

set_arch 64

set_builddir "jdk${VER}u-jdk-$VER.0.$UPDATE-$BUILD"

BMI_EXPECTED=1
SKIP_RTIME_CHECK=1

BUILD_DEPENDS_IPS="
    system/header/header-audio
    runtime/java/openjdk11
    ooce/library/fontconfig
    ooce/library/freetype2
    ooce/print/cups
"

VERHUMAN=jdk${VER}u${UPDATE}-b$BUILD
IVER=${VER}.0

IROOT=usr/jdk/instances
IFULL=$IROOT/$PROG$IVER

OOCEPREFIX=/opt/ooce

XFORM_ARGS="
    -DVER=$VER
    -DIVER=$IVER
    -DIROOT=$IROOT
    -DIFULL=$IFULL
    -DLFVER=$LIBERATIONFONTSVER
"

# The JDK build framework does not use the -j option to make.
NO_PARALLEL_MAKE=1

CONFIGURE_OPTS="
    --with-version-update=$UPDATE
    --with-version-build=$BUILD
    --with-version-pre=
    --with-version-opt=omnios-$RELVER
    --with-toolchain-type=gcc
    --with-boot-jdk=/$IFULL
    --enable-headless-only
    --disable-ccache
    --with-native-debug-symbols=none
    --disable-warnings-as-errors
    --enable-unlimited-crypto
    --disable-hotspot-gtest
    --disable-dtrace
    --with-cacerts-file=/etc/ssl/java/cacerts
    --x-includes=$OOCEPREFIX/include
    --x-libraries=$OOCEPREFIX/lib/$ISAPART64
    --with-cups-include=$OOCEPREFIX/include
    --with-freetype=bundled
    --with-fontconfig-include=$OOCEPREFIX/include
"

MAKE_ARGS="all"

make_install() {
    logmsg "Installing openjdk to $DESTDIR"

    logcmd mkdir -p $DESTDIR/$IFULL || logerr "--- mkdir failed"
    logcmd rsync -a $TMPDIR/$BUILDDIR/images/jdk/ $DESTDIR/$IFULL/ \
        || logerr "--- rsync failed"

    # Install liberation fonts to cover the 'core fonts' set
    # See also patches/fontpath.patch
    DDIR=$DESTDIR/$IFULL/lib/fonts
    logcmd mkdir -p $DDIR || logerr "mkdir fonts"
    logcmd cp $TMPDIR/$LFDIR/Liberation*.ttf $DDIR \
        || logerr "failed to copy fonts"
}

init
download_source $PROG "jdk-$VER.0.$UPDATE+$BUILD"
patch_source

# Also download the liberation fonts archive. Fonts from here will be
# provided to satisfy the core fonts.
LFDIR=liberation-fonts-ttf-$LIBERATIONFONTSVER
BUILDDIR=$LFDIR download_source liberation-fonts $LFDIR

prep_build autoconf -oot
chmod +x $CONFIGURE_CMD
build -noctf
VER=$IVER.$UPDATE DASHREV=$BUILD make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
