#!/usr/bin/bash

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

# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=jeos
PKG=incorporation/omnios-release
VER=0.5.11
SUMMARY="OmniOS release incorporation"
DESC="Incorporation to constrain OmniOS packages to a particular release"

. $SRCDIR/common.sh

# Allow overriding the source repository via the `-d` option to this
# script. This used during a full build driven from `buildctl` to
# snapshot the local staging repository once all packages are built.
[ -n "$DEPVER" ] && INCORP_REPO="$DEPVER"

PATH+=:$OOCEBIN

create_manifest_header()
{
    local mf=$1
    cat << EOM > $mf
set name=pkg.fmri value=pkg://@PKGPUBLISHER@/$PKG@11,@SUNOSVER@-@PVER@
set name=pkg.summary value="$SUMMARY"
set name=pkg.description value="$DESC"
set name=ooce.release value="$RELEASE"
set name=ooce.release.base value="$RELNUM"
set name=ooce.release.build value="$RELDATE"
set name=ooce.release.rev value="$RELREV"
EOM
}

add_constraints()
{
    local cmf=$1
    local src=$2

    typeset -A seen

    # We never want to include this incorporation in the dependencies
    seen['incorporation/omnios-release']=skip

    while IFS=$'\t' read pkg fmri; do
        [ -n "${seen[$pkg]}" ] && continue
        seen[$pkg]="$fmri"
        echo "depend fmri=$fmri type=incorporate" >> $cmf
    done < <( \
        pkgrepo -s $src list -H -F json \
        | jq -r '.[] | [.name, ."pkg.fmri"] | @tsv'
    )
}

init
prep_build

manifest=$TMPDIR/$PKGE.p5m
create_manifest_header $manifest
set -o pipefail
add_constraints $manifest $INCORP_REPO || logerr "Constraints failed"
publish_manifest $PKG $manifest
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
