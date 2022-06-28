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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=curl
VER=7.84.0
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

# Build backwards so that the 32-bit version is available for the test-suite.
# Otherwise there are test failures because some tests preload a library
# to override the hostname. If the library is 64-bit then the test aborts
# when runtests.pl calls a 32-bit shell to spawn a sub-process.
BUILDORDER="64 32"

# As of curl 7.61.1, Makefiles include macros over 8192 bytes long which our
# default make does not like. Ensure that GNU make is used for all invocations.
export MAKE

# Want verbose output from make
MAKE_ARGS=V=1

SKIP_LICENCES=curl
TESTSUITE_FILTER="^TEST[A-Z]"

# curl filters the provided CFLAGS and does not allow the CTF options. Add them
# to the compiler variable instead.
CC+=" $CTF_CFLAGS"

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf -oot
build -multi
run_testsuite
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
