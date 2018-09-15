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

PROG=net-snmp
VER=5.8
VERHUMAN=$VER
PKG=system/management/snmp/net-snmp
SUMMARY="Net-SNMP Agent files and libraries"
DESC="$SUMMARY"

NO_PARALLEL_MAKE=true

RUN_DEPENDS_IPS="shell/bash"

MIB_MODULES="host disman/event-mib ucd-snmp/diskio udp-mib tcp-mib if-mib"

CFLAGS+=" -fstack-check"
LDFLAGS32="-Wl,-zignore $LDFLAGS32 -L/lib"
LDFLAGS64="-Wl,-zignore $LDFLAGS64 -L/lib/$ISAPART64"
LNETSNMPLIBS="-lsocket -lnsl"

# Skip isaexec and deliver 64-bit binaries directly to bin and sbin
# 32-bit binaries are stripped in local.mog
CONFIGURE_OPTS_64+=" --bindir=$PREFIX/bin --sbindir=$PREFIX/sbin"
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

CONFIGURE_OPTS_WS="
    --with-transports=\"UDP TCP UDPIPv6 TCPIPv6\"
    --with-mib-modules=\"$MIB_MODULES\"
    LNETSNMPLIBS=\"$LNETSNMPLIBS\"
"

TESTSUITE_SED="
    1,/^..RUNFULLTESTS/d
    s/([^)]*net-snmp-.*//
    /^gmake/d
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite test
install_smf application/management net-snmp.xml svc-net-snmp
strip_install
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
