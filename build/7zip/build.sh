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

. ../../lib/build.sh

PROG=7zip
VER=24.09
PKG=compress/7zip
SUMMARY="The 7-Zip compression and archiving utility"
DESC="7-Zip is a file archiver with a high compression ratio"

set_arch 64

BUNDLEDIR=CPP/7zip/Bundles/Alone2

SKIP_SSP_CHECK=1
SKIP_LICENCES=unRar

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
"

pre_configure() {
    typeset arch=$1

    # Specifying a debug build means that the symbol table will not be stripped
    MAKE_ARGS="DEBUG_BUILD=1"

    case $arch in
        amd64)
            # In order to use `gcc_x64` which uses assembly components
            # we would need either `asmc` or `uasm`. For now, use
            # plain `gcc` which skips the assembly.
            tmpl=gcc
            odir=g
            ;;
        aarch64)
            # On the other hand, in aarch64 we /can/ use the optimised
            # assembly since it is in GNU assembler syntax.
            tmpl=gcc_arm64
            odir=g_arm64
            ;;
        *)
            logerr "Unknown arch $arch"
            ;;
    esac

    # Specifying a debug build means that the symbol table will not be stripped
    MAKE_ARGS+=" -f ../../cmpl_$tmpl.mak"
    MAKE_ARGS+=" CC=$CC"
    MAKE_ARGS+=" CXX=$CXX"

    # There is no real configure program
    false
}
pre_make() { pushd $BUNDLEDIR; }
post_make() { popd; }

make_install() {
    logcmd $MKDIR -p $DESTDIR/$PREFIX/bin
    logcmd $CP $BUNDLEDIR/b/$odir/7zz $DESTDIR/$PREFIX/bin/7zz \
        || logerr "Cannot copy 7zz"
}

init
download_source -nodir $PROG 7z${VER//./}-src
patch_source
prep_build
build  -noctf    # C++
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
