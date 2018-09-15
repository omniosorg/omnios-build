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
# Use is subject to license terms.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=ec2-credential
VER=1.0
VERHUMAN=$VER
PKG=system/management/ec2-credential
SUMMARY="Service that handles Amazon EC2 ssh key setup at boot time"
DESC="$SUMMARY"

RUN_DEPENDS_IPS="shell/bash"

drop_files() {
    logmsg "Installing files"
    mkdir -p $DESTDIR/$PREFIX
    pushd $DESTDIR/$PREFIX 2>/dev/null || logerr "pushd failed"
    logcmd mkdir -p bin || logerr "Could not make dir"
    logcmd cp -p $SRCDIR/files/install-ec2-credential bin/ \
        || logerr "Failed to copy install-ec2-credential"
    popd
}

init
prep_build
drop_files
install_smf system ec2-credential.xml
make_isa_stub
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
