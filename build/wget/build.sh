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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=wget
VER=1.25.0
PKG=web/wget
SUMMARY="GNU Wget"
DESC="Retrieving files using HTTP, HTTPS, FTP and FTPS "
DESC+="the most widely-used Internet protocols"

RUN_DEPENDS_IPS="library/libidn web/ca-bundle"
BUILD_DEPENDS_IPS+="
    developer/lexer/flex
    library/pcre2
"

# required to run the test-suite
TEST_DEPENDS_PERLMOD="
    HTTP::Daemon
    IO::Socket::SSL
"

set_arch 64

CONFIGURE_OPTS="
    --with-ssl=openssl
    --mandir=$PREFIX/share/man
    POD2MAN=/usr/perl5/bin/pod2man
"

TESTSUITE_FILTER='^[A-Z#][A-Z ]'

post_install() {
    cross_arch $1 && return
    [ -n "$SKIP_TESTSUITE" ] && return

    # download and build perl dependencies
    for dep in $TEST_DEPENDS_PERLMOD; do
        note "-- Building dependency $dep"
        curl -L https://cpanmin.us | perl - -l $TMPDIR/_deproot \
            -M https://cpan.metacpan.org -n $dep
    done
}

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf
prep_build
build
PERL5LIB=$TMPDIR/_deproot/lib/perl5 run_testsuite check
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
