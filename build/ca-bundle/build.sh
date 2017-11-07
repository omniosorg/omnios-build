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
# Copyright 2017 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=cabundle
VER=5.11
VERHUMAN=$VER
PKG=web/ca-bundle
SUMMARY="$PROG - Bundle of SSL Root CA certificates"

NSSVER="`grep '^VER=' $SRCDIR/../mozilla-nss-nspr/build.sh \
    | head -1 | cut -d= -f2`"
# Make-ca from https://github.com/djlucas/make-ca
MAKECAVER=0.6

DESC="SSL Root CA certificates extracted from mozilla-nss $NSSVER source"
DESC+=", plus OmniOSce CA cert."

BUILDARCH=32

build_pem() {
    BUILDDIR_ORIG=$BUILDDIR

    # Fetch and extract the NSS source to get certdata.txt
    NSSDIR=nss-$NSSVER
    BUILDDIR=$NSSDIR download_source nss nss $NSSVER

    # Fetch and extract make-ca
    MAKECADIR=make-ca-$MAKECAVER
    BUILDDIR=$MAKECADIR download_source make-ca make-ca $MAKECAVER

    BUILDDIR=$BUILDDIR_ORIG

    logmsg "-- Generating CA certificate files"
    PATH=/usr/gnu/bin:$PATH logcmd bash $TMPDIR/$MAKECADIR/make-ca \
        --destdir $DESTDIR \
        --certdata $TMPDIR/$NSSDIR/nss/lib/ckfw/builtins/certdata.txt \
        --keytool /usr/bin/keytool \
        --cafile /etc/ssl/cacert.pem \
        || logerr "Failed to generate certificates"

    logcmd mkdir -p $TMPDIR/$BUILDDIR
    logcmd cp $TMPDIR/nss-$NSSVER/nss/COPYING $TMPDIR/$BUILDDIR/license || \
        logerr "--- Failed to copy license file"
}

# Install the OmniOSce CA cert, to be used by pkg(1)
install_omnios_cacert() {
    logmsg "Installing OmniOSce CA certs for pkg(1) use"

    logcmd mkdir -p $DESTDIR/etc/ssl/pkg

    for cert in $SRCDIR/files/*.pem; do
        local file=`basename $cert`
        local subj_hash=`openssl x509 -hash -noout -in $cert`

        logmsg "--- Copying $file"
        logcmd cp $cert $DESTDIR/etc/ssl/pkg/ || \
            logerr "--- Failed to copy CA cert $file"

        logcmd ln -s $file $DESTDIR/etc/ssl/pkg/$subj_hash.0 || \
            logerr "--- Failed to create subject hash link for $file"
    done
}

init
prep_build
build_pem
install_omnios_cacert
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
