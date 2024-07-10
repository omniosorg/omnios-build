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

# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=coreutils
VER=9.5
PKG=file/gnu-coreutils
SUMMARY="coreutils - GNU core utilities"
DESC="GNU core utilities"

BUILD_DEPENDS_IPS="compress/xz library/gmp"

PREFIX=/usr/gnu

# We ship 64-bit binaries under $GNUBIN/ with selected ones linked back
# to /usr/bin/, but we need to continue building dual arch so that the
# 32-bit libstdbuf.so is available. This enables the stdbuf command to
# work with 32-bit binaries.
forgo_isaexec

set_standard XPG6 CFLAGS

# hardlinks are defined in local.mog
SKIP_HARDLINK=1

CPPFLAGS="-I/usr/include/gmp"
CONFIGURE_OPTS+="
    --with-openssl=auto
    --disable-year2038
    gl_cv_host_operating_system=illumos
    ac_cv_func_inotify_init=no
    gt_cv_locale_fr=fr_FR.ISO8859-15
    gt_cv_locale_ja=none
    gt_cv_locale_zh_CN=none
"
# We explicitly select an older POSIX conformance level so that traditional
# behaviour of utilities is preserved. Without this, for example, sort, head
# and tail no longer accept the legacy +/- options.
CONFIGURE_OPTS+="
    DEFAULT_POSIX2_VERSION=199209
"
CONFIGURE_OPTS[i386]+=" --libexecdir=/usr/lib"
CONFIGURE_OPTS[amd64]+=" --libexecdir=/usr/lib/amd64"
# For memset_s
CPPFLAGS+=" -D__STDC_WANT_LIB_EXT1__"

TESTSUITE_FILTER='^[A-Z#][A-Z ]'

function post_install {
    sed -i '/or available locally via: info/d' \
        `$FD -t f '\.1$' $DESTDIR/usr/gnu/share/man/man1/`
}

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -fi
prep_build
build
run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
