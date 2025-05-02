<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151054

Stable and Long-Term-Supported (LTS) Release, 5th of May 2025

`uname -a` shows `omnios-r151054-6ad70ba62c`

r151054 release repository: https://pkg.omnios.org/r151054/core

## Upgrade Notes

Upgrades are supported from the r151046, r151050 and r151052 releases only. If
upgrading from an earlier version, upgrade in stages, referring to the table at
<https://omnios.org/upgrade>.

The `grub` boot loader is no longer supported as of this release. Please ensure
that you have migrated to the new boot loader prior to upgrading.

## New features since r151052

### System Features

* Python has been upgraded to version 3.13, replacing version 3.12 used in the
  previous release.

* OmniOS userland (that is, the packages that come from the
  [omnios-build](https://github.com/omniosorg/omnios-build/tree/r151054)
  repository) are now built with gcc version 14.

* When an SMF service fails to exec a service or helper, it now records a
  message to reflect that in the service log file.

### Commands and Command Options

* The legacy portable 7-zip package (p7zip) has been replaced with a native
  7zip package.

* It is now possible to replace the system `file` command with the third party
  darwinsys variant via a mediator. Installing the `system/file` package will
  automatically select the darwinsys variant, and you can switch back to the
  illumos one by uninstalling the package or manually setting the mediator
  as follows:
  ```
  pfexec pkg set-mediator -I illumos file
  ```

* Snoop can now decode RFC8106 DNS options.

* The `pcidb` utility now intuits which tables to search from the provided
  filter if not are specified.

* `mkfs_pcfs` now supports sector sizes other than 512 bytes.

* The [modunload(8)](https://man.omnios.org/modunload) command can now take a
  module name as a parameter.

* `nc` has a new `-B` flag to attempt to bypass the IPsec policy and force
  clear text.

* `nvmeadm` has additional support for retrieving log pages from supported
  devices.

* The new `developer/dtc` package provides a device tree compiler.

### Modular debugger

* Improved support for working with anonymous structs and unions.

* The `::dis` command now supports physical addresses via a new `-p` flag.

* THe `::printf` command now supports VLA strings.

* Commands to display stack traces now support additional options to display
  type data (`-t`), stack sizes (`-s`) and raw addresses (`-n`).

* Stack traces involving calls to functions that the compilers knows do not
  return now include more symbol information, and information that is more
  accurate.

* New `::bitx` dcmd to extra or set a range of bits in a value.

### Libraries and Library Functions

* OpenSSL 3 is now built with native API compatibility. In prior releases,
  it was built with compatibility for the OpenSSL 1.1.1 API to ease transition.
  In case of problems building older software, the previous behaviour can be
  selected by adding `-DOPENSSL_API_COMPAT=10101` to the compiler arguments.

* `libmagic.so.1` is now available via the `library/libmagic` package.

* The [fdclose(3C)](https://man.omnios.org/fdclose) function has been added to
  libc.

* [dprintf(3C)](https://man.omnios.org/printf.3c) and
  [vdprintf(3C)](https://man.omnios.org/vprintf.3c) functions from POSIX 2008
  added.

* The POSIX 2024 [wcslcat(3C)](https://man.omnios.org/wcslcat) and
  [wcslcpy(3C)](https://man.omnios.org/wcslcpy) have been added to libc.

* The POSIX 2024 [getlocalename_l(3C)](https://man.omnios.org/getlocalename_l)
  function has been added to libc.

* [posix_spawn(3C)](https://man.omnios.org/posix_spawn) now supports the
  `POSIX_SPAWN_SETSID` flag introduced in POSIX 2024.

* Added [posix_spawn_file_actions_addchdir(3C) and posix_spawn_file_actions_addfchdir(3C)](https://man.omnios.org/posix_spawn_file_actions_addchdir)
  from POSIX 2024.

* The [secure_getenv(3C)](https://man.omnios.org/secure_getenv) function from
  POSIX 2024 has been added.

* POSIX 2024 added some functions to
  [<stdlib.h>](https://man.omnios.org/stdlib.h). These functions were already
  supported in OmniOS but the header has been updated to place them in the
  correct scope with respect to the selected standard.

* The C23 [<stdbit.h>](https://man.omnios.org/stdbit.h) header and supporting
  functions have been added.

* Added [ptimespec_getres(3C)](https://man.omnios.org/timespec_getres) and
  the `TIME_MONOTONIC`, `TIME_ACTIVE` and `TIME_ACTIVE_THREAD` time bases
  from C23, and a new illumos-specific `CLOCK_THREAD_ACTIVE_USR` base.

### Zones

* VNICs passed into zones can now access more interface properties that
  previously showed up as `?`.

### LX zones

* Fix for incorrect ELF header parsing that, in some cases, lead to binaries
  in LX zones running with the incorrect stack size.

### Bhyve

* The packaged bhyve UEFI firmware is now based on upstream EDK-II version
  202411.

* Bhyve supports AMD performance counters.

* Improvements to CPUID data exposed to guests.

* Bhyve now supports an experimental virtual TPM via the `swtpm` package
  (available in the omnios-extra package repository).

### Package Management

* There is now a short flag for the long `--temp-be-activate` flag. `-t` can
  be used instead.

### Hardware Support

* Improved support for processor C-States on AMD processors resulting in lower
  power consumption when idling.

* The zen UMC driver has been updated with support for decoding items in DF
  revision 4.2.

* Initial kernel support for Strix Halo and Krackan AMD parts.

* Update PCI classes and capabilities to PCI version 1.18.

### Developer Features

* The gcc compilers no longer bundle "fixed" headers. These were not required
  when building software and could shadow fixes in OmniOS system headers.

* gcc has been updated to allow the %j and %z length modifiers in kernel code.

* The OmniOS build framework now recognises the `XPG7` and `XPG8` standards as
  arguments to the `set_standard` statement.

* When building OmniOS packages it is now possible to use the new `-M` option
  to temporarily override the mirror from which sources are fetched.

* The vim C syntax files have been updated to recognise illumos-specific
  signal names.

### Deprecated features

* The `grub` boot loader is deprecated and has been removed in the r151054
  release. It will be supported in r151046 for the full LTS time frame, up to
  May 2026. If you have not yet migrated to the new boot loader, and would like
  assistance, please
  [get in touch](https://omnios.org/about/contact).

* OpenSSL 1.0.x and 1.1.1 are deprecated and reached end-of-support at the end
  of 2019 and in September 2023 respectively.
  OmniOS has transitioned to OpenSSL 3 and still ships older versions for
  backwards compatibility, but these are maintained solely on a best-efforts
  basis. If possible, recompile software to use OpenSSL 3.

* Python 2 is now end-of-life and will not receive any further updates. The
  `python-27` package is still available for backwards compatibility but will
  be maintained only on a best-efforts basis.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| **compress/7zip** | _New_ | 24.9
| compress/gzip | 1.13 | 1.14
| compress/lzip | 1.24.1 | 1.25
| ~~compress/p7zip~~ | 16.2 | _Removed_
| compress/xz | 5.6.2 | 5.8.1
| compress/zstd | 1.5.6 | 1.5.7
| database/sqlite-3 | 3.46.1 | 3.49.1
| **developer/aarch64-build-tools** | _New_ | 11
| developer/build/libtool | 2.4.7 | 2.5.4
| ~~developer/gcc7~~ | 7.5.0 | _Removed_
| developer/gnu-binutils | 2.43.1 | 2.44
| developer/swig | 4.2.1 | 4.3.0
| developer/versioning/git | 2.46.3 | 2.49.0
| developer/versioning/mercurial | 6.8.1 | 7.0
| ~~driver/x11/winlock~~ | 0.5.11 | _Removed_
| editor/vim | 9.1.652 | 9.1.1202
| file/gnu-coreutils | 9.5 | 9.6
| library/glib2 | 2.82.1 | 2.82.5
| library/libidn | 1.42 | 1.43
| **library/libmagic** | _New_ | 5.46
| library/libtool/libltdl | 2.4.7 | 2.5.4
| library/lzlib | 1.14 | 1.15
| library/mpfr | 4.2.1 | 4.2.2
| library/nghttp2 | 1.63.0 | 1.65.0
| library/nspr | 4.35 | 4.36
| library/pcre2 | 10.44 | 10.45
| ~~library/python-3/asn1crypto-312~~ | 1.5.1 | _Removed_
| **library/python-3/asn1crypto-313** | _New_ | 1.5.1
| ~~library/python-3/attrs-312~~ | 24.2.0 | _Removed_
| **library/python-3/attrs-313** | _New_ | 25.3.0
| ~~library/python-3/cffi-312~~ | 1.17.0 | _Removed_
| **library/python-3/cffi-313** | _New_ | 1.17.1
| ~~library/python-3/coverage-312~~ | 7.6.1 | _Removed_
| **library/python-3/coverage-313** | _New_ | 7.7.1
| ~~library/python-3/crossenv-312~~ | 1.4.0 | _Removed_
| **library/python-3/crossenv-313** | _New_ | 1.5.0
| ~~library/python-3/cryptography-312~~ | 43.0.0 | _Removed_
| **library/python-3/cryptography-313** | _New_ | 44.0.2
| ~~library/python-3/idna-312~~ | 3.7 | _Removed_
| **library/python-3/idna-313** | _New_ | 3.10
| ~~library/python-3/js-regex-312~~ | 1.0.1 | _Removed_
| **library/python-3/js-regex-313** | _New_ | 1.0.1
| ~~library/python-3/jsonrpclib-312~~ | 0.4.3.3 | _Removed_
| **library/python-3/jsonrpclib-313** | _New_ | 0.4.3.4
| ~~library/python-3/jsonschema-312~~ | 4.17.3 | _Removed_
| **library/python-3/jsonschema-313** | _New_ | 4.17.3
| ~~library/python-3/meson-312~~ | 1.5.1 | _Removed_
| **library/python-3/meson-313** | _New_ | 1.7.0
| ~~library/python-3/orjson-312~~ | 3.10.7 | _Removed_
| **library/python-3/orjson-313** | _New_ | 3.10.16
| ~~library/python-3/packaging-312~~ | 24.2 | _Removed_
| **library/python-3/packaging-313** | _New_ | 24.2
| ~~library/python-3/pip-312~~ | 24.2 | _Removed_
| **library/python-3/pip-313** | _New_ | 25.0.1
| ~~library/python-3/pycodestyle-312~~ | 2.12.1 | _Removed_
| **library/python-3/pycodestyle-313** | _New_ | 2.12.1
| ~~library/python-3/pycparser-312~~ | 2.22 | _Removed_
| **library/python-3/pycparser-313** | _New_ | 2.22
| ~~library/python-3/pycurl-312~~ | 7.44.1 | _Removed_
| **library/python-3/pycurl-313** | _New_ | 7.45.6
| ~~library/python-3/pyopenssl-312~~ | 24.2.1 | _Removed_
| **library/python-3/pyopenssl-313** | _New_ | 25.0.0
| ~~library/python-3/pyrsistent-312~~ | 0.20.0 | _Removed_
| **library/python-3/pyrsistent-313** | _New_ | 0.20.0
| ~~library/python-3/pyyaml-312~~ | 6.0.2 | _Removed_
| **library/python-3/pyyaml-313** | _New_ | 6.0.2
| ~~library/python-3/rapidjson-312~~ | 1.20 | _Removed_
| **library/python-3/rapidjson-313** | _New_ | 1.20
| ~~library/python-3/semantic-version-312~~ | 2.10.0 | _Removed_
| **library/python-3/semantic-version-313** | _New_ | 2.10.0
| ~~library/python-3/setuptools-312~~ | 73.0.1 | _Removed_
| **library/python-3/setuptools-313** | _New_ | 78.1.0
| ~~library/python-3/setuptools-rust-312~~ | 1.10.1 | _Removed_
| **library/python-3/setuptools-rust-313** | _New_ | 1.11.0
| ~~library/python-3/six-312~~ | 1.16.0 | _Removed_
| **library/python-3/six-313** | _New_ | 1.17.0
| ~~library/python-3/tomli-312~~ | 2.0.1 | _Removed_
| **library/python-3/tomli-313** | _New_ | 2.2.1
| ~~library/python-3/typing-extensions-312~~ | 4.12.2 | _Removed_
| **library/python-3/typing-extensions-313** | _New_ | 4.13.0
| library/security/openssl | 3.3.2 | 3.5.0
| library/security/openssl-3 | 3.3.3 | 3.5.0
| network/dns/bind | 9.18.30 | 9.18.35
| network/openssh | 9.9.2 | 10.0.2
| network/openssh-server | 9.9.2 | 10.0.2
| network/socat | 1.8.0.1 | 1.8.0.3
| network/test/iperf | 3.17.1 | 3.18
| runtime/perl | 5.40.1 | 5.40.2
| ~~runtime/python-312~~ | 3.12.9 | _Removed_
| **runtime/python-313** | _New_ | 3.13.3
| security/sudo | 1.9.16 | 1.9.16.2
| service/network/chrony | 4.5 | 4.6.1
| service/network/smtp/dma | 0.13 | 0.14
| shell/pipe-viewer | 1.8.14 | 1.9.31
| shell/tcsh | 6.24.13 | 6.24.15
| ~~source/system/grub~~ | 0.97 | _Removed_
| system/bhyve/firmware | 20230801 | 20241101
| ~~system/boot/grub~~ | 0.97 | _Removed_
| system/cpuid | 1.8.2 | 1.8.3
| system/data/hardware-registry | 2024.3.31 | 2025.1.27
| system/data/zoneinfo | 2024.1 | 2025.2
| **system/file** | _New_ | 5.46
| system/library/dbus | 1.14.10 | 1.16.2
| system/library/libdbus | 1.14.10 | 1.16.2
| system/library/libdbus-glib | 0.112 | 0.114
| system/library/mozilla-nss | 3.105 | 3.110
| ~~system/library/python/libbe-312~~ | 0.5.11 | _Removed_
| **system/library/python/libbe-313** | _New_ | 0.5.11
| ~~system/library/python/solaris-312~~ | 0.5.11 | _Removed_
| **system/library/python/solaris-313** | _New_ | 0.5.11
| ~~system/library/python/zfs-312~~ | 0.5.11 | _Removed_
| **system/library/python/zfs-313** | _New_ | 0.5.11
| system/management/cloud-init | 23.4.1 | 24.4.1
| system/rsyslog | 8.2408.0 | 8.2502.0
| system/test/fio | 3.37 | 3.39
| **system/test/tztest** | _New_ | 0.5.11
| system/virtualization/open-vm-tools | 12.4.5 | 12.5.0
| system/watch | 3.3.16 | 4.0.5
| text/gnu-diffutils | 3.10 | 3.11
| text/gnu-gettext | 0.22.5 | 0.24
| text/less | 661 | 668
| web/curl | 8.12.0 | 8.13.0
| web/wget2 | 2.1.0 | 2.2.0
