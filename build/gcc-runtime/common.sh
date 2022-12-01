
# Any binaries compiled before we separated out the lib directories for each
# major gcc version will load libraries from /usr/lib. Even though there was
# not supposed to be an ABI change, experience has shown that binaries built
# with older GCC versions experience problems when loading the runtimes from
# gcc8 (in particular around exception handling with libstdc++.so). For that
# reason, retain version 7 libraries in /usr/lib. Anything built more recently
# will use version-specific paths.

SHARED_GCC_VER=7

maj=
full=
pth=
max=0

# Find the library file in the specified gcc version
function find_lib {
    local v=$1
    local lib=$2
    local minor

    [ -d /opt/gcc-$v/lib ] && pth=/opt/gcc-$v/lib || pth=/usr/gcc/$v/lib

    full=
    for l in "$pth"/$lib.so.*; do
        [[ $1 = *.py ]] && continue
        [ -f $l -a ! -h $l ] && full=$l && break
    done

    [ -f "$full" ] || logerr "No $lib lib for gcc-$v"
    full=`basename $full`                       # libxxxx.so.1.2.3
    maj=${full/%.+([0-9]).+([0-9])/}            # libxxxx.so.1
    minor="${full##*.}"                         # 1

    [ -n "$minor" -a "$minor" -gt $max ] && max=$minor

    logmsg "-- GCC $v - found $full ($maj)"
}

function checksum {
    local lib=$1

    local sum=`awk -v lib=$lib '
        $1 == lib { print $2 }
    ' $SRCDIR/checksum`

    if [ -n "$sum" ]; then
        nsum=`digest -a sha256 $lib`
        [ "$sum" = "$nsum" ] || logerr "Bad checksum for $lib"
    fi
}

function install_lib {
    local v=$1
    local libs="$2"

    logcmd mkdir -p usr/gcc/$v/lib/amd64
    for lib in $libs; do

        find_lib $v $lib    # sets pth, full, maj variables

        # Copy the libraries across to /usr/gcc/X/lib

        logcmd cp $pth/$full usr/gcc/$v/lib/$full
        logcmd cp $pth/amd64/$full usr/gcc/$v/lib/amd64/$full
        checksum usr/gcc/$v/lib/$full
        checksum usr/gcc/$v/lib/amd64/$full

        # Create the links

        if [ "$full" != "$maj" ]; then
            # /usr/gcc/X/lib/libxxxx.so.1 -> libxxxx.so.1.2.3
            logcmd ln -s $full usr/gcc/$v/lib/$maj
            logcmd ln -s $full usr/gcc/$v/lib/amd64/$maj
        fi
        # /usr/gcc/X/lib/libxxxx.so -> libxxxx.so.1
        logcmd ln -s $maj usr/gcc/$v/lib/$lib.so
        logcmd ln -s $maj usr/gcc/$v/lib/amd64/$lib.so

        # Link versioned libraries to /usr/lib - latest gcc version will win in
        # the case that two deliver the same versioned file.

        # /usr/lib/libxxxx.so.1.2.3 -> /usr/gcc/lib/X/libxxxx.so.1.2.3
        logcmd ln -sf ../gcc/$v/lib/$full usr/lib/$full
        logcmd ln -sf ../../gcc/$v/lib/amd64/$full usr/lib/amd64/$full
        if [ "$full" != "$maj" ]; then
            # /usr/lib/libxxxx.so.1 -> libxxxx.so.1.2.3
            logcmd ln -sf $full usr/lib/$maj
            logcmd ln -sf $full usr/lib/amd64/$maj
        fi

    done
}

# This function installs libxxxx.so and .so.1 links into /usr/lib, pointing to
# the GCC version passed as the first argument.
# This is used when there has been an unversioned ABI break, to ensure that
# the common libraries under /usr/lib point to a suitable version.
install_unversioned() {
    local v=$1
    local libs="$2"

    for lib in $libs; do
        find_lib $v $lib
        # /usr/lib/libxxxx.so.1 -> ../gcc/X/lib/libxxxx.so.1
        logcmd ln -sf ../gcc/$v/lib/$maj usr/lib/$maj
        logcmd ln -sf ../../gcc/$v/lib/amd64/$maj usr/lib/amd64/$maj
        # /usr/lib/libxxxx.so -> libxxxx.so.1
        logcmd ln -sf $maj usr/lib/$lib.so
        logcmd ln -sf $maj usr/lib/amd64/$lib.so
    done
}

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
