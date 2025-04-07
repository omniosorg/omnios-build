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
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PKG=package/pkg
PKGLIST=$PKG
SUMMARY="This isn't used"
DESC="$SUMMARY"

ARCH=aarch64
[ "$CLIBUILDARCH" = $ARCH ] || logerr "Incorrect arch selected, use -a $ARCH"

PROG=pkg
VER=omni
BUILDNUM=$RELVER
[ -n "$PKGPUBLISHER" ] || logerr "No PKGPUBLISHER specified. Check lib/site.sh"

# Respect environmental overrides for these to ease development.
: ${PKG_SOURCE_REPO:=$OOCEGITHUB/pkg5}
: ${PKG_SOURCE_BRANCH:=r$RELVER}
VER+="-$PKG_SOURCE_BRANCH"

MAKE=$USRBIN/dmake

clone_source() {
    clone_github_source pkg \
        "$PKG_SOURCE_REPO" "$PKG_SOURCE_BRANCH" "$PKG5_CLONE"
    ((EXTRACT_MODE)) && exit
}

pyvar() {
    python -c "import sysconfig; print(sysconfig.get_config_var('$1'))"
}

build() {
    export CODE_WS=$TMPDIR/$BUILDDIR/pkg
    pushd $CODE_WS/src > /dev/null || logerr "Cannot chdir"

    subsume_arch $ARCH LDFLAGS
    LDFLAGS+=" -L${SYSROOT[$ARCH]}/usr/${LIBDIRS[$ARCH]}"
    LDFLAGS+=" -L${SYSROOT[$ARCH]}/${LIBDIRS[$ARCH]}"
    export LDFLAGS

    # Run the CFFI build with native python to generate the source files
    # that we'll later cross compile. We can't use FFI in the cross python
    # environment.
    logmsg "--- generate CFFI source"
    logcmd $MAKE cffi_src || logerr "Failed to build cffi_src"

    versions=`grep '^PYVERSIONS' Makefile.com | tr -s ' ' | cut -d\  -f3-`
    for v in $versions; do
        note -n "Building python version $v"
        set_python_version $v
        python_cross_setup $ARCH

        export CC
        export PYCFLAGS="-I`pyvar INCLUDEPY` `pyvar CFLAGS`"
        export PYLDFLAGS="`pyvar SHLIBS`"
        export PYVERSIONS=$v
        export USEPY=$v
        export MACH=$ARCH
        export TRIPLET=aarch64-unknown-solaris2
        export TARGET=install

        logmsg "--- build"

        logcmd $MAKE -e install-cmd \
            || logerr "make install-cmd failed"

        logcmd $MAKE -C modules -e install \
            || logerr "make install failed"

        logmsg "--- external modules"

        logcmd $MAKE -e \
            REQUIREMENTS=requirements-aarch64.txt \
            extmodules/$PYTHONVER \
            || logerr "make extmodules failed"

        logmsg "--- FFI extensions"

        logcmd $MAKE -e \
            -C cffi_src/src/$v \
            -f $PWD/cffi_src/Makefile.crossext \
            install \
            || logerr "make ffi extensions failed"

        python_cross_end
    done

    for d in po man svc web; do
        logmsg "--- running install in $d"
        logcmd $MAKE -C $d -e install || logerr "Failed to install $d"
    done

    for d in etc shared ipkg lipkg sparse; do
        logmsg "--- running install in brand/$d"
        logcmd $MAKE -C brand/$d -e install || logerr "Failed to install $d"
    done

    logmsg "--- running install in util"
    logcmd $MAKE -C util -e \
        SUBDIRS="misc publish/transforms" install \
        || logerr "Failed to install $d"

    popd > /dev/null
    set_python_version $PYTHON3VER
}

package() {
    pushd $TMPDIR/$BUILDDIR/pkg/src/pkg > /dev/null
    note -n "Packaging"
    manifests=" \
        package\\:pkg.p5m \
        system\\:zones\\:brand\\:ipkg.p5m \
        system\\:zones\\:brand\\:lipkg.p5m \
        system\\:zones\\:brand\\:sparse.p5m \
    "
    logcmd $MAKE publish-pkgs \
        BUILDNUM=$BUILDNUM \
        PKGSEND_OPTS="" \
        PKGPUBLISHER=$PKGPUBLISHER \
        PKGREPOTGT="" \
        PKGREPOLOC="${REPOS[$ARCH]}" \
		ARCH=$ARCH \
		PKGCMDENV=/usr/bin \
		MANIFESTS="$manifests" \
		PKG_IMAGE=${SYSROOT[$ARCH]} \
        || logerr "publication failed"
    popd > /dev/null
}

init
clone_source
build
package

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
