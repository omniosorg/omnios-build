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
# Copyright 2025 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=cloud-init
VER=24.4.1
DASHREV=0
PKG=system/management/cloud-init
SUMMARY="Cloud instance initialisation tools"
DESC="Cloud-init is the industry standard multi-distribution method for "
DESC+="cross-platform cloud instance initialisation"

set_builddir $PROG-illumos-$VER-$DASHREV

RUN_DEPENDS_IPS+="
    library/python-$PYTHONMAJVER/idna-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/jsonschema-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/pyrsistent-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/six-$PYTHONPKGVER
    library/python-$PYTHONMAJVER/pyyaml-$PYTHONPKGVER
"

# Force using the legacy setup.py backend as the PEP518 build ends up putting
# the init system files in the wrong place. This will presumably be fixed
# upstream at some point.
PYTHON_BUILD_BACKEND=setuppy

# This package does not ship any public libraries. Some of the bundled
# python extensions include shared objects.
NO_SONAME_EXPECTED=1

_site=$PREFIX/lib/$PROG/python$PYTHONVER

function install_deps {
    local _pip="$PYTHON -mpip install -Ut $DESTDIR/$_site"

    logmsg "--- installing python dependencies"
    logcmd mkdir -p $DESTDIR/$_site || logerr "mkdir $DESTDIR/$_site"
    logcmd $_pip -r $TMPDIR/$BUILDDIR/frozen-requirements.txt
    logcmd $_pip pyserial

    export PYTHONPATH=$DESTDIR/$_site
    PYINSTOPTS[amd64]+=" --install-lib=$_site"
}

function fixup_path {
    for f in cloud-id cloud-init; do
        logcmd sed -i "
            /^import sys/a\\
from site import addsitedir\\
addsitedir('$_site')
        " $DESTDIR/usr/bin/$f || logerr "sed $f failed"
    done
}

PYINSTOPTS[amd64]="--init-system=smf"

init
download_source $PROG illumos $VER-$DASHREV
patch_source
prep_build
install_deps
python_build
fixup_path
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
