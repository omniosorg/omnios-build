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

PROG=rsyslog
VER=8.2404.0
PKG=system/rsyslog
SUMMARY="rsyslog - the rocket-fast system for log processing."
DESC="A high-performance, modular syslog implementation."

FJSONVER=1.2304.0
XFORM_ARGS+=" -DFJSON=$FJSONVER"

ESTRVER=0.1.11
XFORM_ARGS+=" -DESTR=$ESTRVER"

set_arch 64
set_standard XPG6

export MAKE

init
prep_build autoconf -autoreconf

#########################################################################
# Download and build a static dependencies

save_buildenv
CONFIGURE_OPTS="--disable-shared"

PATH=$GNUBIN:$PATH \
    build_dependency fastjson libfastjson-$FJSONVER $PROG/fastjson v$FJSONVER
build_dependency estr libestr-$ESTRVER $PROG/estr v$ESTRVER

restore_buildenv

#########################################################################

note -n "-- Building $PROG"

pre_build() {
    typeset arch=$1

    export LIBFASTJSON_CFLAGS="-I$DEPROOT/usr/include/libfastjson"
    export LIBFASTJSON_LIBS="-L$DEPROOT/usr/${LIBDIRS[$arch]} -lfastjson"
    export LIBESTR_CFLAGS="-I$DEPROOT/usr/include"
    export LIBESTR_LIBS="-L$DEPROOT/usr/${LIBDIRS[$arch]} -lestr"
    addpath PKG_CONFIG_PATH[$arch] \
        $DEPROOT$PREFIX/${LIBDIRS[$arch]}/pkgconfig
}

CONFIGURE_OPTS="
    --enable-inet
    --disable-libsystemd
    --disable-klog

    --disable-libgcrypt
    --disable-gnutls
    --enable-openssl
    --enable-gssapi-krb5

    --enable-imsolaris
    --enable-impstats

    --enable-omstdout
    --enable-omhttp
    --enable-omuxsock

    --enable-mail
    --disable-mysql

    --disable-generate-man-pages

    --enable-testbench
    --enable-imdiag
    --enable-extended-tests

    ac_cv_func_epoll_create=no
    ac_cv_func_epoll_create1=no
    ac_cv_func_inotify_init=no
    ac_cv_header_sys_inotify_h=no
"

# There is no need to install the plugins under amd64/
CONFIGURE_OPTS[amd64]+="
    --libdir=$PREFIX/lib
    --libexecdir=$PREFIX/lib
"

# Provide some overrides for things which cannot be detected when cross
# compiling.
CFLAGS[aarch64]+=" -mno-outline-atomics"
CONFIGURE_OPTS[aarch64]+="
    ap_cv_atomic_builtins=yes
    ap_cv_atomic_builtins_64=yes
    ac_cv_func_chown_works=yes
    ac_cv_func_stat_empty_string_bug=yes
    ac_cv_func_lstat_dereferences_slashed_symlink=yes
"

# The testsuite output is quite noisy - clean it up
TESTSUITE_FILTER="(PASS|SKIP|FAIL|ERROR|TOTAL|summary|====)"

post_install() {
    install_smf system rsyslog.xml rsyslog
}

download_source $PROG $PROG $VER
patch_source
build
PATH=$GNUBIN:$PATH run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
