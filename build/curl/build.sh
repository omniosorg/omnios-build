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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=curl
VER=7.83.0
PKG=web/curl
SUMMARY="Command line tool for transferring data with URL syntax"
DESC="Curl is a command line tool for transferring data with URL syntax, "
DESC+="supporting many Internet protocols"

RUN_DEPENDS_IPS="web/ca-bundle library/libidn"

CONFIGURE_OPTS="
    --enable-thread
    --with-ca-bundle=/etc/ssl/cacert.pem
    --with-ca-path=/etc/ssl/certs
    --with-openssl
"
# curl has arch-dependent headers.
CONFIGURE_OPTS_64+=" --includedir=$PREFIX/include/amd64"

# Build backwards so that the 32-bit version is available for the test-suite.
# Otherwise there are test failures because some tests preload a library
# to override the hostname. If the library is 64-bit then the test aborts
# when runtests.pl calls a 32-bit shell to spawn a sub-process.
BUILDORDER="64 32"

# As of curl 7.61.1, Makefiles include macros over 8192 bytes long which our
# default make does not like. Ensure that GNU make is used for all invocations.
export MAKE

SKIP_LICENCES=curl
TESTSUITE_FILTER="^TEST[A-Z]"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
