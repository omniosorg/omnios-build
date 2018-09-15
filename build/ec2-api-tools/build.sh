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
# Copyright 2011-2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=ec2-api-tools
VER=1.7.5.1
VERHUMAN=$VER
PKG=system/management/ec2-api-tools
SUMMARY="The API tools serve as the client interface to the Amazon EC2 web service."
DESC="Use these tools to register and launch instances, manipulate security groups, and more."

BUILD_DEPENDS_IPS="network/rsync"
RUN_DEPENDS_IPS="runtime/java"

# Remove the dependence on EC2_HOME from all the commands,
# since ec2-cmd takes care of it.
# Just have each command script exec ec2-cmd
exec_fix() {
    logmsg "Cleaning up command scripts"
    find ${TMPDIR}/${BUILDDIR}/bin -type f \! -name '*cmd' \
        | xargs sed -i '
            /^__ZIP_PREFIX/d
            /^__RPM_PREFIX/d
            s#"${EC2_HOME}"/bin/#exec #
        '
}

install_files() {
    logmsg "Setting up proto area and copying files"
    mkdir -p $DESTDIR/$PREFIX
    pushd $DESTDIR/$PREFIX 2>/dev/null || logerr "pushd"

    for d in bin lib/ec2-api-tools share/doc/ec2-api-tools; do
        logcmd mkdir -p $d || logerr "--- Failed to mkdir $d"
    done
    logcmd /usr/bin/rsync -a --exclude='*.cmd' $TMPDIR/$BUILDDIR/bin/ bin/ \
        || logerr "--- Failed to copy bin files"
    logcmd /usr/bin/rsync -a --exclude='*.cmd' \
        $TMPDIR/$BUILDDIR/lib/ lib/ec2-api-tools/ \
        || logerr "--- Failed to copy lib files"

    logcmd cp -p $TMPDIR/$BUILDDIR/*.{txt,TXT} share/doc/ec2-api-tools/ \
        || logerr "--- Failed to copy licence files"

    popd > /dev/null
}

init
download_source ec2 $PROG $VER
patch_source
prep_build
exec_fix
install_files
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
