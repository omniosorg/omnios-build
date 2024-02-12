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
# Copyright (c) 2014 by Delphix. All rights reserved.
# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.
#
umask 022

export PATH=/usr/bin:/usr/sbin:/usr/gnu/bin

BLIBDIR=$(realpath ${BASH_SOURCE[0]%/*})
SRCDIR=$PWD/`dirname $0`

. $BLIBDIR/functions.sh

if ((UID == 0)); then
    if [ -n "$ROOT_OK" ]; then
        logmsg "--- Running as root, but ROOT_OK is set; continuing"
    else
        logerr "--- You should not run this as root"
    fi
else
    # Ensure that this process does not have any special privileges, such as
    # permission to use dtrace.
    ppriv -s EIP=basic $$
fi

set_coredir $TMPDIR

MYSCRIPT=${BASH_SOURCE[1]##*/}
[[ $MYSCRIPT = build*.sh ]] && LOGFILE=$PWD/${MYSCRIPT/%.sh/.log}

[ -f "$LOGFILE" ] && mv $LOGFILE $LOGFILE.1

process_opts "$@"
shift $((OPTIND - 1))

# If buildctl has already done the checks, we can skip them here
[ -n "$_BUILDCTL_CHECKED_REQUIREMENTS" ] || basic_build_requirements

init_tools
set_gccver $DEFAULT_GCC_VER -q
set_python_version $DEFAULT_PYTHON_VER
reset_configure_opts

#############################################################################
# Print startup message
#############################################################################

logmsg "===== Build started at `date` ====="

function build_end {
    typeset rv=$?
    if [ -n "$PKG" -a -n "$build_start" ]; then
        logmsg "Time: $PKG - $(print_elapsed $((`date +%s` - build_start)))"
        build_start=
    fi
    exit $rv
}

build_start=`date +%s`
trap 'build_end' EXIT

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
