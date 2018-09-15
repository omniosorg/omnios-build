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
# Copyright (c) 2014 by Delphix. All rights reserved.
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=git
VER=2.19.0
PKG=developer/versioning/git
SUMMARY="$PROG - distributed version control system"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="
    compatibility/ucb
    developer/build/autoconf
    archiver/gnu-tar
"

HARDLINK_TARGETS="
    usr/libexec/git-core/git
    usr/libexec/amd64/git-core/git
    usr/libexec/git-core/git-remote-ftp
    usr/libexec/amd64/git-core/git-remote-ftp
    usr/libexec/git-core/git-cvsserver
    usr/libexec/amd64/git-core/git-cvsserver
    usr/libexec/git-core/git-shell
    usr/libexec/amd64/git-core/git-shell
"

# For inet_ntop which isn't detected properly in the configure script
LDFLAGS="-lnsl"
CFLAGS64+=" -I/usr/include/amd64"
CONFIGURE_OPTS="
    --without-tcltk
    --with-curl=/usr
    --with-openssl=/usr
"

MAKE_INSTALL_ARGS+=" perllibdir=/usr/lib/site_perl"

save_function configure32 configure32_orig
configure32() {
    make_param configure
    configure32_orig
}

save_function configure64 configure64_orig
configure64() {
    make_param configure
    configure64_orig
}

install_man() {
    logmsg "Fetching and installing pre-built man pages"
    if [ ! -f ${TMPDIR}/${PROG}-manpages-${VER}.tar.xz ]; then
        pushd $TMPDIR > /dev/null
        get_resource $PROG/${PROG}-manpages-${VER}.tar.xz || \
            logerr "--- Failed to fetch tarball"
        popd > /dev/null
    fi
    logcmd mkdir -p ${DESTDIR}${PREFIX}/share/man
    pushd ${DESTDIR}${PREFIX}/share/man > /dev/null
    extract_archive ${TMPDIR}/${PROG}-manpages-${VER}.tar.xz || \
        logerr "--- Error extracting archive"
    popd > /dev/null
}

install_pod() {
    pushd ${DESTDIR}${PREFIX} > /dev/null
    mkdir -p share/man/man3
    find lib/site_perl -name \*.pm | grep -v CPAN | while read p; do
        man="`echo $p | sed 's/\.pm$//' | cut -d/ -f3- | sed 's^/^::^g'`"
        pod2man $p > share/man/man3/$man.3 || rm -f share/man/man3/$man.3
    done
    popd > /dev/null
}

TESTSUITE_SED="
    /test_submodule/s/:.*//
    /I18N/s/I18N .*/I18N/
    /^ok /d
    /^gmake/d
    /^[0-9][0-9]*\.\.[0-9]/d
    /No differences encountered/d
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite
make_isa_stub
install_man
install_pod
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
