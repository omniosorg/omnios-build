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
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=sudo
VER=1.8.25p1
VERHUMAN=$VER
PKG=security/sudo
SUMMARY="Authority delegation tool"
DESC="Provide limited super-user privileges to specific users"

CONFIGURE_OPTS_32+="
    --bindir=/usr/bin
    --sbindir=/usr/sbin
    --libexecdir=/usr/lib/sudo
"
CONFIGURE_OPTS_64+="
    --libexecdir=/usr/lib/sudo/amd64
"
CONFIGURE_OPTS="
    --with-ldap
    --with-project
    --with-rundir=/var/run/sudo
    --with-pam --with-pam-login
    --with-tty-tickets
    --without-insults
    --without-lecture
    --with-ignore-dot
    --with-bsm-audit
    --disable-pam-session
"

TESTSUITE_SED="
    /^libtool:/d
"

make_install64() {
    # This file will exist from the 32-bit 'make install' and so this
    # install will attempt to validate it and will fail because we aren't
    # running as root. Remove the file and let the 64-bit installation
    # re-create it.
    logcmd rm -f $DESTDIR/etc/sudoers
    make_install
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite check
make_isa_stub
VER=${VER//p/.}
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
