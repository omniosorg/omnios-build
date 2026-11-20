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

# Copyright 2026 OmniOS Community Edition (OmniOSce) Association.

function patch_pc {
    typeset ver=${1?ver}
    typeset dir=${2?dir}

    # Patch the .pc files to point to the version-specific location
    logcmd sed -i "
        /^libdir=/s/=.*\/lib/=\/usr\/ssl-$ver\/lib/
        /^includedir=/c\\
includedir=/usr/ssl-$ver/include
        " `$FD -t f -e pc . $dir`
}

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
