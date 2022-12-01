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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=net-snmp
VER=5.9.3
PKG=system/management/snmp/net-snmp
SUMMARY="Net-SNMP Agent files and libraries"
DESC="$SUMMARY"

SKIP_LICENCES="CMU/UCD"

# net-snmp builds fail randomly with parallel make. There are patches upstream
# but none of them resolve it successfully.
NO_PARALLEL_MAKE=1

# Previous versions that also need to be built and the libraries packaged
# since compiled software may depend on them.
PVERS="5.7.3 5.8"

MIB_MODULES="host disman/event-mib ucd-snmp/diskio udp-mib tcp-mib if-mib"

LNETSNMPLIBS="-lsocket -lnsl"

LIBRARIES_ONLY="
    --disable-applications
    --disable-manuals
    --disable-scripts
    --disable-mibs
"

forgo_isaexec
CONFIGURE_OPTS[i386]+=" $LIBRARIES_ONLY"

CONFIGURE_OPTS="
    --with-defaults
    --with-default-snmp-version=3
    --includedir=$PREFIX/include
    --mandir=$PREFIX/share/man
    --with-logfile=/var/log/snmpd.log
    --with-persistent-directory=/var/net-snmp
    --with-mibdirs=/etc/net-snmp/snmp/mibs
    --datadir=/etc/net-snmp
    --enable-agentx-dom-sock-only
    --enable-ucd-snmp-compatibility
    --enable-ipv6
    --enable-mfd-rewrites
    --enable-blumenthal-aes
    --disable-embedded-perl
    --without-perl-modules
    --disable-static
    --with-sys-contact=root@localhost
    --without-pkcs
    --with-openssl=/usr/ssl
"

CONFIGURE_OPTS[WS]="
    --with-transports=\"Unix UDP TCP UDPIPv6 TCPIPv6\"
    --with-mib-modules=\"$MIB_MODULES\"
"

TESTSUITE_SED="
    1,/RUNFULLTESTS$/d
    s/([^)]*net-snmp-.*//
    /^gmake/d
    s%-[0-9][0-9]*/[^)]*%/%g
"

init
save_buildenv
prep_build
# We only want the libraries from legacy versions
CONFIGURE_OPTS[amd64]+=" $LIBRARIES_ONLY"
for pver in $PVERS; do
    [ -n "$FLAVOR" -a "$FLAVOR" != "$pver" ] && continue
    note -n "Building previous version: $pver"
    build_dependency -merge -ctf -oot -multi \
        $PROG-$pver $PROG-$pver $PROG $PROG $pver
done
restore_buildenv
# Remove unnecessary files from the legacy versions
logcmd rm -rf $DESTDIR/usr/{include,bin}
logcmd $FD lib $DESTDIR/usr/lib -e la -e so -X rm {}

note -n "Building current version: $VER"

download_source $PROG $PROG $VER
patch_source
prep_build autoconf -oot -keep
build -multi
run_testsuite test
install_smf application/management net-snmp.xml svc-net-snmp
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
