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
# Copyright 2011-2013 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
# Copyright (c) 2013 by Delphix. All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/functions.sh

PROG=bash
VER=4.4
PATCHLEVEL=23
VERHUMAN="$VER.$PATCHLEVEL"
PKG=shell/bash
SUMMARY="GNU Bourne-Again shell (bash)"
DESC="$SUMMARY"

RUN_DEPENDS_IPS="system/prerequisite/gnu system/library"

set_arch 32
NO_PARALLEL_MAKE=1

# Cribbed from upstream but modified for gcc
# "let's shrink the SHT_SYMTAB as much as we can"
LDFLAGS="-Wl,-z -Wl,redlocsym"

# Cribbed from upstream, with a few changes:
#   We only do 32-bit so forgo the isaexec stuff
#   Don't bother building static
CONFIGURE_OPTS="
    --localstatedir=/var
    --enable-alias
    --enable-arith-for-command
    --enable-array-variables
    --enable-bang-history
    --enable-brace-expansion
    --enable-casemod-attributes
    --enable-casemod-expansions
    --enable-command-timing
    --enable-cond-command
    --enable-cond-regexp
    --enable-coprocesses
    --enable-debugger
    --enable-directory-stack
    --enable-disabled-builtins
    --enable-dparen-arithmetic
    --enable-extended-glob
    --enable-help-builtin
    --enable-history
    --enable-job-control
    --enable-multibyte
    --enable-net-redirections
    --enable-process-substitution
    --enable-progcomp
    --enable-prompt-string-decoding
    --enable-readline
    --enable-restricted
    --enable-select
    --enable-separate-helpfiles
    --enable-single-help-strings
    --disable-strict-posix-default
    --enable-usg-echo-default
    --enable-xpg-echo-default
    --enable-mem-scramble
    --disable-profiling
    --enable-largefile
    --enable-nls
    --with-bash-malloc
    --with-curses
    --with-installed-readline=no
"

# Files taken from upstream userland-gate
install_files() {
    logmsg "Installing extra files"
    logcmd rsync -a $SRCDIR/files/ $DESTDIR/ || logerr "Extra files failed."
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
install_files
VER=${VER}.$PATCHLEVEL
make_package
clean_up

exit 0

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
