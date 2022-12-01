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

# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=ntpsec
VER=1.2.1
PKG=service/network/ntpsec
SUMMARY="Network time services"
DESC="A secure, hardened and improved Network Time Protocol implementation"

set_arch 64

# Required to generate man pages
BUILD_DEPENDS_IPS="ooce/text/asciidoc"
export PATH=$PATH:$OOCEBIN

SKIP_LICENCES="*"

export XML_CATALOG_FILES=$OOCEOPT/docbook-xsl/catalog.xml

# Required to include struct timespec definition and constants.
export CFLAGS+=" -D__EXTENSIONS__"

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --sysconfdir=/etc/inet
    --define=CONFIG_FILE=/etc/inet/ntp.conf
    --refclock=all
    --python=$PYTHON
    --pyshebang=$PYTHON
    --pythondir=$PYTHONVENDOR
    --pythonarchdir=$PYTHONVENDOR
    --libdir=$PYTHONVENDOR/ntp
    --enable-manpage --disable-doc
    --nopyc --nopyo --nopycache
    --enable-debug-gdb
"
CONFIGURE_OPTS[WS]="
    --build-desc=\"OmniOS $RELVER\"
"

# NTPsec uses the 'waf' build system

make_clean() {
    logcmd ./waf distclean
}

configure_arch() {
    BIN_ASCIIDOC=$OOCEBIN/asciidoc \
        BIN_A2X=$OOCEBIN/a2x \
        BIN_XSLTPROC=$USRBIN/xsltproc \
        CC="$CC $CFLAGS" \
        logcmd ./waf configure $CONFIGURE_OPTS \
        || logerr "--- configure failed"
    logcmd mkdir -p build/main/pylib
    logcmd ln -s . build/main/pylib/64
}

make_arch() {
    logmsg "--- build"
    logcmd ./waf build || logerr "--- build failed"
}

make_install() {
    logmsg "--- install"
    logcmd ./waf install \
        --destdir=$DESTDIR \
        || logerr "--- install failed"
}

install_ntpdate() {
    logcmd cp $TMPDIR/$BUILDDIR/attic/ntpdate $DESTDIR/usr/bin/ntpdate
    logcmd chmod 755 $DESTDIR/usr/bin/ntpdate
}

# Force the testsuite output to be sorted by the binary being tested
# to aid comparison; also remove binary paths from test log.
fix_testsuite_output() {
    [ -z "$SKIP_TESTSUITE" ] && \
        cat $TMPDIR/$BUILDDIR/build/main/test.log | perl -e '
        m|(BINARY\s+:\s).*/([^/]+)$| && push @{$t{$b = $2}}, "$1$b"
            or push @{$t{$b}}, $_ while(<>);
            map {
                s/\\n/\n/g;
                s/^b'"'"'//;
                s/^'"'"'$//;
                s/ tests in [\d\.]+s/ tests/;
                print $_
            } @{$t{$_}} for sort keys %t
    ' > $SRCDIR/testsuite.log
}

init
download_source $PROG $PROG $VER
patch_source
prep_build autoconf-like
build
fix_testsuite_output
install_ntpdate
install_smf network ntpsec.xml ntpsec
python_compile
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
