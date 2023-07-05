#!/bin/bash
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
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.
#

# This is sourced at the top of scripts which use helper scripts to build
# for different ARCHs. If we see `-a` in the options string, we look for such
# a helper and invoke that instead.

while getopts ":f:a:d:r:" opt; do
    if [ "$opt" = a -a -x build-arch-$OPTARG.sh ]; then
        echo "--- Switching to arch-specific build script"
        ./build-arch-$OPTARG.sh "$@"
        exit 0
    fi
done
OPTIND=1

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
