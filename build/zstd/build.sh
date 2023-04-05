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

# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=zstd
VER=1.5.5
PKG=compress/zstd
SUMMARY="Zstandard"
DESC="Zstandard is a real-time compression algorithm, providing high "
DESC+="compression ratios."

BMI_EXPECTED=1

MAKE_INSTALL_TARGET="-C lib install"
base_MAKE_ARGS="
    PREFIX=$PREFIX
    MANDIR=$PREFIX/share/man
    INSTALL=$GNUBIN/install
"
pre_configure() {
    typeset arch=$1

    typeset tgt=lib-release
    case $arch in
        aarch64) tgt+=" zstd-release" ;&
        i386)
            MOREFLAGS="$CFLAGS ${CFLAGS[$arch]}"
            MAKE_INSTALL_ARGS_WS="$base_MAKE_ARGS MOREFLAGS=\"$MOREFLAGS\""
            MAKE_ARGS_WS="$base_MAKE_ARGS MOREFLAGS=\"$MOREFLAGS\" $tgt"
            ;;
        amd64)
            tgt+=" zstd-release"
            MOREFLAGS="$CFLAGS ${CFLAGS[$arch]}"
            MAKE_INSTALL_ARGS_WS="$base_MAKE_ARGS MOREFLAGS=\"$MOREFLAGS\"
                LIBDIR=$PREFIX/lib/$arch"
            MAKE_ARGS_WS="$base_MAKE_ARGS MOREFLAGS=\"$MOREFLAGS\"
                LIBDIR=$PREFIX/lib/$arch $tgt"
            ;;
        esac

        # No configure
        false
}

make_prog_aarch64() {
    CPPFLAGS+=" -I${SYSROOT[aarch64]}/usr/include" \
        make_arch aarch64
}

save_function make_install_amd64 _make_install_amd64
make_install_amd64() {
    _make_install_amd64 "$@"
    MAKE_INSTALL_TARGET="-C programs install" _make_install_amd64
    # With the current way that the makefile builds are set up, the library
    # is only built with the install target. Re-check the build-log for errors.
    check_buildlog 0
}

save_function make_install_aarch64 _make_install_aarch64
make_install_aarch64() {
    _make_install_aarch64 "$@"
    MAKE_INSTALL_TARGET="-C programs install"  _make_install_aarch64
    check_buildlog 0
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
