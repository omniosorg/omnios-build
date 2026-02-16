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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=vim
VER=9.1
PATCHLEVEL=2147
PKG=editor/vim
SUMMARY="Vi IMproved"
DESC="Advanced text editor that provides the power of the UNIX vi editor "
DESC+="with a more complete feature set."

SVER=${VER//./}
VER+=".$PATCHLEVEL"

set_arch 64
set_standard -xcurses XPG6

XFORM_ARGS+=" -D SVER=$SVER"

SKIP_LICENCES="*"

# zh_CN.cp936.po has invalid characters which GNU msgfmt seems to be able to
# ignore.
export MSGFMT=$GNUBIN/msgfmt

CONFIGURE_OPTS="
    --with-features=huge
    --without-x
    --disable-gui
    --disable-gtktest
"
CONFIGURE_OPTS[WS]="
    --with-compiledby=\"$DISTRO $RELVER\"
"
MAKE_INSTALL_ARGS="STRIP=/bin/true"
CPPFLAGS+=" -DSYS_VIMRC_FILE='\"/etc/vimrc\"'"

PKGDIFF_HELPER="
    s:$PROG[0-9][0-9]:${PROG}VER:
"

build_init() {
    for arch in $CROSS_ARCH; do
        CONFIGURE_OPTS[$arch]+="
            --with-tlib=ncurses
            vim_cv_toupper_broken=no
            ac_cv_sizeof_int=4
            vim_cv_bcopy_handles_overlap=yes
            vim_cv_memcpy_handles_overlap=no
            vim_cv_memmove_handles_overlap=yes
            vim_cv_getcwd_broken=no
            vim_cv_stat_ignores_slash=no
            vim_cv_terminfo=yes
            vim_cv_tgetent=zero
        "
        LDFLAGS[$arch]+=" -L${SYSROOT[$arch]}/lib"
        LDFLAGS[$arch]+=" -L${SYSROOT[$arch]}/usr/lib"
    done
}

init
download_source $PROG v$VER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
