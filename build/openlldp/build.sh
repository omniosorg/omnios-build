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
# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=openlldp
VER=0.4alpha
PKG=system/network/lldp
SUMMARY="Link-layer Discovery Daemon"
DESC="A comprehensive implementation of the IEEE standard 802.1AB "
DESC+="Link Layer Discovery Protocol"

set_arch 64

init
download_source $PROG $PROG $VER
patch_source
run_autoreconf -i
prep_build
build
install_smf network lldpd.xml
VERHUMAN=$VER
VER=${VER/alpha/.0}
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
