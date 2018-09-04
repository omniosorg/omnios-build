#!/bin/bash
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
# Copyright (c) 2014 by Delphix. All rights reserved.
# Copyright 2015 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#

umask 022

#############################################################################
# functions.sh
#############################################################################
# Helper functions for building packages that should be common to all build
# scripts
#############################################################################

BASEPATH=/usr/ccs/bin:/usr/bin:/usr/sbin:/usr/gnu/bin:/usr/sfw/bin
export PATH=$BASEPATH

#############################################################################
# Process command line options
#############################################################################
process_opts() {
    SCREENOUT=
    FLAVOR=
    OLDFLAVOR=
    BUILDARCH=both
    OLDBUILDARCH=
    BATCH=
    AUTOINSTALL=
    DEPVER=
    SKIP_PKGLINT=
    REBASE_PATCHES=
    SKIP_TESTSUITE=
    while getopts "bciPptf:ha:d:lr:" opt; do
        case $opt in
            h)
                show_usage
                exit
                ;;
            \?)
                show_usage
                exit 2
                ;;
            l)
                SKIP_PKGLINT=1
                ;;
            p)
                SCREENOUT=1
                ;;
            P)
                REBASE_PATCHES=1
                ;;
            b)
                BATCH=1 # Batch mode - exit on error
                ;;
            c)
                USE_CCACHE=1
                ;;
            i)
                AUTOINSTALL=1
                ;;
            t)
                SKIP_TESTSUITE=1
                ;;
            f)
                FLAVOR=$OPTARG
                OLDFLAVOR=$OPTARG # Used to see if the script overrides the
                                   # flavor
                ;;
            r)
                PKGSRVR=$OPTARG
                ;;
            a)
                BUILDARCH=$OPTARG
                OLDBUILDARCH=$OPTARG # Used to see if the script overrides the
                                     # BUILDARCH variable
                if [[ ! "$BUILDARCH" =~ ^(32|64|both)$ ]]; then
                    echo "Invalid build architecture specified: $BUILDARCH"
                    show_usage
                    exit 2
                fi
                ;;
            d)
                DEPVER=$OPTARG
                ;;
        esac
    done
}

#############################################################################
# Show usage information
#############################################################################
show_usage() {
cat << EOM

Usage: $0 [-blt] [-f FLAVOR] [-h] [-a 32|64|both] [-d DEPVER]
  -a ARCH   : build 32/64 bit only, or both (default: both)
  -b        : batch mode (exit on errors without asking)
  -c        : use 'ccache' to speed up (re-)compilation
  -d DEPVER : specify an extra dependency version (no default)
  -f FLAVOR : build a specific package flavor
  -h        : print this help text
  -i        : autoinstall mode (install build deps)
  -l        : skip pkglint check
  -p        : output all commands to the screen as well as log file
  -P        : re-base patches on latest source
  -r REPO   : specify the IPS repo to use
              (default: $PKGSRVR)
  -t        : skip test suite

EOM
}

print_config() {
    cat << EOM

MYDIR:                  $MYDIR
LIBDIR:                 $LIBDIR
ROOTDIR:                $ROOTDIR
TMPDIR:                 $TMPDIR
DTMPDIR:                $DTMPDIR

Mirror:                 $MIRROR
Publisher:              $PKGPUBLISHER
Production IPS Repo:    $IPS_REPO
Repository:             $PKGSRVR
Pre-built illumos:      ${PREBUILT_ILLUMOS:-"<Not configured>"}
Privilege Escalation:   $PFEXEC

EOM
}

#############################################################################
# Log output of a command to a file
#############################################################################
logcmd() {
    if [ -z "$SCREENOUT" ]; then
        echo Running: "$@" >> $LOGFILE
        "$@" >> $LOGFILE 2>&1
    else
        echo Running: "$@" | tee -a $LOGFILE
        "$@" | tee -a $LOGFILE 2>&1
        return ${PIPESTATUS[0]}
    fi
}

c_highlight="`tput setaf 2`"
c_error="`tput setaf 1`"
c_reset="`tput sgr0`"
logmsg() {
    typeset highlight=0
    [ "$1" = "-h" ] && shift && highlight=1
    [ "$1" = "-e" ] && shift && highlight=2

    echo "$logprefix$@" >> $LOGFILE
    if [ $highlight -eq 1 ]; then
        echo "$c_highlight$logprefix$@$c_reset"
    elif [ $highlight -eq 2 ]; then
        echo "$c_error$logprefix$@$c_reset"
    else
        echo "$logprefix$@"
    fi
}

logerr() {
    # Print an error message and ask the user if they wish to continue
    logmsg -e "$@"
    if [ -z "$BATCH" ]; then
        ask_to_continue "An Error occured in the build. "
    else
        exit 1
    fi
}

note() {
    typeset xarg=
    [ "$1" = "-h" ] && xarg=$1 && shift
    [ "$1" = "-e" ] && xarg=$1 && shift
    logmsg ""
    logmsg $xarg "***"
    logmsg $xarg "*** $@"
    logmsg $xarg "***"
}

ask_to_continue_() {
    MSG=$2
    STR=$3
    RE=$4
    # Ask the user if they want to continue or quit in the event of an error
    echo -n "${1}${MSG} ($STR) "
    read
    while [[ ! "$REPLY" =~ $RE ]]; do
        echo -n "continue? ($STR) "
        read
    done
}

ask_to_continue() {
    ask_to_continue_ "${1}" "Do you wish to continue anyway?" "y/n" "[yYnN]"
    if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
        logmsg -e "===== Build aborted ====="
        exit 1
    fi
    logmsg "===== User elected to continue after prompt. ====="
}

ask_to_install() {
    ati_PKG=$1
    MSG=$2
    if [ -n "$AUTOINSTALL" ]; then
        logmsg "Auto-installing $ati_PKG..."
        logcmd $PFEXEC pkg install $ati_PKG || \
            logerr "pkg install $ati_PKG failed"
        return
    fi
    if [ -n "$BATCH" ]; then
        logmsg -e "===== Build aborted ====="
        exit 1
    fi
    ask_to_continue_ "$MSG " "Install/Abort?" "i/a" "[iIaA]"
    if [[ "$REPLY" == "i" || "$REPLY" == "I" ]]; then
        logcmd $PFEXEC pkg install $ati_PKG || logerr "pkg install failed"
    else
        logmsg -e "===== Build aborted ====="
        exit 1
    fi
}

ask_to_pkglint() {
    ask_to_continue_ "" "Do you want to run pkglint at this time?" "y/n" "[yYnN]"
    [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]
}

ask_to_testsuite() {
    ask_to_continue_ "" "Do you want to run the test-suite at this time?" "y/n" "[yYnN]"
    [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]
}

#############################################################################
# URL encoding for package names, at least
#############################################################################
# This isn't real URL encoding, just a couple of common substitutions
url_encode() {
    [ $# -lt 1 ] && logerr "Not enough arguments to url_encode()"
    local encoded="$1";
    echo $* | sed -e '
        s!/!%2F!g
        s!+!%2B!g
        s/%../_/g
    '
}

#############################################################################
# ASCII character to number
#############################################################################

# Turn the letter component of the version into a number for IPS versioning
ord26() {
    local ASCII=$(printf '%d' "'$1")
    ASCII=$((ASCII - 64))
    [[ $ASCII -gt 32 ]] && ASCII=$((ASCII - 32))
    echo $ASCII
}

#############################################################################
# Some initialization
#############################################################################

# The dir where this file is located - used for sourcing further files
MYDIR=$PWD/`dirname $BASH_SOURCE[0]`
LIBDIR="`realpath $MYDIR`"
ROOTDIR="`dirname $LIBDIR`"
# The dir where this file was sourced from - this will be the directory of the
# build script
SRCDIR=$PWD/`dirname $0`

#############################################################################
# Load configuration options
#############################################################################
. $MYDIR/config.sh
[ -f $MYDIR/site.sh ] && . $MYDIR/site.sh
BASE_TMPDIR=$TMPDIR

# Platform information, e.g. 5.11
SUNOSVER=`uname -r`

[ -f "$LOGFILE" ] && mv $LOGFILE $LOGFILE.1
process_opts $@
shift $((OPTIND - 1))

#############################################################################
# Set up tools area
#############################################################################

#logmsg "-- Initialising tools area"

[ -d $TMPDIR/tools ] || mkdir -p $TMPDIR/tools
# Disable any commands that should not be used for the build
for cmd in cc CC; do
    [ -h $TMPDIR/tools/$cmd ] || logcmd ln -sf /bin/false $TMPDIR/tools/$cmd
done
BASEPATH=$TMPDIR/tools:$BASEPATH

#############################################################################
# Compiler version
#############################################################################

set_gccver() {
    GCCVER="$1"
    [ -z "$2" ] && logmsg "-- Setting GCC version to $GCCVER"
    GCCPATH="/opt/gcc-$GCCVER"
    [ -x "$GCCPATH/bin/gcc" ] || logerr "Unknown compiler version $GCCVER"
    PATH="$GCCPATH/bin:$BASEPATH"
    for cmd in gcc g++; do
        [ -h $TMPDIR/tools/$cmd ] && rm -f $TMPDIR/tools/$cmd
        ln -sf $GCCPATH/bin/$cmd $TMPDIR/tools/$cmd || logerr "$cmd link"
    done
    if [ -n "$USE_CCACHE" ]; then
        [ -x $CCACHE_PATH/ccache ] || logerr "Ccache is not installed"
        PATH="$CCACHE_PATH:$PATH"
    fi
    export GCCVER GCCPATH PATH
}

set_gccver $DEFAULT_GCC_VER -q

#############################################################################
# Default configure options.
#############################################################################

reset_configure_opts() {
    # If it's the global default (/usr), we want sysconfdir to be /etc
    # otherwise put it under PREFIX
    [ $PREFIX = "/usr" ] && SYSCONFDIR=/etc || SYSCONFDIR=$PREFIX/etc

    CONFIGURE_OPTS_32="
        --prefix=$PREFIX
        --sysconfdir=$SYSCONFDIR
        --includedir=$PREFIX/include
    "
    CONFIGURE_OPTS_64="$CONFIGURE_OPTS_32"

    if [ -n "$FORGO_ISAEXEC" ]; then
        CONFIGURE_OPTS_32+="
            --bindir=$PREFIX/bin
            --sbindir=$PREFIX/sbin
            --libdir=$PREFIX/lib
            --libexecdir=$PREFIX/libexec
        "
        CONFIGURE_OPTS_64+="
            --bindir=$PREFIX/bin
            --sbindir=$PREFIX/sbin
            --libdir=$PREFIX/lib/$ISAPART64
            --libexecdir=$PREFIX/libexec/$ISAPART64
        "
    else
        CONFIGURE_OPTS_32+="
            --bindir=$PREFIX/bin/$ISAPART
            --sbindir=$PREFIX/sbin/$ISAPART
            --libdir=$PREFIX/lib
            --libexecdir=$PREFIX/libexec
        "
        CONFIGURE_OPTS_64+="
            --bindir=$PREFIX/bin/$ISAPART64
            --sbindir=$PREFIX/sbin/$ISAPART64
            --libdir=$PREFIX/lib/$ISAPART64
            --libexecdir=$PREFIX/libexec/$ISAPART64
        "
    fi
}
reset_configure_opts

forgo_isaexec() {
    FORGO_ISAEXEC=1
    reset_configure_opts
}

set_arch() {
    [[ $1 =~ ^(32|64)$ ]] || logerr "Bad argument to set_arch"
    BUILDARCH=$1
    forgo_isaexec
}

BasicRequirements() {
    local needed=""
    [ -x $GCCPATH/bin/gcc ] || needed+=" developer/gcc$GCCVER"
    [ -x /usr/bin/ar ] || needed+=" developer/object-file"
    [ -x /usr/bin/ld ] || needed+=" developer/linker"
    [ -f /usr/lib/crt1.o ] || needed+=" developer/library/lint"
    [ -x /usr/bin/gmake ] || needed+=" developer/build/gnu-make"
    [ -f /usr/include/sys/types.h ] || needed+=" system/header"
    [ -f /usr/include/math.h ] || needed+=" system/library/math"
    if [ -n "$needed" ]; then
        logmsg "You appear to be missing some basic build requirements."
        logmsg "To fix this run:"
        logmsg " "
        logmsg "  $PFEXEC pkg install$needed"
        if [ -n "$BATCH" ]; then
            logmsg -e "===== Build aborted ====="
            exit 1
        fi
        echo
        for i in "$needed"; do
           ask_to_install $i "--- Build-time dependency $i not found"
        done
    fi
}
BasicRequirements

#############################################################################
# Running as root is not safe
#############################################################################
if [ "$UID" = "0" ]; then
    if [ -n "$ROOT_OK" ]; then
        logmsg "--- Running as root, but ROOT_OK is set; continuing"
    else
        logerr "--- You should not run this as root"
    fi
fi

#############################################################################
# Check the OpenSSL mediator
#############################################################################

opensslver=`pkg mediator -H openssl 2>/dev/null| awk '{print $3}'`
if [ -n "$opensslver" -a "$opensslver" != "1.1" ]; then
    if [ -n "$OPENSSL_TEST" ]; then
        logmsg -h "--- OpenSSL version $opensslver but OPENSSL_TEST is set"
    else
        logerr "--- OpenSSL version $opensslver should not be used for build"
    fi
fi

#############################################################################
# Print startup message
#############################################################################

logmsg "===== Build started at `date` ====="

build_start=`date +%s`
trap '[ -n "$build_start" ] && \
    logmsg Time: $PKG - $((`date +%s` - build_start)) && \
    build_start=' EXIT

#############################################################################
# Libtool -nostdlib hacking
# libtool doesn't put -nostdlib in the shared archive creation command
# we need it sometimes.
#############################################################################

libtool_nostdlib() {
    FILE=$1
    EXTRAS=$2
    logcmd perl -pi -e 's#(\$CC.*\$compiler_flags)#$1 -nostdlib '"$EXTRAS"'#g;' $FILE ||
        logerr "--- Patching libtool:$FILE for -nostdlib support failed"
}

#############################################################################
# Initialization function
#############################################################################

init_repo() {
    if [[ "$PKGSRVR" == file:/* ]]; then
        RPATH="`echo $PKGSRVR | sed 's^file:/*^/^'`"
        if [ ! -d "$RPATH" ]; then
            logmsg "-- Initialising local repo at $RPATH"
            pkgrepo create $RPATH || logerr "Could not create local repo"
            pkgrepo add-publisher -s $RPATH $PKGPUBLISHER || \
                logerr "Could not set publisher on local repo"
        fi
    fi
}

init() {
    # Print out current settings
    logmsg "Package name: $PKG"
    # Selected flavor
    if [ -z "$FLAVOR" ]; then
        logmsg "Selected flavor: None (use -f to specify a flavor)"
    else
        logmsg "Selected Flavor: $FLAVOR"
    fi
    if [ -n "$OLDFLAVOR" -a "$OLDFLAVOR" != "$FLAVOR" ]; then
        logmsg "NOTICE - The flavor was overridden by the build script."
        logmsg "The flavor specified on the command line was: $OLDFLAVOR"
    fi
    # Build arch
    logmsg "Selected build arch: $BUILDARCH"
    if [ -n "$OLDBUILDARCH" -a "$OLDBUILDARCH" != "$BUILDARCH" ]; then
        logmsg "NOTICE - The build arch was overridden by the build script."
        logmsg "The build arch specified on the command line was: $OLDFLAVOR"
    fi
    # Extra dependency version
    if [ -z "$DEPVER" ]; then
        logmsg "Extra dependency: None (use -d to specify a version)"
    else
        logmsg "Extra dependency: $DEPVER"
    fi
    # Ensure SUMMARY and DESC are non-empty
    if [ -z "$SUMMARY" ]; then
        logerr "SUMMARY may not be empty. Please update your build script"
    elif [ -z "$DESC" ]; then
        logerr "DESC may not be empty. Please update your build script"
    fi

    # BUILDDIR can be used to manually specify what directory the program is
    # built in (i.e. what the tarball extracts to). This defaults to the name
    # and version of the program, which works in most cases.
    [ -z "$BUILDDIR" ] && BUILDDIR=$PROG-$VER

    # Build each package in a sub-directory of the temporary area.
    # In addition to keeping everything related to a package together,
    # this also prevents problems with packages which have non-unique archive
    # names (1.2.3.tar.gz) or non-unique prog names.
    [ -n "$PROG" ] || logerr "\$PROG is not defined for this package."
    [ "$TMPDIR" = "$BASE_TMPDIR" ] && TMPDIR="$BASE_TMPDIR/$PROG-$VER"
    [ "$DTMPDIR" = "$BASE_TMPDIR" ] && DTMPDIR="$TMPDIR"

    init_repo
    pkgrepo get -s $PKGSRVR > /dev/null 2>&1 || \
        logerr "The PKGSRVR ($PKGSRVR) isn't available. All is doomed."
    verify_depends

    if [ -n "$FORCE_OPENSSL_VERSION" ]; then
        CFLAGS="-I/usr/ssl-$FORCE_OPENSSL_VERSION/include $CFLAGS"
        LDFLAGS32="-L/usr/ssl-$FORCE_OPENSSL_VERSION/lib $LDFLAGS32"
        LDFLAGS64="-L/usr/ssl-$FORCE_OPENSSL_VERSION/lib/amd64 $LDFLAGS64"
    fi
}

#############################################################################
# Verify any dependencies
#############################################################################

verify_depends() {
    logmsg "Verifying dependencies"
    # Support old-style runtime deps
    if [ -n "$DEPENDS_IPS" -a -n "$RUN_DEPENDS_IPS" ]; then
        # Either old way or new, not both.
        logerr "DEPENDS_IPS is deprecated. Please list all runtime dependencies in RUN_DEPENDS_IPS."
    elif [ -n "$DEPENDS_IPS" -a -z "$RUN_DEPENDS_IPS" ]; then
        RUN_DEPENDS_IPS=$DEPENDS_IPS
    fi
    # If only DEPENDS_IPS is used, assume the deps are build-time as well
    if [ -z "$BUILD_DEPENDS_IPS" -a -n "$DEPENDS_IPS" ]; then
        BUILD_DEPENDS_IPS=$DEPENDS_IPS
    fi
    for i in $BUILD_DEPENDS_IPS; do
        # Trim indicators to get the true name (see make_package for details)
        case ${i:0:1} in
            \=|\?)
                i=${i:1}
                ;;
            \-)
                # If it's an exclude, we should error if it's installed rather
                # than missing
                i=${i:1}
                pkg info $i > /dev/null 2<&1 && \
                    logerr "--- $i should not be installed during build."
                continue
                ;;
        esac
        pkg info $i > /dev/null 2<&1 ||
            ask_to_install "$i" "--- Build-time dependency $i not found"
    done
}

#############################################################################
# People that need these should call them explicitly
#############################################################################

run_inbuild() {
    logmsg "Running $*"
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logcmd "$@" || logerr "Failed to run $*"
    popd > /dev/null
}

run_autoheader() { run_inbuild autoheader "$@"; }
run_autoreconf() { run_inbuild autoreconf "$@"; }
run_autoconf() { run_inbuild autoconf "$@"; }
run_automake() { run_inbuild automake "$@"; }
run_aclocal() { run_inbuild aclocal "$@"; }

#############################################################################
# Stuff that needs to be done/set before we start building
#############################################################################

prep_build() {
    logmsg "Preparing for build"

    # Get the current date/time for the package timestamp
    DATETIME=`TZ=UTC /usr/bin/date +"%Y%m%dT%H%M%SZ"`

    logmsg "--- Creating temporary install dir"
    # We might need to encode some special chars
    PKGE=$(url_encode $PKG)
    # For DESTDIR the '%' can cause problems for some install scripts
    PKGD=${PKGE//%/_}
    DESTDIR=$DTMPDIR/${PKGD}_pkg
    if [ -z "$DONT_REMOVE_INSTALL_DIR" ]; then
        logcmd chmod -R u+w $DESTDIR > /dev/null 2>&1
        logcmd rm -rf $DESTDIR || \
            logerr "Failed to remove old temporary install dir"
        mkdir -p $DESTDIR || \
            logerr "Failed to create temporary install dir"
    fi

    if [ -n "$OUT_OF_TREE_BUILD" ]; then
        logmsg "-- Setting up for out-of-tree build"
        CONFIGURE_CMD=$TMPDIR/$BUILDDIR/configure
        SRC_BUILDDIR=$BUILDDIR
        BUILDDIR+=-build
        [ -d $TMPDIR/$BUILDDIR ] && logcmd rm -rf $TMPDIR/$BUILDDIR
        logcmd mkdir -p $TMPDIR/$BUILDDIR
    fi

    # Create symbolic link to build area in source
    logcmd ln -sf $TMPDIR $SRCDIR/tmp
}

#############################################################################
# Applies patches contained in $PATCHDIR (default patches/)
#############################################################################

check_for_patches() {
    if [ -z "$1" ]; then
        logmsg "Checking for patches in $PATCHDIR/"
    else
        logmsg "Checking for patches in $PATCHDIR/ ($1)"
    fi
    if [ ! -d "$SRCDIR/$PATCHDIR" ]; then
        logmsg "--- No patches directory found"
        return 1
    fi
    if [ ! -f "$SRCDIR/$PATCHDIR/series" ]; then
        logmsg "--- No series file (list of patches) found"
        return 1
    fi
    return 0
}

patch_file() {
    FILENAME=$1
    shift
    ARGS=$@
    if [ ! -f $SRCDIR/$PATCHDIR/$FILENAME ]; then
        logmsg "--- Patch file $FILENAME not found. Skipping patch."
        return
    fi
    # Note - if -p is specified more than once, then the last one takes
    # precedence, so we can specify -p1 at the beginning to default to -p1.
    # -t - don't ask questions
    # -N - don't try to apply a reverse patch
    if ! logcmd $PATCH -p1 -t -N $ARGS < $SRCDIR/$PATCHDIR/$FILENAME; then
        logerr "--- Patch $FILENAME failed"
    else
        logmsg "--- Applied patch $FILENAME"
    fi
}

apply_patches() {
    if ! check_for_patches "in order to apply them"; then
        logmsg "--- Not applying any patches"
    else
        logmsg "Applying patches"
        # Read the series file for patch filenames
        exec 3<"$SRCDIR/$PATCHDIR/series" # Open the series file with handle 3
        pushd $TMPDIR/$BUILDDIR > /dev/null
        while read LINE <&3 ; do
            [[ $LINE = \#* ]] && continue
            # Split Line into filename+args
            patch_file $LINE
        done
        popd > /dev/null
        exec 3<&- # Close the file
    fi
}

rebase_patches() {
    if ! check_for_patches "in order to re-base them"; then
        logerr "--- No patches to re-base"
    fi

    logmsg "Re-basing patches"
    # Read the series file for patch filenames
    exec 3<"$SRCDIR/$PATCHDIR/series"
    pushd $TMPDIR > /dev/null
    rsync -ac --delete $BUILDDIR/ $BUILDDIR.unpatched/
    while read LINE <&3 ; do
        [[ $LINE = \#* ]] && continue
        patchfile="$SRCDIR/$PATCHDIR/`echo $LINE | awk '{print $1}'`"
        rsync -ac --delete $BUILDDIR/ $BUILDDIR~/
        (
            cd $BUILDDIR
            patch_file $LINE
        )
        mv $patchfile $patchfile~
        # Extract the original patch header text
        sed -n '
            /^---/q
            /^diff -/q
            p
            ' < $patchfile~ > $patchfile
        # Generate new patch and normalise the header lines so that they do
        # not change with each run.
        gdiff -wpruN --exclude='*.orig' $BUILDDIR~ $BUILDDIR | sed '
            /^diff -wpruN/,/^\+\+\+ / {
                s% [^ ~/]*\(~*\)/% a\1/%g
                s%[0-9][0-9][0-9][0-9]-[0-9].*%1970-01-01 00:00:00%
            }
        ' >> $patchfile
        rm -f $patchfile~
    done
    rsync -ac --delete $BUILDDIR.unpatched/ $BUILDDIR/
    popd > /dev/null
    exec 3<&- # Close the file
    # Now the patches have been re-based, -pX is no longer required.
    sed -i 's/ -p.*//' "$SRCDIR/$PATCHDIR/series"
}

patch_source() {
    [ -n "$REBASE_PATCHES" ] && rebase_patches
    apply_patches
}

#############################################################################
# Attempt to download the given resource to the current directory.
#############################################################################
# Parameters
#   $1 - resource to get
#
get_resource() {
    local RESOURCE=$1
    case ${MIRROR:0:1} in
        /)
            logcmd cp $MIRROR/$RESOURCE .
            ;;
        *)
            URLPREFIX=$MIRROR
            $WGET -a $LOGFILE $URLPREFIX/$RESOURCE
            ;;
    esac
}

#############################################################################
# Download source tarball if needed and extract it
#############################################################################
# Parameters
#   $1 - directory name on the server
#   $2 - program name
#   $3 - program version
#   $4 - target directory
#   $5 - passed to extract_archive
#
# E.g.
#       download_source myprog myprog 1.2.3 will try:
#       http://mirrors.omniosce.org/myprog/myprog-1.2.3.tar.gz
download_source() {
    local DLDIR="$1"; shift
    local PROG="$1"; shift
    local VER="$1"; shift
    local TARGETDIR="$1"; shift
    local EXTRACTARGS="$@"

    local ARCHIVEPREFIX="$PROG"
    [ -n "$VER" ] && ARCHIVEPREFIX+="-$VER"
    [ -z "$TARGETDIR" ] && TARGETDIR="$TMPDIR"

    # Create TARGETDIR if it doesn't exist
    if [ ! -d "$TARGETDIR" ]; then
        logmsg "Creating target directory $TARGETDIR"
        logcmd mkdir -p $TARGETDIR
    fi

    pushd $TARGETDIR > /dev/null
    logmsg "Checking for source directory"
    if [ -d "$BUILDDIR" ]; then
        logmsg "--- Source directory found"
        if [ -n "$REMOVE_PREVIOUS" ]; then
            logmsg "--- Removing old source directory"\
                "(REMOVE_PREVIOUS=$REMOVE_PREVIOUS)"
            logcmd rm -rf $BUILDDIR || \
                logerr "Failed to remove source directory"
        elif check_for_patches "to see if we need to remove the source"; then
            logmsg "--- Patches are present, removing source directory"
            logcmd rm -rf $BUILDDIR || \
                logerr "Failed to remove source directory"
        else
            logmsg "--- Patches are not present and REMOVE_PREVIOUS is not"\
                "set, keeping source directory"
            popd > /dev/null
            return
        fi
    else
        logmsg "--- Source directory not found"
    fi

    # If we reach this point, the source directory was either not found, or it
    # was removed due to patches being present.
    logmsg "Checking for $PROG source archive"
    find_archive $ARCHIVEPREFIX FILENAME
    if [ -z "$FILENAME" ]; then
        # Try all possible archive names
        logmsg "--- Archive not found."
        logmsg "Downloading archive"
        get_resource $DLDIR/$ARCHIVEPREFIX.tar.gz || \
            get_resource $DLDIR/$ARCHIVEPREFIX.tar.bz2 || \
            get_resource $DLDIR/$ARCHIVEPREFIX.tar.xz || \
            get_resource $DLDIR/$ARCHIVEPREFIX.tgz || \
            get_resource $DLDIR/$ARCHIVEPREFIX.tbz || \
            get_resource $DLDIR/$ARCHIVEPREFIX.tar || \
            get_resource $DLDIR/$ARCHIVEPREFIX.zip || \
            logerr "--- Failed to download file"
        find_archive $ARCHIVEPREFIX FILENAME
        if [ -z "$FILENAME" ]; then
            logerr "Unable to find downloaded file."
        fi
    else
        logmsg "--- $PROG source archive found"
    fi

    # Fetch and verify the archive checksum
    logmsg "Verifying checksum of downloaded file."
    if [ ! -f "$FILENAME.sha256" ]; then
        get_resource $DLDIR/$FILENAME.sha256 \
            || logerr "Unable to download SHA256 checksum file for $FILENAME"
    fi
    if [ -f "$FILENAME.sha256" ]; then
        sum="`digest -a sha256 $FILENAME`"
        [ "$sum" = "`cat $FILENAME.sha256`" ] \
            || logerr "Checksum of downloaded file does not match."
    fi

    # Extract the archive
    logmsg "Extracting archive: $FILENAME"
    logcmd extract_archive $FILENAME $EXTRACTARGS \
        || logerr "--- Unable to extract archive."

    # Make sure the archive actually extracted some source where we expect
    if [ ! -d "$BUILDDIR" ]; then
        logerr "--- Extracted source is not in the expected location" \
            " ($BUILDDIR)"
    fi
    popd > /dev/null
}

# Finds an existing archive and stores its value in a variable whose name
#   is passed as a second parameter
# Example: find_archive myprog-1.2.3 FILENAME
#   Stores myprog-1.2.3.tar.gz in $FILENAME
find_archive() {
    FILES=`ls $1.{tar.gz,tgz,tar.bz2,tbz,tar.xz,tar,zip} 2>/dev/null`
    FILES=${FILES%% *} # Take only the first filename returned
    # This dereferences the second parameter passed
    eval "$2=\"$FILES\""
}

# Extracts various types of archive
extract_archive() {
    local file="$1"; shift
    case $file in
        *.tar.gz|*.tgz)     $GZIP -dc $file | $TAR -xvf - $* ;;
        *.tar.bz2|*.tbz)    $BUNZIP2 -dc $file | $TAR -xvf - $* ;;
        *.tar.xz)           $XZCAT $file | $TAR -xvf - $* ;;
        *.tar)              $TAR -xvf $file $* ;;
        *.zip)              $UNZIP $file $* ;;
        *)                  return 1 ;;
    esac
}

#############################################################################
# Export source from github or local clone
#############################################################################

clone_github_source() {
    typeset prog="$1"
    typeset src="$2"
    typeset branch="$3"
    typeset local="$4"
    typeset depth="${5:-1}"
    typeset fresh=0

    logmsg "$prog -> $TMPDIR/$BUILDDIR/$prog"
    [ -d $TMPDIR/$BUILDDIR ] || logcmd mkdir -p $TMPDIR/$BUILDDIR
    pushd $TMPDIR/$BUILDDIR > /dev/null

    if [ -n "$local" -a -d "$local" ]; then
        logmsg "-- syncing $prog from local clone"
        logcmd rsync -ar $local/ $prog/ || logerr "rsync failed."
        fresh=1
    elif [ ! -d $prog ]; then
        logcmd $GIT clone --no-single-branch --depth $depth $src $prog \
            || logerr "clone failed"
        fresh=1
    else
        logmsg "Using existing checkout"
    fi
    if [ -n "$branch" ]; then
        if ! logcmd $GIT -C $prog checkout $branch; then
            typeset _branch=$branch
            branch="`$GIT -C $prog rev-parse --abbrev-ref HEAD`"
            logmsg "No $_branch branch, using $branch."
        fi
    fi
    if [ "$fresh" -eq 0 -a -n "$branch" ]; then
        logcmd $GIT -C $prog pull origin $branch || logerr "failed to pull"
    fi

    $GIT -C $prog show --shortstat

    popd > /dev/null
}

#############################################################################
# Make the package
#############################################################################

make_package() {
    logmsg "Making package"
    case $BUILDARCH in
        32)
            BUILDSTR="32bit-"
            ;;
        64)
            BUILDSTR="64bit-"
            ;;
        *)
            BUILDSTR=""
            ;;
    esac
    # Add the flavor name to the package if it is not the default
    case $FLAVOR in
        ""|default)
            FLAVORSTR=""
            ;;
        *)
            FLAVORSTR="$FLAVOR-"
            ;;
    esac
    DESCSTR="$DESC"
    if [ -n "$FLAVORSTR" ]; then
        DESCSTR="$DESCSTR ($FLAVOR)"
    fi
    # Add the local dash-revision if specified.
    [ -n "$DASHREV" ] && PVER=$DASHREV.$RELVER
    PKGSEND=/usr/bin/pkgsend
    PKGLINT=/usr/bin/pkglint
    PKGMOGRIFY=/usr/bin/pkgmogrify
    PKGFMT=/usr/bin/pkgfmt
    PKGDEPEND=/usr/bin/pkgdepend
    P5M_INT=$TMPDIR/${PKGE}.p5m.int
    P5M_INT2=$TMPDIR/${PKGE}.p5m.int.2
    P5M_INT3=$TMPDIR/${PKGE}.p5m.int.3
    P5M_FINAL=$TMPDIR/${PKGE}.p5m
    MANUAL_DEPS=$TMPDIR/${PKGE}.deps.mog
    GLOBAL_MOG_FILE=$MYDIR/global-transforms.mog
    MY_MOG_FILE=$TMPDIR/${PKGE}.mog
    [ -f $SRCDIR/local.mog ] && \
        LOCAL_MOG_FILE=$SRCDIR/local.mog || LOCAL_MOG_FILE=
    EXTRA_MOG_FILE=
    FINAL_MOG_FILE=
    if [ -n "$1" ]; then
            if [[ "$1" = /* ]]; then
                EXTRA_MOG_FILE="$1"
            else
                EXTRA_MOG_FILE="$SRCDIR/$1"
            fi
    fi
    if [ -n "$2" ]; then
            if [[ "$2" = /* ]]; then
                FINAL_MOG_FILE="$2"
            else
                FINAL_MOG_FILE="$SRCDIR/$2"
            fi
    fi

    ## Strip leading zeros in version components.
    VER=`echo $VER | sed -e 's/\.0*\([1-9]\)/.\1/g;'`
    if [ -n "$FLAVOR" ]; then
        # We use FLAVOR instead of FLAVORSTR as we don't want the trailing dash
        FMRI="${PKG}-${FLAVOR}@${VER},${SUNOSVER}-${PVER}"
    else
        FMRI="${PKG}@${VER},${SUNOSVER}-${PVER}"
    fi
    if [ -n "$DESTDIR" ]; then
        check_symlinks "$DESTDIR"
        logmsg "--- Generating package manifest from $DESTDIR"
        logmsg "------ Running: $PKGSEND generate $DESTDIR > $P5M_INT"
        GENERATE_ARGS=
        if [ -n "$HARDLINK_TARGETS" ]; then
            for f in $HARDLINK_TARGETS; do
                GENERATE_ARGS+="--target $f "
            done
        fi
        $PKGSEND generate $GENERATE_ARGS $DESTDIR > $P5M_INT || \
            logerr "------ Failed to generate manifest"
    else
        logmsg "--- Looks like a meta-package. Creating empty manifest"
        logcmd touch $P5M_INT || \
            logerr "------ Failed to create empty manifest"
    fi
    logmsg "--- Generating package metadata"
    echo "set name=pkg.fmri value=$FMRI" > $MY_MOG_FILE
    # Set human-readable version, if it exists
    if [ -n "$VERHUMAN" ]; then
        logmsg "------ Setting human-readable version"
        echo "set name=pkg.human-version value=\"$VERHUMAN\"" >> $MY_MOG_FILE
    fi
    echo "set name=pkg.summary value=\"$SUMMARY\"" >> $MY_MOG_FILE
    echo "set name=pkg.description value=\"$DESCSTR\"" >> $MY_MOG_FILE
    echo "set name=publisher value=\"sa@omniosce.org\"" >> $MY_MOG_FILE
    logmsg "--- Applying transforms"
    $PKGMOGRIFY \
        $XFORM_ARGS \
        $P5M_INT \
        $MY_MOG_FILE \
        $GLOBAL_MOG_FILE \
        $LOCAL_MOG_FILE \
        $EXTRA_MOG_FILE \
        | $PKGFMT -u > $P5M_INT2
    logmsg "--- Resolving dependencies"
    (
        set -e
        $PKGDEPEND generate -md $DESTDIR $P5M_INT2 > $P5M_INT3
        $PKGDEPEND resolve -m $P5M_INT3
    ) || logerr "--- Dependency resolution failed"
    logmsg "--- Detected dependencies"
    grep '^depend ' $P5M_INT3.res | while read line; do
        logmsg "$line"
    done
    echo > "$MANUAL_DEPS"
    if [ -n "$RUN_DEPENDS_IPS" ]; then
        logmsg "------ Adding manual dependencies"
        for i in $RUN_DEPENDS_IPS; do
            # IPS dependencies have multiple types, of which we care about four:
            #    require, optional, incorporate, exclude
            # For backward compatibility, assume no indicator means type=require
            # FMRI attributes are implicitly rooted so we don't have to prefix
            # 'pkg:/' or worry about ambiguities in names
            local DEPTYPE="require"
            case ${i:0:1} in
                \=)
                    DEPTYPE="incorporate"
                    i=${i:1}
                    ;;
                \?)
                    DEPTYPE="optional"
                    i=${i:1}
                    ;;
                \-)
                    DEPTYPE="exclude"
                    i=${i:1}
                    ;;
            esac
            case $i in
                *@)
                    depname=${i%@}
                    i=${i::-1}
                    explicit_ver=true
                    ;;
                *@*)
                    depname=${i%@*}
                    explicit_ver=true
                    ;;
                *)
                    depname=$i
                    explicit_ver=false
                    ;;
            esac
            # ugly grep, but pkgmogrify doesn't seem to provide any way to add
            # actions while avoiding duplicates (except maybe by running it
            # twice, using drop transform on the first run)
            if grep -q "^depend .*fmri=[^ ]*$depname" "${P5M_INT3}.res"; then
                autoresolved=true
            else
                autoresolved=false
            fi
            if $autoresolved && [ "$DEPTYPE" = "require" ]; then
                if $explicit_ver; then
                    escaped_depname="$(python -c "import re; print re.escape(r'$depname')")"
                    echo "<transform depend fmri=(.+/)?$escaped_depname -> set fmri $i>" >> $MANUAL_DEPS
                fi
            else
                echo "depend type=$DEPTYPE fmri=$i" >> $MANUAL_DEPS
            fi
        done
    fi
    $PKGMOGRIFY $XFORM_ARGS "${P5M_INT3}.res" "$MANUAL_DEPS" $FINAL_MOG_FILE \
        | $PKGFMT -u > $P5M_FINAL
    logmsg "--- Final dependencies"
    grep '^depend ' $P5M_FINAL | while read line; do
        logmsg "$line"
    done
    if [[ -z $SKIP_PKGLINT ]] && ( [[ -n $BATCH ]] || ask_to_pkglint ); then
        $PKGLINT -c $TMPDIR/lint-cache -r $PKGSRVR $P5M_FINAL || \
            logerr "----- pkglint failed"
    fi
    logmsg "--- Publishing package to $PKGSRVR"
    if [ -z "$BATCH" ]; then
        logmsg "Intentional pause: Last chance to sanity-check before publication!"
        ask_to_continue
    fi
    if [ -n "$DESTDIR" ]; then
        logcmd $PKGSEND -s $PKGSRVR publish -d $DESTDIR -d $TMPDIR/$BUILDDIR \
            -d $SRCDIR -T \*.py $P5M_FINAL || \
        logerr "------ Failed to publish package"
    else
        # If we're a metapackage (no DESTDIR) then there are no directories
        # to check
        logcmd $PKGSEND -s $PKGSRVR publish $P5M_FINAL || \
            logerr "------ Failed to publish package"
    fi
    logmsg "--- Published $FMRI"

     [ -z "$BATCH" -a -z "$SKIP_PKG_DIFF" ] && diff_package $FMRI
}

# Create a list of the items contained within a package in a format suitable
# for comparing with previous versions. We don't care about changes in file
# content, just whether items have been added, removed or had their attributes
# such as ownership changed.
pkgitems() {
    pkg contents -m "$@" 2>&1 | sed -E '
        # Remove signatures
        /^signature/d
        # Remove version numbers from the package FMRI
        /name=pkg.fmri/s/@.*//
        /human-version/d
        # Remove version numbers from dependencies
        /^depend/s/@[^ ]+//g
        # Remove file hashes
        s/^file [^ ]+/file/
        s/ chash=[^ ]+//
        s/ elfhash=[^ ]+//
        # Remove file sizes
        s/ pkg.[c]?size=[0-9]+//g
        # Remove timestamps
        s/ timestamp=[^ ]+//
    ' | pkgfmt
}

diff_package() {
    local fmri="$1"
    xfmri=${fmri%@*}

    logmsg "--- Comparing old package with new"
    if ! gdiff -U0 --color=always --minimal \
        <(pkgitems -g $IPS_REPO $xfmri) \
        <(pkgitems -g $PKGSRVR $fmri) \
        > $TMPDIR/pkgdiff.$$; then
            echo
            # Not anchored due to colour codes in file
            egrep -v '(\-\-\-|\+\+\+|\@\@) ' $TMPDIR/pkgdiff.$$
            note "Differences found between old and new packages"
            ask_to_continue
    fi
    rm -f $TMPDIR/pkgdiff.$$
}

#############################################################################
# Re-publish packages from one repository to another, changing the publisher
#############################################################################

republish_packages() {
    REPUBLISH_SRC="$1"
    logmsg "Republishing packages from $REPUBLISH_SRC"
    [ -d $TMPDIR/$BUILDDIR ] || mkdir $TMPDIR/$BUILDDIR
    mog=$TMPDIR/$BUILDDIR/pkgpublisher.mog
    cat << EOM > $mog
<transform set name=pkg.fmri -> edit value pkg://[^/]+/ pkg://$PKGPUBLISHER/>
EOM

    incoming=$TMPDIR/$BUILDDIR/incoming
    [ -d $incoming ] && rm -rf $incoming
    mkdir $incoming
    for pkg in `pkgrecv -s $REPUBLISH_SRC -d $incoming --newest`; do
        logmsg "    Receiving $pkg"
        logcmd pkgrecv -s $REPUBLISH_SRC -d $incoming --raw $pkg
    done

    for pdir in $incoming/*/*; do
        logmsg "    Processing $pdir"
        pkgmogrify $pdir/manifest $mog > $pdir/manifest.newpub
        logcmd pkgsend publish -s $PKGSRVR -d $pdir $pdir/manifest.newpub
    done
}

#############################################################################
# Install an SMF service
#############################################################################

install_smf() {
    mtype="${1:?type}"
    manifest="${2:?manifest}"
    method="$3"

    pushd $DESTDIR > /dev/null
    logmsg "-- Installing SMF service ($mtype / $manifest / $method)"

    # Manifest
    logcmd mkdir -p lib/svc/manifest/$mtype \
        || logerr "mkdir of $DESTDIR/lib/svc/manifest/$mtype failed"
    logcmd cp $SRCDIR/files/$manifest lib/svc/manifest/$mtype/ \
        || logerr "Cannot copy SMF manifest"
    logcmd chmod 0444 lib/svc/manifest/$mtype/$manifest

    # Method
    if [ -n "$method" ]; then
        logcmd mkdir -p lib/svc/method \
            || logerr "mkdir of $DESTDIR/lib/svc/method failed"
        logcmd cp $SRCDIR/files/$method lib/svc/method/ \
            || logerr "Cannot install SMF method"
        logcmd chmod 0555 lib/svc/method/$method
    fi

    popd > /dev/null
}

#############################################################################
# Make isaexec stub binaries
#############################################################################

make_isa_stub() {
    [ -n "$FORGO_ISAEXEC" ] \
        && logerr "-- Calling make_isa_stub after forgo_isaexec"
    logmsg "Making isaexec stub binaries"
    [ -z "$ISAEXEC_DIRS" ] && ISAEXEC_DIRS="bin sbin"
    for DIR in $ISAEXEC_DIRS; do
        if [ -d $DESTDIR$PREFIX/$DIR ]; then
            logmsg "--- $DIR"
            pushd $DESTDIR$PREFIX/$DIR > /dev/null
            make_isaexec_stub_arch $ISAPART
            make_isaexec_stub_arch $ISAPART64
            popd > /dev/null
        fi
    done
}

make_isaexec_stub_arch() {
    for file in $1/*; do
        [ -f "$file" ] || continue
        if [ -z "$STUBLINKS" -a -h "$file" ]; then
            # Symbolic link. If it's relative to within the same ARCH
            # directory, then replicate it at the ISAEXEC level.
            link=`readlink "$file"`
            [[ $link = */* ]] && continue
            base=`basename "$file"`
            [ -h "$base" ] && continue
            logmsg "------ Symbolic link: $file - replicating"
            logcmd ln -s $link $base || logerr "--- Link failed"
            continue
        fi
        # Check to make sure we don't have a script
        read -n 4 < $file
        file=`basename $file`
        # Only copy non-binaries if we set NOSCRIPTSTUB
        if [[ $REPLY != $'\177'ELF && -n "$NOSCRIPTSTUB" ]]; then
            logmsg "------ Non-binary file: $file - copying instead"
            logcmd cp $1/$file . && rm $1/$file || logerr "--- Copy failed"
            chmod +x $file
            continue
        fi
        # Skip if we already made a stub for this file
        [ -f "$file" ] && continue
        logmsg "------ $file"
        # Run the makeisa.sh script
        CC=$CC \
        logcmd $MYDIR/makeisa.sh $PREFIX/$DIR $file || \
            logerr "--- Failed to make isaexec stub for $DIR/$file"
    done
}

#############################################################################
# Build commands
#############################################################################
# Notes:
#   - These methods are designed to work in the general case.
#   - You can set CFLAGS/LDFLAGS (and CFLAGS32/CFLAGS64 for arch specific flags)
#   - Configure flags are set in CONFIGURE_OPTS_32 and CONFIGURE_OPTS_64 with
#     defaults set in config.sh. You can append to these variables or replace
#     them if the defaults don't work for you.
#   - In the normal case, where you just want to add --enable-feature, set
#     CONFIGURE_OPTS. This will be appended to the end of CONFIGURE_CMD
#     for both 32 and 64 bit builds.
#   - Any of these functions can be overriden in your build script, so if
#     anything here doesn't apply to the build process for your application,
#     just override that function with whatever code you need. The build
#     function itself can be overriden if the build process doesn't fit into a
#     configure, make, make install pattern.
#############################################################################

make_clean() {
    logmsg "--- make (dist)clean"
    logcmd $MAKE distclean || logcmd $MAKE clean
}

configure32() {
    logmsg "--- configure (32-bit)"
    eval set -- $CONFIGURE_OPTS_WS_32 $CONFIGURE_OPTS_WS
    CFLAGS="$CFLAGS $CFLAGS32" \
        CXXFLAGS="$CXXFLAGS $CXXFLAGS32" \
        CPPFLAGS="$CPPFLAGS $CPPFLAGS32" \
        LDFLAGS="$LDFLAGS $LDFLAGS32" \
        CC="$CC" CXX="$CXX" \
        logcmd $CONFIGURE_CMD $CONFIGURE_OPTS_32 \
        $CONFIGURE_OPTS "$@" || \
        logerr "--- Configure failed"
}

configure64() {
    logmsg "--- configure (64-bit)"
    eval set -- $CONFIGURE_OPTS_WS_64 $CONFIGURE_OPTS_WS
    CFLAGS="$CFLAGS $CFLAGS64" \
        CXXFLAGS="$CXXFLAGS $CXXFLAGS64" \
        CPPFLAGS="$CPPFLAGS $CPPFLAGS64" \
        LDFLAGS="$LDFLAGS $LDFLAGS64" \
        CC="$CC" CXX="$CXX" \
        logcmd $CONFIGURE_CMD $CONFIGURE_OPTS_64 \
        $CONFIGURE_OPTS "$@" || \
        logerr "--- Configure failed"
}

make_prog() {
    [ -n "$NO_PARALLEL_MAKE" ] && MAKE_JOBS=""
    if [ -n "$LIBTOOL_NOSTDLIB" ]; then
        libtool_nostdlib $LIBTOOL_NOSTDLIB $LIBTOOL_NOSTDLIB_EXTRAS
    fi
    logmsg "--- make"
    logcmd $MAKE $MAKE_JOBS $MAKE_ARGS || logerr "--- Make failed"
}

make_prog32() {
    make_prog
}

make_prog64() {
    make_prog
}

make_install() {
    local args="$@"
    logmsg "--- make install"
    logcmd $MAKE DESTDIR=${DESTDIR} $args $MAKE_INSTALL_ARGS install || \
        logerr "--- Make install failed"
}

make_install32() {
    make_install $MAKE_INSTALL_ARGS_32
}

make_install64() {
    make_install $MAKE_INSTALL_ARGS_64
}

make_pure_install() {
    # Make pure_install for perl modules so they don't touch perllocal.pod
    logmsg "--- make install (pure)"
    logcmd $MAKE DESTDIR=${DESTDIR} pure_install || \
        logerr "--- Make pure_install failed"
}

make_param() {
    logmsg "--- make $@"
    logcmd $MAKE "$@" || \
        logerr "--- $MAKE $1 failed"
}

# Helper function that can be called by build scripts to make in a specific dir
make_in() {
    [ -z "$1" ] && logerr "------ Make in dir failed - no dir specified"
    [ -n "$NO_PARALLEL_MAKE" ] && MAKE_JOBS=""
    logmsg "------ make in $1"
    logcmd $MAKE $MAKE_JOBS -C $1 || \
        logerr "------ Make in $1 failed"
}

# Helper function that can be called by build scripts to install in a specific
# dir
make_install_in() {
    [ -z "$1" ] && logerr "--- Make install in dir failed - no dir specified"
    logmsg "------ make install in $1"
    logcmd $MAKE -C $1 DESTDIR=${DESTDIR} install || \
        logerr "------ Make install in $1 failed"
}

make_lintlibs() {
    logmsg "Making lint libraries"

    LINTLIB=$1
    LINTLIBDIR=$2
    LINTINCDIR=$3
    LINTINCFILES=$4

    [ -z "$LINTLIB" ] && logerr "not lint library specified"
    [ -z $"LINTINCFILES" ] && LINTINCFILES="*.h"

    cat <<EOF > ${DTMPDIR}/${PKGD}_llib-l${LINTLIB}
/* LINTLIBRARY */
/* PROTOLIB1 */
#include <sys/types.h>
#undef _LARGEFILE_SOURCE
EOF
    pushd ${DESTDIR}${LINTINCDIR} > /dev/null
    sh -c "eval /usr/gnu/bin/ls -U ${LINTINCFILES}" | \
        sed -e 's/\(.*\)/#include <\1>/' >> ${DTMPDIR}/${PKGD}_llib-l${LINTLIB}
    popd > /dev/null

    pushd ${DESTDIR}${LINTLIBDIR} > /dev/null
    logcmd /opt/sunstudio12.1/bin/lint -nsvx -I${DESTDIR}${LINTINCDIR} \
        -o ${LINTLIB} ${DTMPDIR}/${PKGD}_llib-l${LINTLIB} || \
        logerr "failed to generate 32bit lint library ${LINTLIB}"
    popd > /dev/null

    pushd ${DESTDIR}${LINTLIBDIR}/amd64 > /dev/null
    logcmd /opt/sunstudio12.1/bin/lint -nsvx -I${DESTDIR}${LINTINCDIR} -m64 \
        -o ${LINTLIB} ${DTMPDIR}/${PKGD}_llib-l${LINTLIB} || \
        logerr "failed to generate 64bit lint library ${LINTLIB}"
    popd > /dev/null
}

build() {
    for b in $BUILDORDER; do
        [[ $BUILDARCH =~ ^($b|both)$ ]] && build$b
    done
}

build32() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building 32-bit"
    export ISALIST="$ISAPART"
    make_clean
    configure32
    make_prog32
    make_install32
    popd > /dev/null
    unset ISALIST
    export ISALIST
}

build64() {
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building 64-bit"
    make_clean
    configure64
    make_prog64
    make_install64
    popd > /dev/null
}

run_testsuite() {
    local target="${1:-test}"
    local dir="$2"
    local output="${3:-testsuite.log}"
    if [ -z "$SKIP_TESTSUITE" ] && ( [ -n "$BATCH" ] || ask_to_testsuite ); then
        pushd $TMPDIR/$BUILDDIR/$dir > /dev/null
        logmsg "Running testsuite"
        op=`mktemp`
        gmake --quiet $target 2>&1 | tee $op
        if [ -n "$TESTSUITE_SED" ]; then
            sed "$TESTSUITE_SED" $op > $SRCDIR/$output
        elif [ -n "$TESTSUITE_FILTER" ]; then
            egrep "$TESTSUITE_FILTER" $op > $SRCDIR/$output
        else
            cp $op $SRCDIR/$output
        fi
        rm -f $op
        popd > /dev/null
    fi
}

#############################################################################
# Build function for python programs
#############################################################################

set_python_version() {
    PYTHONVER=$1
    PYTHONPKGVER=${PYTHONVER//./}
    PYTHONPATH=/usr
    PYTHON=$PYTHONPATH/bin/python$PYTHONVER
    PYTHONLIB=$PYTHONPATH/lib
    PYTHONVENDOR=$PYTHONLIB/python$PYTHONVER/vendor-packages
    [[ $PYTHONVER = 3.* ]] && BUILDARCH=64
}
set_python_version $DEFAULT_PYTHON_VER

pre_python_32() {
    logmsg "prepping 32bit python build"
}

pre_python_64() {
    logmsg "prepping 64bit python build"
}

python_vendor_relocate() {
    mv $DESTDIR/usr/lib/python$PYTHONVER/site-packages \
        $DESTDIR/usr/lib/python$PYTHONVER/vendor-packages ||
        logerr "python: cannot move from site-packages to vendor-packages"
}

python_compile() {
    logmsg "Compiling python modules"
    logcmd $PYTHON -m compileall $DESTDIR
}

python_build32() {
    ISALIST=i386
    export ISALIST
    pre_python_32
    logmsg "--- setup.py (32) build"
    CFLAGS="$CFLAGS $CFLAGS32" LDFLAGS="$LDFLAGS $LDFLAGS32" \
        logcmd $PYTHON ./setup.py build $PYBUILD32OPTS \
        || logerr "--- build failed"
    logmsg "--- setup.py (32) install"
    logcmd $PYTHON ./setup.py install --root=$DESTDIR $PYINST32OPTS \
        || logerr "--- install failed"
}

python_build64() {
    ISALIST="amd64 i386"
    export ISALIST
    pre_python_64
    logmsg "--- setup.py (64) build"
    CFLAGS="$CFLAGS $CFLAGS64" LDFLAGS="$LDFLAGS $LDFLAGS64" \
        logcmd $PYTHON ./setup.py build $PYBUILD64OPTS \
        || logerr "--- build failed"
    logmsg "--- setup.py (64) install"
    logcmd $PYTHON ./setup.py install --root=$DESTDIR $PYINST64OPTS \
        || logerr "--- install failed"
}

python_build() {
    [ -z "$PYTHON" ] && logerr "PYTHON not set"
    [ -z "$PYTHONPATH" ] && logerr "PYTHONPATH not set"
    [ -z "$PYTHONLIB" ] && logerr "PYTHONLIB not set"

    logmsg "Building using python setup.py"

    pushd $TMPDIR/$BUILDDIR > /dev/null

    for b in $BUILDORDER; do
        [[ $BUILDARCH =~ ^($b|both)$ ]] && python_build$b
    done

    popd > /dev/null

    python_vendor_relocate
    python_compile
}

#############################################################################
# Build/test function for perl modules
#############################################################################
# Detects whether to use Build.PL or Makefile.PL
# Note: Build.PL probably needs Module::Build installed
#############################################################################

siteperl_to_vendor() {
    logcmd mv $DESTDIR/usr/perl5/site_perl $DESTDIR/usr/perl5/vendor_perl \
        || logerr "can't move to vendor_perl"
}

buildperl() {
    if [ -f "$SRCDIR/${PROG}-${VER}.env" ]; then
        logmsg "Sourcing environment file: $SRCDIR/${PROG}-${VER}.env"
        source $SRCDIR/${PROG}-${VER}.env
    fi
    for b in $BUILDORDER; do
        [[ $BUILDARCH =~ ^($b|both)$ ]] && buildperl$b
    done
}

buildperl32() {
    if [ -f "$SRCDIR/${PROG}-${VER}.env32" ]; then
        logmsg "Sourcing environment file: $SRCDIR/${PROG}-${VER}.env32"
        source $SRCDIR/${PROG}-${VER}.env32
    fi
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building 32-bit"
    export ISALIST="$ISAPART"
    local OPTS
    OPTS=${MAKEFILE_OPTS//_ARCH_/}
    OPTS=${OPTS//_ARCHBIN_/$ISAPART}
    if [ -f Makefile.PL ]; then
        make_clean
        makefilepl32 $OPTS
        make_prog
        [ -n "$PERL_MAKE_TEST" ] && make_param test
        make_pure_install
    elif [ -f Build.PL ]; then
        build_clean
        buildpl32 $OPTS
        build_prog
        [ -n "$PERL_MAKE_TEST" ] && build_test
        build_install
    fi
    popd > /dev/null
    unset ISALIST
    export ISALIST
}

buildperl64() {
    if [ -f "$SRCDIR/${PROG}-${VER}.env64" ]; then
        logmsg "Sourcing environment file: $SRCDIR/${PROG}-${VER}.env64"
        source $SRCDIR/${PROG}-${VER}.env64
    fi
    pushd $TMPDIR/$BUILDDIR > /dev/null
    logmsg "Building 64-bit"
    local OPTS
    OPTS=${MAKEFILE_OPTS//_ARCH_/$ISAPART64}
    OPTS=${OPTS//_ARCHBIN_/$ISAPART64}
    if [ -f Makefile.PL ]; then
        make_clean
        makefilepl64 $OPTS
        make_prog
        [ -n "$PERL_MAKE_TEST" ] && make_param test
        make_pure_install
    elif [ -f Build.PL ]; then
        build_clean
        buildpl64 $OPTS
        build_prog
        [ -n "$PERL_MAKE_TEST" ] && build_test
        build_install
    fi
    popd > /dev/null
}

makefilepl32() {
    logmsg "--- Makefile.PL 32-bit"
    logcmd $PERL32 Makefile.PL $@ || logerr "Failed to run Makefile.PL"
}

makefilepl64() {
    logmsg "--- Makefile.PL 64-bit"
    logcmd $PERL64 Makefile.PL $@ || logerr "Failed to run Makefile.PL"
}

buildpl32() {
    logmsg "--- Build.PL 32-bit"
    logcmd $PERL32 Build.PL prefix=$PREFIX $@ ||
        logerr "Failed to run Build.PL"
}

buildpl64() {
    logmsg "--- Build.PL 64-bit"
    logcmd $PERL64 Build.PL prefix=$PREFIX $@ ||
        logerr "Failed to run Build.PL"
}

build_clean() {
    logmsg "--- Build (dist)clean"
    logcmd ./Build distclean || \
    logcmd ./Build clean || \
        logmsg "--- *** WARNING *** make (dist)clean Failed"
}

build_prog() {
    logmsg "--- Build"
    logcmd ./Build ||
        logerr "Build failed"
}

build_test() {
    logmsg "--- Build test"
    logcmd ./Build test ||
        logerr "Build test failed"
}

build_install() {
    logmsg "--- Build install"
    logcmd ./Build pure_install --destdir=$DESTDIR || \
        logmsg "Build install failed"
}

test_if_core() {
    logmsg "Testing whether $MODNAME is in core"
    logmsg "--- Ensuring ${PKG} is not installed"
    if logcmd pkg info ${PKG}; then
        logerr "------ Package ${PKG} appears to be installed.  Please uninstall it."
    else
        logmsg "------ Not installed, good."
    fi
    if logcmd $PERL32 -M$MODNAME -e '1'; then
        # Module is in core, don't create a package
        logmsg "--- Module is in core for Perl $DEPVER.  Not creating a package."
        exit 0
    else
        logmsg "--- Module is not in core for Perl $DEPVER.  Continuing with build."
    fi
}

#############################################################################
# Scan the destination install and strip the non-stipped ELF objects
#############################################################################

strip_install() {
    logmsg "Stripping installation"
    pushd $DESTDIR > /dev/null || logerr "Cannot change to $DESTDIR"
    while read file; do
        # This will catch not-stripped as well.. just want to check it's a
        # strippable file.
        file $file | egrep -s 'ELF.*stripped' || continue
        logmsg "------ stripping $file"
        MODE=$(stat -c %a "$file")
        logcmd chmod 644 "$file" || logerr "chmod failed: $file"
        logcmd strip -x "$file" || logerr "strip failed: $file"
        logcmd chmod $MODE "$file" || logerr "chmod failed: $file"
    done < <(find . -depth -type f)
    popd > /dev/null
}

#############################################################################
# Check for dangling symlinks
#############################################################################

check_symlinks() {
    logmsg "Checking for dangling symlinks"
    for link in `find "$1" -type l`; do
        readlink -e $link >/dev/null || logerr "Dangling symlink $link"
    done
}

#############################################################################
# Clean up and print Done message
#############################################################################

clean_up() {
    logmsg "Cleaning up"
    if [ -z "$DONT_REMOVE_INSTALL_DIR" ]; then
        logmsg "--- Removing temporary install directory $DESTDIR"
        logcmd chmod -R u+w $DESTDIR > /dev/null 2>&1
        logcmd rm -rf $DESTDIR || \
            logerr "Failed to remove temporary install directory"
        logmsg "--- Cleaning up temporary manifest and transform files"
        logcmd rm -f $P5M_INT $P5M_INT2 $P5M_INT3 $P5M_FINAL \
            $MY_MOG_FILE $MANUAL_DEPS || \
            logerr "Failed to remove temporary manifest and transform files"
        logmsg "Done."
    fi
}

#############################################################################
# Helper function that will let you save a predefined function so you can
# override it and call it later
#############################################################################

save_function() {
    local ORIG_FUNC=$(declare -f $1)
    local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
    eval "$NEWNAME_FUNC"
}

# Called by builds that need a PREBUILT_ILLUMOS actually finished.

wait_for_prebuilt() {
    if [ ! -d ${PREBUILT_ILLUMOS:-/dev/null} ]; then
        logmsg -e "wait_for_prebuilt() called w/o PREBUILT_ILLUMOS. Aborting."
        exit 1
    fi

    # -h means symbolic link. That's what nightly does.
    if [ ! -h $PREBUILT_ILLUMOS/log/nightly.lock ]; then
        logmsg "$PREBUILT_ILLUMOS already built (no nightly.lock present...)"
        return
    fi

    # NOTE -> if the nightly finishes between the above check and now, we
    # can produce confusing output since nightly_pid will be empty.
    nightly_pid="`readlink $PREBUILT_ILLUMOS/log/nightly.lock | cut -d. -f3`"
    # Wait for nightly to be finished if it's running.
    logmsg "Waiting for illumos nightly build $nightly_pid to be finished."
    logmsg "Time spent waiting via time(1) printed below."
    logcmd "`/bin/time pwait $nightly_pid`"
    if [ -h $PREBUILT_ILLUMOS/log/nightly.lock ]; then
        logerr "Nightly lock present, but build not running. Aborting."
    fi
}

check_for_prebuilt() {
    key="${1:-proto/root_i386/kernel/amd64/genunix}"

    wait_for_prebuilt

    if [ -f "$PREBUILT_ILLUMOS/$key" -o -d "$PREBUILT_ILLUMOS/$key" ]; then
        logmsg "-- using pre-built illumos at $PREBUILT_ILLUMOS"
    else
        logerr "Prebuilt illumos not present, aborting."
    fi
}

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
