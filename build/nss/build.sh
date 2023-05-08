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
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=nss
VER=3.89.1
PKG=system/library/mozilla-nss
SUMMARY="Network Security Services"
DESC="Network Security Services (NSS) is a set of libraries designed to "
DESC+="support cross-platform development of security-enabled client and "
DESC+="server applications."

BUILD_DEPENDS_IPS="library/nspr library/nspr/header-nspr"

set_ssp none
# required for getopt
set_standard XPG6

XFORM_ARGS+=" -DPREFIX=${PREFIX#/}"

CTF_FLAGS+=" -s"

SKIP_RTIME_CHECK=1
# The libraries are unversioned. Skip for now; worth further investigation.
NO_SONAME_EXPECTED=1

CONFIGURE_OPTS="
    -c
    -v
    --gyp
    --opt
    --gcc
    --disable-tests
    --system-sqlite
    --enable-legacy-db
    -Dsign_libs=0
"

CONFIGURE_OPTS[i386]="
    --target=ia32
    --with-nspr=/usr/include/mps:/usr/lib/mps
"
CONFIGURE_OPTS[amd64]="
    --target=x64
    --with-nspr=/usr/include/mps:/usr/lib/mps/amd64
"
CXXFLAGS[aarch64]+=" -mno-outline-atomics"

post_clean() {
    $TMPDIR/$EXTRACTED_SRC/build.sh -cc
}

build_init() {
    typeset sr=${SYSROOT[aarch64]}

    CONFIGURE_OPTS[aarch64]="
        --target=aarch64
        --with-nspr=$sr/usr/include/mps:/usr/lib/mps
    "
    LDFLAGS[aarch64]+=" --sysroot=$sr"
    LDFLAGS[aarch64]+=" -L$sr/usr/lib/mps"
}

# We drive the whole build from the configure step as this already sets up
# the environment the target-specific CFLAGS etc. and avoids having to
# duplicate that logic here.
pre_configure() {
    typeset arch=$1

    PATH+=:$OOCEBIN

    CONFIGURE_CMD=$TMPDIR/$EXTRACTED_SRC/build.sh
}

make_arch() { :; }

# There is no installation target so we need to copy things over by hand
make_install() {
    typeset arch=$1

    mandir=share/man/man1
    incdir=include/mps

    case $arch in
        amd64)  libdir=lib/mps/amd64 ;;
        *)      libdir=lib/mps ;;
    esac

    typeset dist=$TMPDIR/$BUILDDIR/../dist

    logcmd $MKDIR $DESTDIR/$PREFIX
    pushd $DESTDIR/$PREFIX >/dev/null || logerr "pushd"

    set -eE; trap 'logerr Installation failed at $BASH_LINENO' ERR

    logcmd $MKDIR -p bin $incdir $libdir $mandir
    logcmd $RSYNC -a $dist/public/nss/ $incdir/
    logcmd $RSYNC -a $dist/../nss/doc/nroff/ $mandir/

    logcmd $CP $dist/Release/lib/*.so $libdir/
    logcmd $CP $dist/Release/bin/* bin/

    for b in bin/*; do
        typeset p=`$ELFEDIT -e 'dyn:runpath -o simple' $b`
        logcmd $ELFEDIT -e "dyn:runpath $PREFIX/$libdir:$p" $b
    done
    for l in $libdir/*; do
        typeset p=`$ELFEDIT -e 'dyn:runpath -o simple' $l`
        logcmd $ELFEDIT -e "dyn:runpath \$ORIGIN:$p" $l
    done

    typeset nsprbuild=$SRCDIR/../nspr/build.sh
    typeset NSPRVER="`grep '^VER=' $nsprbuild | sed 's/.*=//;q'`"

    logcmd $MKDIR -p ${libdir/mps/}/pkgconfig
    $SED < $TMPDIR/$BUILDDIR/pkg/pkg-config/nss.pc.in \
        > ${libdir/mps/}/pkgconfig/nss.pc "
            s^%NSS_VERSION%^$VER^
            s^%NSPR_VERSION%^$NSPRVER^
            s^%prefix%^$PREFIX^
            s^%exec_prefix%^$PREFIX^
            s^%libdir%^$PREFIX/$libdir^
            s^%includedir%^$PREFIX/$incdir^
     "

    set +eE; trap - ERR

    popd >/dev/null

    hook post_install $arch
}

post_install() {
    manifest_start $TMPDIR/manifest.nss.header
    manifest_add_dir $PREFIX/include mps
    manifest_finalise $TMPDIR/manifest.nss.header $PREFIX

    manifest_uniq $TMPDIR/manifest.nss{,.header}
    manifest_finalise $TMPDIR/manifest.nss $PREFIX
}

init
download_source $PROG $PROG $VER
append_builddir /nss
patch_source
prep_build gyp+ninja
build

###########################################################################

make_package -seed $TMPDIR/manifest.nss

PKG=system/library/mozilla-nss/header-nss
SUMMARY+=" (headers)"
make_package -seed $TMPDIR/manifest.nss.header

###########################################################################

clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
