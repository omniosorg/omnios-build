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
#
. ../../lib/build.sh

PROG=cabundle
VER=5.11
PKG=web/ca-bundle
SUMMARY="Bundle of Root CA certificates"

nsbuild=$SRCDIR/../mozilla-nss-nspr/build.sh
NSSVER="`grep '^VER=' $nsbuild | sed 's/.*=//;q'`"
NSPRVER="`grep '^NSPRVER=' $nsbuild | sed 's/.*=//;q'`"
# Make-ca from https://github.com/djlucas/make-ca
MAKECAVER=0.6

DESC="Root CA certificates extracted from mozilla-nss $NSSVER source"
DESC+=", plus OmniOS CA cert."

# Continue using the JDK 1.8 keytool to generate the java key store, as long
# as we continue to ship Java 1.8
KEYTOOL=/usr/jdk/instances/openjdk1.8.0/bin/keytool

# There should always be at least this many certificates in the generated
# bundles - if there are not, the build will abort.
SAFETY_THRESH=100

OVERRIDE_SOURCE_URL=none

build_pem() {
    BUILDDIR_ORIG=$BUILDDIR

    # Fetch and extract the NSS source to get certdata.txt
    NSSDIR=nss-$NSSVER
    CERTDATA=nss/lib/ckfw/builtins/certdata.txt
    BUILDDIR=$NSSDIR download_source nss nss "$NSSVER-with-nspr-$NSPRVER" \
        "" "$NSSDIR/$CERTDATA $NSSDIR/nss/COPYING"

    # Fetch and extract make-ca
    MAKECADIR=make-ca-$MAKECAVER
    BUILDDIR=$MAKECADIR download_source make-ca make-ca $MAKECAVER

    BUILDDIR=$BUILDDIR_ORIG

    # The make-ca script has a hard coded check for at least 150
    # certificates. However, the number of trusted roots is now lower
    logcmd sed -i "s/\\<150\\>/$SAFETY_THRESH/g" $TMPDIR/$MAKECADIR/make-ca

    logmsg "-- Generating CA certificate files"
    PATH=$GNUBIN:$PATH logcmd bash $TMPDIR/$MAKECADIR/make-ca \
        --destdir $DESTDIR \
        --certdata $TMPDIR/$NSSDIR/$CERTDATA \
        --keytool $KEYTOOL \
        --cafile /etc/ssl/cacert.pem \
        || logerr "Failed to generate certificates"

    logcmd mkdir -p $TMPDIR/$BUILDDIR
    logcmd cp $TMPDIR/nss-$NSSVER/nss/COPYING $TMPDIR/$BUILDDIR/license || \
        logerr "--- Failed to copy license file"

    logmsg "-- Cleaning cacert.pem"
    logcmd cp $DESTDIR/etc/ssl/cacert.pem{,.full}
    sed -n < $DESTDIR/etc/ssl/cacert.pem.full > $DESTDIR/etc/ssl/cacert.pem '
        /^#/p
        /---BEGIN CERT/,/---END CERT/p
    '
    logcmd rm -f $DESTDIR/etc/ssl/cacert.pem.full

    # Move certificates to a name that matches their alias, and re-generate
    # the hash links.
    logmsg "-- Renaming CA certificates"
    pushd $DESTDIR/etc/ssl/certs >/dev/null || logerr "pushd certs failed"
    logcmd $FD -t l . -X rm
    for c in *.pem; do
        typeset alias=`openssl x509 -in $c -noout -alias | tr ' ' '_' \
            | tr -cd '[:print:]'`
        logcmd mv $c "$alias.pem" || logerr "Failed to rename $c"
        logmsg "    $c -> $alias"
    done
    logmsg "Re-hashing certificates"
    logcmd openssl rehash -v . || logerr "rehash failed"
    popd >/dev/null
}

# Install the OmniOS CA certs, to be used by pkg(1)
install_omnios_cacert() {
    logmsg "Installing OmniOS CA certs"

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

tests() {
    [ `$KEYTOOL -rfc -list -keystore $DESTDIR/etc/ssl/java/cacerts \
        -storepass changeit | grep -c 'BEGIN CERT'` -ge $SAFETY_THRESH ] \
        || logerr "Short JKS"
    [ `grep -c 'BEGIN CERT' $DESTDIR/etc/ssl/cacert.pem` -ge $SAFETY_THRESH ] \
        || logerr "Short cacert.pem"
}

init
prep_build
build_pem
install_omnios_cacert
tests
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
