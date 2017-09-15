<img src="http://www.omniosce.org/OmniOSce_logo.svg" height="128">

# Release Notes for OmniOSce v11 r151024
![#f03c15](https://placehold.it/15/f03c15/000000?text=+) ** These are DRAFT release notes ** ![#f03c15](https://placehold.it/15/f03c15/000000?text=+)

Stable Release, TBC of November 2017

illumos-omnios branch r151024 at XXX

`uname -a` shows `omnios-r151024-XXX`

r151024 release repository: https://pkg.omniosce.org/r151024/core

## New features since r151022

### System Features

* Support for SuSE linux images within lx zones, courtesy of Joyent.

* Loader can now handle disks with native 4k sectors.

* `svcs -Z` no longer emits an error message for zones which do not have SMF.

* The GCC C++ compiler now supports `__cxa_atexit` which is required for
  fully standards-compliant handling of static destructors.

* Java is now an optional package, only required if you use the dynamic
  resource pools feature. After upgrade to r151024, you can remove java
  if desired as follows:

  `omnios# pkg uninstall runtime/java java/jdk service/resource-pools/poold`

* The `openssl` package now contains both OpenSSL 1.0.2 and 1.1.0, managed
  by a versioned variant. This is the first step on the two year plan to
  upgrade to OpenSSL 1.1 before the end-of-life date for 1.0. Note that
  OmniOS itself does not yet build with OpenSSL 1.1. For more information
  and a list of affected parts of OmniOS, see the
  [repository README file](https://github.com/omniosorg/omnios-build/tree/master/build/openssl)

* The `package/pkg/depot`, `package/pkg/system-repository` and
  `package/pkg/zones-proxy` packages have been removed from OmniOS.
  The first two were not previously installable without work and the
  latter could only be installed in a non-global zone, where it did no good
  without the corresponding part in the global zone.
  `package/pkg/zones-proxy` has been marked as obsolete so will be
  automatically removed from non-global zones as they are upgraded.

* `pkg/server` can now serve repositories for publisher names containing
  a hyphen.

* `mountd` and `statd` can now be run on a fixed port.

### Hardware Support

* Support for AVX-512 processor extensions.

* Support for Chelsio T6 Ethernet devices.

* The `audiovia97` driver has been removed.

### Commands and Command Options

* `zpool scrub -p` to pause a scrub.

* `ipadm -T dhcp -h <hostname>` to specify a hostname that will be sent to
  the DHCP server in order to request an association. Existing DHCP addresses
  can have this added via `ipadm set-addrprop -p reqhost=<hostname> <if>`.

* New `nvmeadm` utility to manage NVMe controllers and namespaces.

* New `zfs program` facility to run lua scripts to perform batch
  administrative ZFS operations.
  See [Issue 7431](https://www.illumos.org/issues/7431) for more details,
  man page and examples.

* `xargs` has a new option `-P <maxprocs>` to run up to *maxprocs* parallel
  child processes.

* `last` has a new option `-l` to show longer dates and times, including
  the current year.

### Developer Features

* `ld` now handles arguments of the form `-Wl,-z,aslr` (two commas).
  This is a compiler argument which should result in the linker being called
  with `-z aslr` but some buggy build systems pass it directly to the
  linker.

* GCC 5 has been upgraded to 5.4.0 and **moved to `/opt/gcc-5`** to reflect
  the new numbering scheme used from version 5 onwards. The mediated symlinks
  in /usr/bin are still the best way to invoke GCC but you may need to update
  your `$PATH` or scripts if you have previously explicitly used
  `/opt/gcc-5.1.0`.

* GCC version 6 is now available - `pkg install developer/gcc6` - and can be
  found in `/opt/gcc-6`.
  Note that GCC 6's default standard for C++ is `-std=gnu++14`. This is a
  change from GCC 5 which used `-std=gnu++98`. Some software may assume
  gnu++98 and to compile it with GCC 6 you will need to specify
  `--std=gnu++98` or update the software. More detail on the changes in GCC 6
  can be found on
  [the gcc web site](https://gcc.gnu.org/gcc-6/changes.html).

* Perl has been upgraded to 5.24.2 and the components have been renamed to
  remove the minor version from paths. This means that modules no longer
  have to be rebuilt/moved following minor perl upgrades. The version of perl
  shipped with OmniOS is for internal system use and should not be relied on
  for anything else.

* All of the constraints delivered under `incorporation/jeos/omnios-userland`
  are now protected with `version-lock` facets. This allows each constraint
  to be selectively disabled. This is most useful for people developing
  OmniOS but can also aid temporary local package updates. Example:

  `omnios# pkg change-facet version-lock.web/wget=false`

  To revert, set the facet to `none`

  `omnios# pkg change-facet version-lock.web/wget=none`

* New `omnios-build-tools` package to easily install everything required to
  build OmniOS userland.

* It is now possible to build OmniOS in a non-global zone (with the caveat
  that it is not possible to build release media in a NGZ).

### Deprecated features

* The `calendar` utility has been removed.
* The `audiovia97` driver has been removed.
* GCC version 5 will be removed in the next stable version of OmniOS, r151026.

### Package changes ([+] Added, [-] Removed, [\*] Changed)

XXX

