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

PROG=trousers
VER=0.3.14
VERHUMAN=$VER
PKG=library/security/trousers
SUMMARY="trousers - TCG Software Stack - software for accessing a TPM device"
DESC="$SUMMARY"

# For lint lib creation
BUILD_DEPENDS_IPS="developer/sunstudio12.1"

LIBS="-lbsm -lnsl -lsocket -lgen -lscf -lresolv"

CONFIGURE_OPTS+="
	--sysconfdir=/etc/security
	--disable-usercheck
"
#CONFIGURE_OPTS+=" --enable-debug"
CONFIGURE_OPTS_WS="
    LIBS=\"$LIBS\"
"

fix_headers() {
	pushd $TMPDIR/$BUILDDIR > /dev/null \
	    || logerr "Cannot change to build directory"

	find src/include -type f -name \*.h -exec dos2unix {} {} \;

	popd > /dev/null
}

init
download_source $PROG $PROG $VER
patch_source
fix_headers
prep_build
build
make_lintlibs tspi /usr/lib /usr/include "{tss,trousers}/*.h"
make_isa_stub
install_smf application/security tcsd.xml tcsd
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
