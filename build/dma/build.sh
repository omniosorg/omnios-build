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
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=dma
VER=0.11
VERHUMAN=$VER
PKG=service/network/smtp/dma
SUMMARY="The DragonFly Mail Agent"
DESC="$SUMMARY"

set_arch 32

# adding ASLR flags to compiler and linker since
# dma:             gets ASLR if linker flag is set
# dma-mbox-create: gets ASLR if compiler flag is set
export CFLAGS="-O2 -g -pipe -Wl,-z,aslr -DHAVE_STRLCPY -DHAVE_GETPROGNAME"
export LDADD="-Wl,-z,aslr -lssl -lcrypto -lresolv -lsocket -lnsl"

export PREFIX=/usr
export SBIN=${PREFIX}/lib/smtp/dma
export LIBEXEC=${PREFIX}/lib/smtp/dma

# No configure
configure32() {
    export CC=gcc
    export YACC=bison
    export LEX=flex
}

move_manpage() {
    local page=$1
    local old=$2
    local new=$3

    pushd $TMPDIR/$BUILDDIR >/dev/null

    logmsg "-- Move manpage $page.$old -> $page.$new"
    if [ -f $page.$old ]; then
        mv $page.$old $page.$new
        # change manpage header
        uc=`echo $new | tr '[:lower:]' '[:upper:]'`
        sed -E -i "s/^(\.Dt +[^ ]+).*$/\1 $uc/" $page.$new
    elif [ -f $page.$new ]; then
        logmsg "---- Was already moved"
    else
        logerr "---- Not found"
    fi

    popd >/dev/null
}

make_install() {
    logmsg "--- make install"
    logcmd $MAKE DESTDIR=${DESTDIR} install install-spool-dirs install-etc || \
        logerr "--- Make install failed"

    logmsg "--- copying aliases template"
    logcmd mkdir -p $DESTDIR/etc/dma || logerr "--- failed to create dir"
    logcmd cp $SRCDIR/files/aliases $DESTDIR/etc/dma/aliases || \
        logerr "--- failed to copy aliases"
}

init
download_source $PROG "v$VER"
move_manpage dma 8 1m
patch_source
prep_build
build
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
