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
# source.  A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#
# }}}
#
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=entire
PKG=entire
VER=0.5.11
SUMMARY="Minimal set of core system packages"
DESC="Meta package to specify the minimum $DISTRO software set"

create_manifest_header()
{
    local mf=$1
    cat << EOM > $mf
set name=pkg.fmri value=pkg://\$(PKGPUBLISHER)/entire@11,\$(SUNOSVER)-\$(PVER)
set name=pkg.depend.install-hold value=core-os
set name=pkg.summary value="$SUMMARY"
set name=pkg.description value="$DESC"
set name=variant.opensolaris.zone value=global value=nonglobal
set name=variant.opensolaris.imagetype value=full value=partial
EOM
}

add_constraints()
{
    local cmf=$1
    local src=$2

    egrep -v '^ *$|^#' $src | while read pkg flags; do
        if [ -z "$pkg" ]; then
            logerr "Bad package line, $pkg/$flags"
        fi
        (
            print -n "depend"

            if [[ "$flags" = *F* ]]; then
                print -n " facet.entire.$pkg=true"
            fi
            if [[ "$flags" = *Z* ]]; then
                print -n " variant.opensolaris.zone=global"
            fi
            if [[ "$flags" = *S* ]]; then
                print -n " variant.opensolaris.imagetype=full\c"
            fi
            [[ "$flags" = *O* ]] && typ=optional || typ=require

            print " fmri=pkg://\$(PKGPUBLISHER)/$pkg type=$typ"
        ) >> $cmf
    done
}

init
prep_build

manifest=$TMPDIR/$PKGE.p5m
create_manifest_header $manifest
add_constraints $manifest $SRCDIR/entire.pkg

publish_manifest $PKG $manifest
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
