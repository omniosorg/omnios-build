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
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=words
VER=20200724
PKG=text/words
SUMMARY="A collection of international words files for /usr/share/lib/dict"
DESC="$SUMMARY"

# Aspell is built just to obtain the word list decompression utility
ASPELL_VER=0.60.8

set_arch 64

SKIP_LICENCES='*'

XFORM_ARGS="-D ROOT=usr/share/lib/dict"

pr_EN=aspell6;      ver_EN="2020.12.07-0"
pr_DE=aspell6;      ver_DE="20161207-7-0"
pr_DE_alt=aspell6;  ver_DE_alt="2.1-1"
pr_ES=aspell6;      ver_ES="1.11-2"
pr_IT=aspell6;      ver_IT="2.2_20050523-0"
pr_FR=aspell;       ver_FR="0.50-3"

DICTIONARIES="
    $pr_EN-en-$ver_EN
    $pr_DE-de-$ver_DE
    $pr_DE_alt-de-alt-$ver_DE_alt
    $pr_ES-es-$ver_ES
    $pr_IT-it-$ver_IT
    $pr_FR-fr-$ver_FR
"

fetch_dicts() {
    logcmd rm -rf $TMPDIR/$BUILDDIR
    logcmd mkdir -p $TMPDIR/$BUILDDIR

    tmog=$TMPDIR/licence.mog
    rm -f $tmog

    for dict in $DICTIONARIES; do
        logmsg "-- Fetch dictionary $dict"
        BUILDDIR=$dict download_source aspell $dict
        logcmd cp $TMPDIR/$dict/*.cwl $TMPDIR/$BUILDDIR || logerr "cp failed"
        logcmd cp $TMPDIR/$dict/Copyright $TMPDIR/$BUILDDIR/Copyright.$dict \
            || logerr "cp copyright failed"
        echo "license Copyright.$dict license=$dict" >> $tmog
    done
}

build_dicts() {
    pushd $TMPDIR/$BUILDDIR >/dev/null

    logcmd $SHELL preunzip *.cwl || logerr "preunzip failed"
    for wl in *.wl; do
        logmsg "--- converting $wl to UTF-8"
        logcmd mv $wl $wl~
        logcmd -p iconv -f ISO-8859-1 -t UTF-8 $wl~ \
            | cut -d/ -f1 | sort -df > $wl
        logcmd rm -f $wl~
    done

    popd >/dev/null
}

combine() {
    logmsg "--- combining $@" >> /dev/stderr
    cat "$@" | sort -u | sort -df
}

makehash() {
    typeset int=`mktemp`
    grep -hv "'" "$@" | /usr/lib/spell/hashmake > $int
    args=`wc $int | awk '{print $1}'`
    /usr/lib/spell/spellin $args < $int
    rm -f $int
}

install_dicts() {
    pushd $TMPDIR/$BUILDDIR >/dev/null

    out=$DESTDIR/usr/share/lib/dict/
    mkdir -p $out

    combine en-common.wl en_GB-ise*wl en_GB-variant*wl > $out/british-english
    combine en-common.wl en_US*wl > $out/american-english
    combine en-common.wl en_AU*wl > $out/australian-english
    combine en-common.wl en_CA*wl > $out/canadian-english

    combine de-common.wl de_*wl > $out/ngerman
    combine de-alt.wl > $out/ogerman

    combine es.wl > $out/spanish
    combine it.wl > $out/italian
    combine fr-40-only.wl > $out/french

    # The following code is not yet working, so we continue to ship the
    # hash lists from illumos.

    #hash=$DESTDIR/usr/lib/spell
    #mkdir -p $hash
    #makehash en-common.wl en_US-wo_accents-only.wl > $hash/hlista
    #makehash en-common.wl en_GB-ise-wo_accents-only.wl > $hash/hlistb

    popd >/dev/null
}

init
prep_build

build_dependency -noctf aspell aspell-$ASPELL_VER aspell aspell $ASPELL_VER
PATH+=":$DEPROOT/usr/bin"

fetch_dicts
build_dicts
install_dicts
make_package $tmog
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
