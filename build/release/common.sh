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

# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

# Update the following line with the current release suffix
RELSUFFIX=

RELEASE=${RELVER}${RELSUFFIX}
RELDATE="`date +%Y.%m.%d`"
RELNUM=${RELVER}
RELREV=0
[ -n "$RELSUFFIX" ] && RELREV=`suffixtorel $RELSUFFIX`

DASHREV=$RELREV

XFORM_ARGS+="
    -DRELEASE=$RELEASE -DRELNUM=$RELNUM -DRELDATE=$RELDATE -DRELREV=$RELREV
"

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
