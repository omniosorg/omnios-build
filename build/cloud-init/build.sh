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
# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=cloud-init
VER=26.2
DASHREV=0
PKG=system/management/cloud-init
SUMMARY="Cloud instance initialisation tools"
DESC="Cloud-init is the industry standard multi-distribution method for "
DESC+="cross-platform cloud instance initialisation"

set_builddir $PROG-illumos-$VER-$DASHREV

set_arch 64

RUN_DEPENDS_IPS+="
    library/python-$PYTHONMAJVER/idna-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/jsonschema-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/pyrsistent-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/six-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/pyyaml-$PYTHONPKGVER
"

# This package does not ship any public libraries. Some of the bundled
# python extensions include shared objects.
NO_SONAME_EXPECTED=1

_site=$PREFIX/lib/$PROG/python$PYTHONVER

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --libexecdir=lib
    -Dinit_system=smf
    -Dbash_completion=false
    -Ddownstream_version=$VER-$DASHREV
    -Dpython.install_env=prefix
    -Dpython.purelibdir=$_site
    -Dpython.platlibdir=$_site
"

function install_deps {
    local _pip="$PYTHON -mpip install -Ut $DESTDIR/$_site"

    logmsg "--- installing python dependencies"
    logcmd mkdir -p $DESTDIR/$_site || logerr "mkdir $DESTDIR/$_site"
    logcmd $_pip -r $TMPDIR/$EXTRACTED_SRC/frozen-requirements.txt
    logcmd $_pip pyserial

    export PYTHONPATH=$DESTDIR/$_site
}

function fixup_bins {
    for f in cloud-id cloud-init; do
        logmsg "--- patching command $f"
        logcmd sed -i "
            /^import sys/a\\
from site import addsitedir\\
addsitedir('$_site')
        " $DESTDIR/usr/bin/$f || logerr "sed $f failed"
    done
}

init
download_source $PROG illumos $VER-$DASHREV
patch_source
prep_build meson
install_deps
build
fixup_bins
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
