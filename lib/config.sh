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
# Copyright (c) 2015 by Delphix. All rights reserved.
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2017 OmniOS Community Edition (OmniOSce) Association.
#
#############################################################################
# Configuration for the build system
#############################################################################

# Default branch
RELVER=151026
PVER=0.$RELVER

# Default package publisher
PKGPUBLISHER=omnios

# Default repository
PKGSRVR=file://$ROOTDIR/tmp.repo/

# set locale to C
export LC_ALL=C

# Set the LANG to C as the assembler becomes upset about unicode in headers
export LANG=C

# Use bash for subshells and commands launched by python setuptools
export SHELL=/usr/bin/bash

# The github repository root from which some packages are pulled
GITHUB=https://github.com/omniosorg

# Which server to fetch files from.
# If $MIRROR begins with a '/', it is treated as a local directory.
MIRROR=https://mirrors.omniosce.org

# The production IPS repository for this branch (may be overriden in site.sh)
# Used for package contents diffing.
IPS_REPO=https://pkg.omniosce.org/bloody/core

# Default prefix for packages (may be overridden)
PREFIX=/usr

# Temporary directories
# TMPDIR is used for source archives and build directories
#    to avoid collision on shared build systems,
#    TMPDIR includes a username
# DTMPDIR is used for constructing the DESTDIR path
# Let the environment override TMPDIR.
if [ -z "$TMPDIR" ]; then
	TMPDIR=/tmp/build_$USER
fi
DTMPDIR=$TMPDIR

# Log file for all output
LOGFILE=$PWD/build.log

# Default patches dir
PATCHDIR=patches

# Do we create isaexec stubs for scripts and other non-binaries (default yes)
NOSCRIPTSTUB=

#############################################################################
# Perl stuff
#############################################################################

# Perl versions we currently build against
PERLVER=5.26.1
SPERLVER=${PERLVER%.*}

# Full paths to bins
PERL32=/usr/perl5/${SPERLVER}/bin/$ISAPART/perl
PERL64=/usr/perl5/${SPERLVER}/bin/$ISAPART64/perl

# Default Makefile.PL options
PERL_MAKEFILE_OPTS="INSTALLSITEBIN=$PREFIX/bin/_ARCHBIN_ \
                    INSTALLSITESCRIPT=$PREFIX/bin/_ARCHBIN_ \
                    INSTALLSITEMAN1DIR=$PREFIX/share/man/man1 \
                    INSTALLSITEMAN3DIR=$PREFIX/share/man/man3 \
                    INSTALLDIRS=site"

# Accept MakeMaker defaults so as not to stall build scripts
export PERL_MM_USE_DEFAULT=true

# When building perl modules, run make test
# Unset in a build script to skip tests
PERL_MAKE_TEST=1

#############################################################################
# Python -- NOTE, these can be changed at runtime via set_python_version().
#############################################################################
: ${PYTHONVER:=2.7}
: ${PYTHONPKGVER:=${PYTHONVER//./}}
PYTHONPATH=/usr
PYTHON=$PYTHONPATH/bin/python$PYTHONVER
PYTHONLIB=$PYTHONPATH/lib

#############################################################################
# Paths to common tools
#############################################################################
WGET=wget
PATCH=gpatch
MAKE=gmake
TAR="gtar --no-same-permissions --no-same-owner"
GZIP=gzip
BUNZIP2=bunzip2
XZCAT=xzcat
UNZIP=unzip
AWK=gawk
GIT=git
# Command for privilege escalation. Can be overridden in site.sh
PFEXEC=sudo

# Figure out number of logical CPUs for use with parallel gmake jobs (-j)
# Default to 1.5*nCPUs as we assume the build machine is 100% devoted to
# compiling.  
# A build script may serialize make by setting NO_PARALLEL_MAKE
LCPUS=`psrinfo | wc -l`
MJOBS="$[ $LCPUS + ($LCPUS / 2) ]"
[ "$MJOBS" = "0" ] && MJOBS=2
MAKE_JOBS="-j $MJOBS"
MAKE_ARGS=
MAKE_INSTALL_ARGS=
NO_PARALLEL_MAKE=

# Remove install or packaging files by default. You can set this in a build
# script when testing to speed up building a package
DONT_REMOVE_INSTALL_DIR=

#############################################################################
# C compiler options - these can be overriden by a build script
#############################################################################
# isaexec(3C) variants
# These variables will be passed to the build to construct multi-arch 
# binary and lib directories in DESTDIR

CCACHE_PATH=/opt/ooce/ccache/bin

ISAPART=i386
ISAPART64=amd64

# For OmniOS we (almost) always want GCC
CC=gcc
CXX=g++

# Specify default GCC version for building packages
DEFAULT_GCC_VER=6

# CFLAGS applies to both builds, 32/64 only gets applied to the respective
# build
CFLAGS=
CFLAGS32=
CFLAGS64="-m64"

# Linker flags
LDFLAGS=
LDFLAGS32=
LDFLAGS64="-m64"

# C pre-processor flags
CPPFLAGS=
CPPFLAGS32=
CPPFLAGS64=

# C++ flags
CXXFLAGS=
CXXFLAGS32=
CXXFLAGS64="-m64"

#############################################################################
# Configuration of the packaged software
#############################################################################
# Default configure command - almost always sufficient
CONFIGURE_CMD="./configure"

# Default configure options - replace/add to as needed
# This is a function so it can be called again if you change $PREFIX
# This is far from ideal, but works
reset_configure_opts() {
    # If it's the global default (/usr), we want sysconfdir to be /etc
    # otherwise put it under PREFIX
    if [[ $PREFIX == "/usr" ]]; then
        SYSCONFDIR=/etc
    else
        SYSCONFDIR=$PREFIX/etc
    fi
    CONFIGURE_OPTS_32="--prefix=$PREFIX
        --sysconfdir=$SYSCONFDIR
        --includedir=$PREFIX/include
        --bindir=$PREFIX/bin/$ISAPART
        --sbindir=$PREFIX/sbin/$ISAPART
        --libdir=$PREFIX/lib
        --libexecdir=$PREFIX/libexec"

    CONFIGURE_OPTS_64="--prefix=$PREFIX
        --sysconfdir=$SYSCONFDIR
        --includedir=$PREFIX/include
        --bindir=$PREFIX/bin/$ISAPART64
        --sbindir=$PREFIX/sbin/$ISAPART64
        --libdir=$PREFIX/lib/$ISAPART64
        --libexecdir=$PREFIX/libexec/$ISAPART64"
}
reset_configure_opts

# Configure options to apply to both builds - this is the one you usually want
# to change for things like --enable-feature
CONFIGURE_OPTS=
# Configure options that can contain embeeded white-space within escaped quotes
CONFIGURE_OPTS_WS=

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
