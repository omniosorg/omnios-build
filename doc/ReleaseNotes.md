<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151056

## r151056k (2026-01-14)
Weekly release for w/c 12th of January 2026.
> This update requires a reboot

### Security Fixes

* Curl updated to version 8.18.0.

* The bhyve mouse driver could de-reference a NULL pointer in some
  circumstances.

### Other Changes

* SMB Active Directory joins now fall back to seting the machine password via
  LDAP if kerberos fails. Many AD sites block kerberos for this.

* NVMe devices used as a system boot device would previously end up with a
  single I/O queue, limiting performance.

* NVMe devices could incorrectly return an error on queue saturation that
  is interpreted by ZFS as a device failure.

* The IP Filter fragment cache table could become corrupt, resulting in a
  kernel panic.

<br>

---

## r151056d (2025-11-26)
Weekly release for w/c 24th of November 2025.
> This update requires a reboot

### Security Fixes

* Update Intel CPU microcode to 20251111.

* Update AMD CPU microcode to 20251030.

* Disable the faulty `RDSEED` instruction on vulnerable Zen5 processors.

### Other Changes

* Under specific circumstances, transactions in the ZFS transaction log could
  be replayed out of order following an unexpected system restart, potentially
  resulting in data corruption.

* Unloading the `softmac` driver could result in a system panic.

* The `pcieadm` utility can now decode Virtio vendor-specific capabilities.

* Fix for a NFS client regression with macOS 14 server.

* `git` updated to version 2.51.2

* `OpenJDK` packages updated to versions 1.8.472-08, 11.0.29+7, 17.0.17+10 and
  21.0.9+10.

* `Python` updated to version 3.13.9.

<br>

---

Stable Release, 3rd of Nov 2025

`uname -a` shows `omnios-r151056-128de81dcd`

r151056 release repository: https://pkg.omnios.org/r151056/core

## Upgrade Notes

Upgrades are supported from the r151054 release only. If upgrading from an
earlier version, upgrade in stages, referring to the table at
<https://omnios.org/upgrade>.

## New features since r151054

### System Features

* Added support for management of NVMe namespaces on devices which support it.

* The performance of the [gethrtime(3c)](https://man.omnios.org/man3c/gethrtime)
  library function has been significantly improved via use of the shared
  comm page.

* The kernel runtime linker has been enhanced so that it is able to load larger
  kernel modules.

* The DHCP "Interface MTU" option is now honoured when configuring network
  interfaces via DHCP.

* Support for SMBIOS version 3.9.

### Commands and Command Options

* [sed(1)](https://man.omnios.org/sed)
  can now process common escapes for `\r`, `\n` and `\t`

* The [pcre2(3)](https://man.omnios.org/pcre2) library is now built with JIT
  support.

* [pmap(1)](https://man.omnios.org/pmap) now labels the comm page segment as
  such.

* [ucodeadm(8)](https://man.omnios.org/ucodeadm) can now inspect and manage
  binary AMD microcode files.

* [pkg(1)](https://man.omnios.org/man1/pkg) supports a new option `--with-be`
  to allow running pkg pieces in an alternative boot environment.

* [kstat(1)](https://man.omnios.org/man8/kstat) supports a new `-V` option that
  can be used in conjunction with `-p` to output just the kstat value.

* The stack backtrace commands in [mdb(1)](https://man.omnios.org/mdb) such as
  `::findstack` now support two additional options. `-t` will include function
  and parameter type information, and `-s` will show the change in stack size
  between frames. These commands have also been enhanced to show the probable
  function name when handling calls to functions that do not return.

* [mdb(1)](https://man.omnios.org/mdb) has a new `::bcmp` dcmd to compare
  memory regions.

### Libraries and Library Functions

* The POSIX [getlocalename_l(3C)](https://man.omnios.org/getlocalename_l)
  library function has been added.

* [getaddrinfo(3XNET) ](https://man.omnios.org/man3xnet/getaddrinfo) will now
  always return multiple entries for an unspecified socket type. It would
  previously only do this when the requested service did not appears in
  [services(5)](https://man.omnios.org/services).

### LX zones

* The emulated LX proc filesystem now exposes tunables for network buffer size
  and panic-on-oops.

### Hardware Support

* [nvmeadm(8)](https://man.omnios.org/nvmeadm) has received multiple updates
  to extend support for vendor-specific log pages and commands.

* The `cxgbe` network interface driver has been updated to improve performance
  and fix multiple issues.

* The `rge` network interface driver has been updated to fix an issue caused
  when device statistics are required before the device is fully initialised.

### Installer

* It was previously not possible to configure the serial console configuration
  during installation for anything other than `ttya`; this has been corrected.

### Deprecated features

* The `grub` boot loader is deprecated and has been removed in the r151048
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

* OpenSSH in OmniOS no longer provides support for GSSAPI key exchange.
  This was removed in release r151038.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| compress/7zip | 24.9 | 25.1
| data/iso-codes | 4.17.0 | 4.18.0
| database/sqlite-3 | 3.49.1 | 3.50.4
| developer/build/automake | 1.17 | 1.18.1
| developer/gcc13 | 13.3.0 | 13.4.0
| developer/gcc14 | 14.2.0 | 14.3.0
| developer/gnu-binutils | 2.44 | 2.45
| developer/macro/gnu-m4 | 1.4.19 | 1.4.20
| developer/swig | 4.3.0 | 4.3.1
| developer/versioning/git | 2.49.0 | 2.51.0
| developer/versioning/mercurial | 7.0 | 7.0.2
| editor/vim | 9.1.1202 | 9.1.1730
| file/gnu-coreutils | 9.6 | 9.8
| library/glib2 | 2.82.5 | 2.84.4
| library/libxml2 | 2.13.8 | 2.14.6
| library/libxslt | 1.1.42 | 1.1.43
| library/nghttp2 | 1.65.0 | 1.67.1
| library/nspr | 4.36 | 4.37
| library/pcre2 | 10.45 | 10.46
| library/python-3/cffi-313 | 1.17.1 | 2.0.0.1
| library/python-3/coverage-313 | 7.7.1 | 7.10.6
| library/python-3/cryptography-313 | 44.0.2 | 45.0.7
| library/python-3/meson-313 | 1.7.0 | 1.9.0
| library/python-3/orjson-313 | 3.10.16 | 3.11.3
| library/python-3/packaging-313 | 24.2 | 25.0
| library/python-3/pip-313 | 25.0.1 | 25.2
| library/python-3/pycodestyle-313 | 2.12.1 | 2.14.0
| library/python-3/pyopenssl-313 | 25.0.0 | 25.1.0
| library/python-3/setuptools-313 | 78.1.0 | 80.9.0
| library/python-3/setuptools-rust-313 | 1.11.0 | 1.12.0
| library/python-3/typing-extensions-313 | 4.13.0 | 4.15.0
| library/readline | 8.2.13 | 8.3
| ~~library/security/liboqs~~ | 0.12.0 | _Removed_
| ~~library/security/oqs-provider~~ | 0.8.0 | _Removed_
| network/dns/bind | 9.18.35 | 9.18.39
| network/test/iperf | 3.18 | 3.19.1
| runtime/perl | 5.40.2 | 5.42.0
| runtime/python-313 | 3.13.3 | 3.13.7
| security/sudo | 1.9.17.1 | 1.9.17.2
| service/network/chrony | 4.6.1 | 4.8
| service/network/ntpsec | 1.2.3 | 1.2.4
| shell/bash | 5.2.32 | 5.3
| shell/pipe-viewer | 1.9.31 | 1.9.34
| shell/tcsh | 6.24.15 | 6.24.16
| system/data/hardware-registry | 2025.1.27 | 2025.6.9
| system/library/mozilla-nss | 3.110 | 3.116
| system/microcode/amd | 20241121 | 20250729
| system/pciutils | 3.13.0 | 3.14.0
| system/rsyslog | 8.2502.0 | 8.2508.0
| system/test/fio | 3.39 | 3.41
| system/virtualization/open-vm-tools | 12.5.0 | 13.0.0
| text/gawk | 5.3.1 | 5.3.2
| text/gnu-diffutils | 3.11 | 3.12
| text/gnu-gettext | 0.24 | 0.26
| text/gnu-grep | 3.11 | 3.12
| text/gnu-patch | 2.7.6 | 2.8
| text/less | 668 | 679
