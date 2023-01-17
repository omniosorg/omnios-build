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
# Copyright (c) 2014 by Delphix. All rights reserved.
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=git
VER=2.37.5
PKG=developer/versioning/git
SUMMARY="$PROG - distributed version control system"
DESC="Git is a free and open source distributed version control system "
DESC+="designed to handle everything from small to very large projects with "
DESC+="speed and efficiency."

set_arch 64

BUILD_DEPENDS_IPS="
    compatibility/ucb
    developer/build/autoconf
    archiver/gnu-tar
"

HARDLINK_TARGETS="
    usr/libexec/$ISAPART64/git-core/git
    usr/libexec/$ISAPART64/git-core/git-remote-ftp
    usr/libexec/$ISAPART64/git-core/git-cvsserver
    usr/libexec/$ISAPART64/git-core/git-shell
"

# For inet_ntop which isn't detected properly in the configure script
LDFLAGS="-lnsl"
CONFIGURE_OPTS="
    --without-tcltk
    --with-curl=/usr
    --with-openssl=/usr
    --with-libpcre2
"

perllib=`$PERL -MConfig -e 'print $Config{installvendorlib}'`
MAKE_INSTALL_ARGS+=" perllibdir=$perllib"

# Checking for BMI instructions is very expensive; disable for batch builds
BMI_EXPECTED=$BATCH

save_function configure64 configure64_orig
configure64() {
    make_param configure
    configure64_orig
}

install_man() {
    logmsg "Fetching and installing pre-built man pages"

    BUILDDIR=man1 download_source $PROG $PROG-manpages $VER $TMPDIR/manpages

    dst="${DESTDIR}${PREFIX}/share/man"
    logcmd mkdir -p $dst
    logcmd rsync -a $TMPDIR/manpages/ $dst/ || logerr "rsync manpages"
    logcmd rm -f $dst/git-manpages*.xz*
}

install_pod() {
    pushd ${DESTDIR}${PREFIX} > /dev/null
    mkdir -p share/man/man3
    [ -d perl5/vendor_perl ] || logerr "perl libraries not found"
    find perl5/vendor_perl -name \*.pm | grep -v CPAN | while read p; do
        man="`echo $p | sed 's/\.pm$//' | cut -d/ -f4- | sed 's^/^::^g'`"
        pod2man $p > share/man/man3/$man.3 || rm -f share/man/man3/$man.3
    done
    popd > /dev/null
}

install_completions() {
    pushd ${DESTDIR}${PREFIX} > /dev/null
    logcmd mkdir -p share/bash-completion/completions || logerr "mkdir"
    logcmd cp $TMPDIR/$BUILDDIR/contrib/completion/git-completion.bash \
        share/bash-completion/completions/git \
        || logerr "failed to install bash completions"
    popd > /dev/null
}

TESTSUITE_SED="
    /test_submodule/s/:.*//
    /I18N/s/I18N .*/I18N/
    /^ok /d
    /^gmake/d
    /^[0-9][0-9]*\.\.[0-9]/d
    /No differences encountered/d
"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
run_testsuite
install_man
install_pod
install_completions
install_inetservices
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
