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
# Copyright (c) 2015 by Delphix. All rights reserved.
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2022 OmniOS Community Edition (OmniOSce) Association.
#
#############################################################################
# Configuration for the build system
#############################################################################

# Clear environment variables we know to be bad for the build
unset LD_OPTIONS
unset LD_AUDIT LD_AUDIT_32 LD_AUDIT_64
unset LD_BIND_NOW LD_BIND_NOW_32 LD_BIND_NOW_64
unset LD_BREADTH LD_BREADTH_32 LD_BREADTH_64
unset LD_CONFIG LD_CONFIG_32 LD_CONFIG_64
unset LD_DEBUG LD_DEBUG_32 LD_DEBUG_64
unset LD_DEMANGLE LD_DEMANGLE_32 LD_DEMANGLE_64
unset LD_FLAGS LD_FLAGS_32 LD_FLAGS_64
unset LD_LIBRARY_PATH LD_LIBRARY_PATH_32 LD_LIBRARY_PATH_64
unset LD_LOADFLTR LD_LOADFLTR_32 LD_LOADFLTR_64
unset LD_NOAUDIT LD_NOAUDIT_32 LD_NOAUDIT_64
unset LD_NOAUXFLTR LD_NOAUXFLTR_32 LD_NOAUXFLTR_64
unset LD_NOCONFIG LD_NOCONFIG_32 LD_NOCONFIG_64
unset LD_NODIRCONFIG LD_NODIRCONFIG_32 LD_NODIRCONFIG_64
unset LD_NODIRECT LD_NODIRECT_32 LD_NODIRECT_64
unset LD_NOLAZYLOAD LD_NOLAZYLOAD_32 LD_NOLAZYLOAD_64
unset LD_NOOBJALTER LD_NOOBJALTER_32 LD_NOOBJALTER_64
unset LD_NOVERSION LD_NOVERSION_32 LD_NOVERSION_64
unset LD_ORIGIN LD_ORIGIN_32 LD_ORIGIN_64
unset LD_PRELOAD LD_PRELOAD_32 LD_PRELOAD_64
unset LD_PROFILE LD_PROFILE_32 LD_PROFILE_64
unset CFLAGS CPPFLAGS
unset MAKEFLAGS

unset CONFIG GROUP OWNER REMOTE ENV ARCH CLASSPATH NAME

# set locale to C
#
LANG=C;         export LANG
LC_ALL=C;       export LC_ALL
LC_COLLATE=C;   export LC_COLLATE
LC_CTYPE=C;     export LC_CTYPE
LC_MESSAGES=C;  export LC_MESSAGES
LC_MONETARY=C;  export LC_MONETARY
LC_NUMERIC=C;   export LC_NUMERIC
LC_TIME=C;      export LC_TIME

######################################################################

# Platform information, e.g. 5.11
SUNOSVER=`uname -r`

# Default branch
RELVER=151045
DASHREV=0
PVER=$RELVER.$DASHREV

# Default package publisher
PKGPUBLISHER=omnios

# Supported architectures, and the default set.
ARCH_LIST="i386 amd64 aarch64"
CROSS_ARCH="aarch64"
DEFAULT_ARCH="i386 amd64"

HOMEURL=https://omnios.org

# Default repository
PKGSRVR=file://$ROOTDIR/tmp.repo/

# Use bash for subshells and commands launched by python setuptools
export SHELL=/usr/bin/bash

# The package publisher email address
PUBLISHER_EMAIL=sa@omnios.org

# The github repository root from which some packages are pulled
GITHUB=https://github.com
OOCEGITHUB=$GITHUB/omniosorg
# The main OOCE mirror
SRCMIRROR=https://mirrors.omnios.org

# The server or path from which to fetch source code and other files.
# MIRROR may be overridden in lib/site.sh but defaults to the main OOCE mirror
# If $MIRROR begins with a '/', it is treated as a local directory.
MIRROR=$SRCMIRROR

# The production IPS repository for this branch (may be overridden in site.sh)
# Used for package contents diffing.
if [ $((RELVER % 2)) == 0 ]; then
    IPS_REPO=https://pkg.omnios.org/r$RELVER/core
else
    IPS_REPO=https://pkg.omnios.org/bloody/core
fi

ARCHIVE_TYPES="tar.zst tar.xz tar.bz2 tar.lz tar.gz tgz tar zip"

# Default prefix for packages (may be overridden)
PREFIX=/usr
NOTES_LOCATION=$PREFIX/share/doc/release-notes
CROSSTOOLS=/opt/cross

# Temporary directories
# TMPDIR is used for source archives and build directories
#    to avoid collision on shared build systems,
#    TMPDIR includes a username
# DTMPDIR is used for constructing the DESTDIR path
# Let the environment override TMPDIR.
[ -z "$TMPDIR" ] && TMPDIR=/tmp/build_$USER
DTMPDIR=$TMPDIR

# Log file for all output
LOGFILE=$PWD/build.log

# Default patches dir
PATCHDIR=patches

# Do we create isaexec stubs for scripts and other non-binaries (default yes)
NOSCRIPTSTUB=

TRIPLET32=i386-pc-solaris2.11
TRIPLET64=x86_64-pc-solaris2.11

#############################################################################
# Perl stuff
#############################################################################

# Perl versions we currently build against
PERLVER=`perl -MConfig -e 'print $Config{version}'`
SPERLVER=${PERLVER%.*}

# Full paths to bins
PERL=/usr/perl5/${SPERLVER}/bin/perl

# Default Makefile.PL options
PERL_MAKEFILE_OPTS="INSTALLSITEBIN=$PREFIX/perl5/bin \
                    INSTALLSITESCRIPT=$PREFIX/perl5/bin \
                    INSTALLSITEMAN1DIR=$PREFIX/perl5/$SPERLVER/man/man1 \
                    INSTALLSITEMAN3DIR=$PREFIX/perl5/$SPERLVER/man/man3 \
                    INSTALLDIRS=site"

# Accept MakeMaker defaults so as not to stall build scripts
export PERL_MM_USE_DEFAULT=true

# When building perl modules, run make test
# Unset in a build script to skip tests
PERL_MAKE_TEST=1

#############################################################################
# Paths to common tools
#############################################################################
USRBIN=/usr/bin
OOCEOPT=/opt/ooce
OOCEBIN=$OOCEOPT/bin
SFWBIN=/usr/sfw/bin
ONBLDBIN=/opt/onbld/bin
GNUBIN=/usr/gnu/bin

# Define variables for standard utilities so that we can choose to run the
# native version even if a build script modifies the path to put GNUBIN first.
for util in \
    basename cat comm cut dis tput digest mktemp sort sed tee rm mv cp mkdir \
    rmdir readlink ln ls chmod touch grep time find fgrep egrep uniq stat strip
do
    declare -n _var=${util^^}
    declare -g _var=$USRBIN/$util
    unset -vn _var
done

CURL=$USRBIN/curl
ELFEDIT=$USRBIN/elfedit
GIT=$USRBIN/git
LZIP=$USRBIN/lzip
NAWK=$USRBIN/awk
RSYNC=$USRBIN/rsync
UNZIP=$USRBIN/unzip
WGET=$USRBIN/wget2
XZCAT=$USRBIN/xzcat
ZSTD=$USRBIN/zstd

# GNU utilities
AWK=$GNUBIN/awk
MAKE=$GNUBIN/make
TESTSUITE_MAKE="$MAKE"
GDIFF=$GNUBIN/diff
PATCH=$GNUBIN/patch
REALPATH=$GNUBIN/realpath
TAR="$GNUBIN/tar --no-same-permissions --no-same-owner"

# Command for privilege escalation. Can be overridden in site.sh
PFEXEC=$USRBIN/sudo

# pkg(7) commands
PKGCLIENT=$USRBIN/pkg
PKGDEPEND=$USRBIN/pkgdepend
PKGFMT=$USRBIN/pkgfmt
PKGLINT=$USRBIN/pkglint
PKGMOGRIFY=$USRBIN/pkgmogrify
PKGRECV=$USRBIN/pkgrecv
PKGREPO=$USRBIN/pkgrepo
PKGSEND=$USRBIN/pkgsend

# Utilities that come from omnios-extra
BUNZIP2=$OOCEBIN/pbunzip2
CARGO=$OOCEBIN/cargo
CMAKE=$OOCEBIN/cmake
FD=$OOCEBIN/fd
GZIP=$OOCEBIN/pigz
JQ=$OOCEBIN/jq
NINJA=$OOCEBIN/ninja
RIPGREP=$OOCEBIN/rg

FIND_ELF=$ONBLDBIN/find_elf
CHECK_RTIME=$ONBLDBIN/check_rtime
CTFDUMP=$ONBLDBIN/i386/ctfdump
CTFCONVERT=$ONBLDBIN/i386/ctfconvert
CTF_FLAGS=
typeset -A CTFCFLAGS
CTFCFLAGS[_]="-gdwarf-2"
CTFCFLAGS[10]="-gstrict-dwarf"
CTFCFLAGS[11]="-gstrict-dwarf"
CTFCFLAGS[12]="-gstrict-dwarf"

# Enable CTF by default
CTF_DEFAULT=1

# Figure out number of logical CPUs for use with parallel gmake jobs (-j)
# Default to 1.5*n CPUs as we assume the build machine is 100% devoted to
# compiling.
# A build script may serialize make by setting NO_PARALLEL_MAKE
LCPUS=`psrinfo | wc -l`
MJOBS="$[ $LCPUS + ($LCPUS / 2) ]"
[ "$MJOBS" = "0" ] && MJOBS=2
MAKE_JOBS="-j $MJOBS"

# Remove install or packaging files by default. You can set this in a build
# script when testing to speed up building a package
DONT_REMOVE_INSTALL_DIR=

XFORM_ARGS=

PKG_INCLUDE_TS="*.py"

#############################################################################
# C compiler options - these can be overridden by a build script
#############################################################################

# The list of options which define the build environment
BUILDENV_OPTS="
    CONFIGURE_CMD CONFIGURE_OPTS
    CFLAGS CXXFLAGS CPPFLAGS
    LDFLAGS
"

CCACHE_PATH=/opt/ooce/ccache/bin

# We (almost) always want GCC
CC=gcc
CXX=g++

# Specify default versions for building packages
DEFAULT_GCC_VER=12
ILLUMOS_GCC_VER=10
DEFAULT_CLANG_VER=15

PYTHON2VER=2.7
PYTHON3VER=3.10
DEFAULT_PYTHON_VER=$PYTHON3VER
EXP_OPENSSLVER=3

# Options to turn compiler features on and off. Associative array keyed by
# compiler version or _ for all versions.
typeset -A FCFLAGS

# Use optimisation level 2 with all versions of gcc
FCFLAGS[_]+=" -O2"

# We generally want to keep the frame pointer around, regardless of the
# optimisation level - we like stack traces too much and it is of questionable
# benefit anyway, even on i386.
FCFLAGS[_]+=" -fno-omit-frame-pointer"

# Taken from illumos-joyent along with the following comment:
# "gcc has a rather aggressive optimization on by default that infers loop
#  bounds based on undefined behaviour (!!).  This can lead to some VERY
#  surprising optimisations -- ones that may be technically correct in the
#  strictest sense but also result in incorrect program behaviour."
FCFLAGS[7]+=" -fno-aggressive-loop-optimizations"
FCFLAGS[8]+=" -fno-aggressive-loop-optimizations"
FCFLAGS[9]+=" -fno-aggressive-loop-optimizations"
FCFLAGS[10]+=" -fno-aggressive-loop-optimizations"
FCFLAGS[11]+=" -fno-aggressive-loop-optimizations"
FCFLAGS[12]+=" -fno-aggressive-loop-optimizations"

# Flags to enable particular standards; see standards(7)
typeset -A STANDARDS

STANDARDS[POSIX]="-D_POSIX_C_SOURCE=200112L -D_POSIX_PTHREAD_SEMANTICS"
STANDARDS[XPG3]="-D_XOPEN_SOURCE"
STANDARDS[XPG4]="-D_XOPEN_SOURCE -D_XOPEN_VERSION=4"
STANDARDS[XPG4v2]="-D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED=1"
STANDARDS[XPG5]="-D_XOPEN_SOURCE=500 -D__EXTENSIONS__=1"
STANDARDS[XPG6]="-D_XOPEN_SOURCE=600 -D__EXTENSIONS__=1"

typeset -A CFLAGS=(
    [i386]=-m32
    [amd64]=-m64
)

typeset -A LDFLAGS=(
    [i386]=-m32
    [amd64]=-m64
)

typeset -A CXXFLAGS=(
    [i386]=-m32
    [amd64]=-m64
)

typeset -A CPPFLAGS=()
typeset -A PKG_CONFIG_PATH=()

MAKE_ARGS=
MAKE_ARGS_WS=
MAKE_INSTALL_TARGET=install
MAKE_INSTALL_ARGS=
MAKE_INSTALL_ARGS_WS=
MAKE_INSTALL_ARGS_32=
MAKE_INSTALL_ARGS_64=
NO_PARALLEL_MAKE=
MAKE_TESTSUITE_ARGS=--quiet
MAKE_TESTSUITE_ARGS_WS=

DESTDIR=

#############################################################################
# Configuration of the packaged software
#############################################################################

CONFIGURE_CMD="./configure"

typeset -A CONFIGURE_OPTS=()
FORGO_ISAEXEC=

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
