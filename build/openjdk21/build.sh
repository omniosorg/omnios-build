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
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=openjdk
VER=21.0.8+9
PKG=runtime/java/openjdk21
SUMMARY="openjdk ${VER%%.*}"
DESC="Open-source implementation of the twenty-first edition of the "
DESC+="Java SE Platform"

# The full jdk version string is:
#   feature.interim.update.patch.extra1.extra2.extra3-pre+build-opt
# We pass 'opt' explicitly to configure (see below) and currently don't parse
# the 'extra' values out of the version string.
if [[ $VER =~ ^([0-9]+)(\.([0-9]+))?(\.([0-9]+))?(\.([0-9]+))?\+([0-9]+)$ ]]
then
    V_FEATURE=${BASH_REMATCH[1]}
    V_INTERIM=${BASH_REMATCH[3]}
    V_UPDATE=${BASH_REMATCH[5]}
    V_PATCH=${BASH_REMATCH[7]}
    V_BUILD=${BASH_REMATCH[8]}
else
    logerr "Could not parse openjdk version $VER"
fi

# check ooce/fonts/liberation for current version
LIBERATIONFONTSVER=2.1.5
SKIP_LICENCES="SILv1.1"

set_arch 64

set_builddir "jdk${V_FEATURE}u-jdk-${VER//+/-}"

BMI_EXPECTED=1
SKIP_RTIME_CHECK=1
NO_SONAME_EXPECTED=1

BUILD_DEPENDS_IPS="
    system/header/header-audio
    runtime/java/openjdk21
    ooce/library/fontconfig
    ooce/library/freetype2
    ooce/print/cups
"

RUN_DEPENDS_IPS="runtime/java/jexec"

VERHUMAN="jdk${V_FEATURE}u${V_UPDATE}${V_PATCH:+.}$V_PATCH-b$V_BUILD"
IVER="$V_FEATURE.$V_INTERIM"

IROOT=usr/jdk/instances
IFULL=$IROOT/$PROG$IVER

OOCEPREFIX=/opt/ooce

XFORM_ARGS="
    -DVER=$V_FEATURE
    -DIVER=$IVER
    -DIROOT=$IROOT
    -DIFULL=$IFULL
    -DLFVER=$LIBERATIONFONTSVER
"

# The JDK build framework does not use the -j option to make.
NO_PARALLEL_MAKE=1

CONFIGURE_OPTS="
    --with-version-string=$VER
    --with-version-opt=$DISTRO_LC-$RELVER
    --with-toolchain-type=gcc
    --with-boot-jdk=/$IFULL
    --enable-deprecated-ports=yes
    --enable-headless-only
    --disable-ccache
    --with-native-debug-symbols=none
    --disable-warnings-as-errors
    --enable-unlimited-crypto
    --disable-dtrace
    --with-cacerts-file=/etc/ssl/java/cacerts
    --x-includes=$OOCEPREFIX/include
    --with-cups-include=$OOCEPREFIX/include
    --with-freetype=bundled
    --with-fontconfig-include=$OOCEPREFIX/include
    DATE=$GNUBIN/date
"
CONFIGURE_OPTS[amd64]+="
    --x-libraries=$OOCEPREFIX/lib/amd64
"
CONFIGURE_OPTS[amd64_WS]="
    --with-extra-cflags=\"$CFLAGS ${CFLAGS[amd64]}\"
    --with-extra-cxxflags=\"$CXXFLAGS ${CXXFLAGS[amd64]}\"
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
download_source $PROG "jdk-$VER"
patch_source

# Also download the liberation fonts archive. Fonts from here will be
# provided to satisfy the core fonts.
LFDIR=liberation-fonts-ttf-$LIBERATIONFONTSVER
BUILDDIR=$LFDIR download_source liberation-fonts $LFDIR

prep_build autoconf-like -oot
chmod +x $CONFIGURE_CMD
build -noctf
VER=${VER%%+*} DASHREV=$V_BUILD make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
