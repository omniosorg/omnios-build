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
# Copyright 2016 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=libxslt
VER=1.1.30
PKG=library/libxslt
SUMMARY="The XSLT library"
DESC="$SUMMARY"

RUN_DEPENDS_IPS="
	library/libxml2
	library/zlib
	system/library
	system/library/math
"

CFLAGS32+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
CFLAGS64+=" -D_LARGEFILE_SOURCE"
LDFLAGS="-lpthread"

# Without --with-libxml-prefix, configure does not find /usr/bin/xml2-config!
CONFIGURE_OPTS="
	--disable-static
	--with-pic
	--without-crypto
	--with-libxml-prefix=/usr
"
CONFIGURE_OPTS_32+=" --with-python=/usr/bin/$ISAPART/python2.7"
CONFIGURE_OPTS_64+=" --with-python=/usr/bin/$ISAPART64/python2.7"

NO_PARALLEL_MAKE="true"

# Make clean removes the man page (xsltproc.1) so it is preserved and
# restored between flavours (see below). However, this makes the tree
# end up with this file missing. Force removal of any previous extracted
# source trees to start from a clean slate.
REMOVE_PREVIOUS=1

backup_man() {
    logmsg "making a backup of xsltproc.1"
    logcmd cp $TMPDIR/$BUILDDIR/doc/xsltproc.1 $TMPDIR/$BUILDDIR/backup.1
}

save_function configure64 configure64_orig
configure64() {
    configure64_orig
    logmsg "restoring backup of xsltproc.1"
    logcmd cp $TMPDIR/$BUILDDIR/backup.1 $TMPDIR/$BUILDDIR/doc/xsltproc.1
    logcmd touch $TMPDIR/$BUILDDIR/doc/xsltproc.1
}

save_function make_prog64 make_prog64_orig
save_function make_prog32 make_prog32_orig
make_prog64() {
    libtool_nostdlib libtool
    make_prog64_orig
}
make_prog32() {
    libtool_nostdlib libtool
    make_prog32_orig
}

tests() {
	logmsg "-- running tests"
	[ `$DESTDIR/usr/bin/xslt-config --cflags` = "-I/usr/include/libxml2" ] \
	    || logerr "xslt-config --cflags not working"
}

init
download_source $PROG $PROG $VER
patch_source
backup_man
prep_build
build
python_vendor_relocate
make_isa_stub
tests
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
