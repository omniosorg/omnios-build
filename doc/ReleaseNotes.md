<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151042

## r151042al (2023-01-18)
Weekly release for w/c 16th of January 2023.
> This is a non-reboot update

### Security Fixes

* The `git` package has been updated to a version which includes a fix for
  [CVE-2022-23521(https://github.com/git/git/security/advisories/GHSA-c738-c5qq-xg89).

* `sudo` has been updated to address
  [CVE-2023-22809](https://www.sudo.ws/security/advisories/sudoedit_any/).

<br>

---

## r151042ai (2022-12-31)
Weekly release for w/c 26th of December 2022.
> This is a non-reboot update

### Security Fixes

* [15295 SMB servers did not always check IPC caller privileges](https://www.illumos.org/issues/15295)

<br>

---

## r151042ah (2022-12-24)
Weekly release for w/c 19th of December 2022.
> This update requires a reboot

### Security Fixes

* Curl updated to 7.87.0

* Intel CPU microcode updated to 20221108

* Python updated to version 3.10.9

* Sudo updated to version 1.9.12p1

### Other Changes

* Fix for excessive CPU consumption by rust binaries in lx zones

* 15286 do_composition() needs sign awareness

<br>

---

## r151042aa (2022-11-01)
Weekly release for w/c 31st of October 2022.
> This is a non-reboot update

### Security Fixes

* OpenSSL upgraded to version 3.0.7 and 1.1.1s, fixing
  [CVE-2022-3602](https://nvd.nist.gov/vuln/detail/CVE-2022-3602),
  [CVE-2022-3786](https://nvd.nist.gov/vuln/detail/CVE-2022-3786).

<br>

---

## r151042z (2022-10-26)
Weekly release for w/c 24th of October 2022.
> This is a non-reboot update

### Security Fixes

* curl updated to version 7.86.0, fixing
  [CVE-2022-42916](https://curl.se/docs/CVE-2022-42916.html),
  [CVE-2022-42915](https://curl.se/docs/CVE-2022-42915.html),
  [CVE-2022-35260](https://curl.se/docs/CVE-2022-35260.html) and
  [CVE-2022-32221](https://curl.se/docs/CVE-2022-32221.html).

* OpenJDK packages updated to versions 1.8.352-08, 11.0.17+8 and 17.0.5+8.

### Other Changes

* The 64-bit `libzstd.pc` file was incorrect.

<br>

---

## r151042y (2022-10-19)
Weekly release for w/c 17th of October 2022.
> This update requires a reboot

### Security Fixes

* libxml2 has been updated to 2.10.3, fixing
  [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303),
  [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304)

* zlib has been updated to 1.2.13, fixing
  [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434)

### Other Changes

* It was possible to see occasional failures in port\_associate(3C) when
  using event ports

* The previous fix ([illumos 14788](https://www.illumos.org/issues/14788))
  for /proc/fdinfo could occasionally cause event ports to misbehave

* The bundled AMD CPU microcode has been updated to version 20220930

* Python has been updated to version 3.10.8

* The bhyve VNC server did not properly handle connections from the native
  Screen Sharing client in MacOS Ventura

<br>

---

## r151042v (2022-09-27)
Weekly release for w/c 26th of September 2022.
> This update requires a reboot

### Security Fixes

* A race condition in the fdinfo directory without procfs could cause a system
  panic

* Expat has been updated to version 2.4.9, fixing
  [CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674).

* The bundled Intel CPU microcode has been updated to 20220809

### Other Changes

* bhyve has been updated to fix some issues within the emulated network
  and NVMe devices

* The timezone database files have been updated

* Python has been updated to version 3.10.7

* A memory corruption problem in the boot loader that caused problems running
  under VMware has been corrected

<br>

---

## r151042r (2022-08-30)
Weekly release for w/c 29th of August 2022.
> This is a non-reboot update

### Security Fixes

* `open-vm-tools` updated to version 12.1.0, fixing
  [CVE-2022-31676](https://www.vmware.com/security/advisories/VMSA-2022-0024.html)

### Other Changes

* `library/libxml2` updated to version 2.10.1

<br>

---

## r151042q (2022-08-25)
Weekly release for w/c 22nd of August 2022.
> This is a non-reboot update

### Security Fixes

* `compress/xz` updated to version 5.2.6, fixing
  [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271).

* `library/libxml2` updated to version 2.10.0, fixing
  [CVE-2022-2309](https://nvd.nist.gov/vuln/detail/CVE-2022-2309).

* `library/zlib` updated to fix
  [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434).

* Fix for a boundary condition in the 9p library used by bhyve.

### Other Changes

* Added `runtime/java/runtime64` package, which is just a rename to
  `runtime/java`, to aid developers working on illumos-gate.

<br>

---

## r151042o (2022-08-10)
Weekly release for w/c 8th of August 2022.
> This update requires a reboot

### Security Fixes

* Fix for Post-barrier Return Stack Buffer Predictions
  [CVE-2022-26373](https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/post-barrier-return-stack-buffer-predictions.html)

* Fix for a rare kernel panic due to a race condition in poll()

* net-snmp updated to version 5.9.3, fixing
  [CVE-2022-24805](https://nvd.nist.gov/vuln/detail/CVE-2022-24805),
  [CVE-2022-24809](https://nvd.nist.gov/vuln/detail/CVE-2022-24809),
  [CVE-2022-24806](https://nvd.nist.gov/vuln/detail/CVE-2022-24806),
  [CVE-2022-24807](https://nvd.nist.gov/vuln/detail/CVE-2022-24807),
  [CVE-2022-24808](https://nvd.nist.gov/vuln/detail/CVE-2022-24808) and
  [CVE-2022-24810](https://nvd.nist.gov/vuln/detail/CVE-2022-24810)

* AMD CPU microcode updated to latest versions as of 20220408

* Python 3.10 updated to version 3.10.6

* OpenJDK packages updated to versions 1.8.345-01, 11.0.16+8 and 17.0.4+8

* OpenSSL updated to version 1.1.1q and 3.0.5

### Other Changes

* Updates to ZFS to gracefully handle unknown/invalid vdev device IDs

<br>

---

## r151042i (2022-06-30)
Weekly release for w/c 27th of June 2022.
> This update requires a reboot

### Security Fixes

* OpenSSL 3.0.4 patched, fixing GSD-2022-1002526 heap overflow.

* Intel CPU microcode has been updated to version 20220510.

* curl updated to version 7.84.0, fixing
  [CVE-2022-32208](https://curl.se/docs/CVE-2022-32208.html),
  [CVE-2022-32207](https://curl.se/docs/CVE-2022-32207.html),
  [CVE-2022-32206](https://curl.se/docs/CVE-2022-32206.html) and
  [CVE-2022-32205](https://curl.se/docs/CVE-2022-32205.html).

<br>

---

## r151042h (2022-06-22)
Weekly release for w/c 20th of June 2022.
> This update requires a reboot

### Security Fixes

* OpenSSL has been updated to versions 3.0.4 and 1.1.1p, fixing
  [CVE-2022-2068](https://www.openssl.org/news/secadv/20220621.txt).

* Intel CPU microcode has been updated to version 20220419.

### Other Changes

* Python 3.10 has been updated to version 3.10.5

* tcsh has been updated to version 6.24.01

<br>

---

## r151042b (2022-05-12)
Weekly release for w/c 9th of May 2022.
> This is a non-reboot update

### Security Fixes

* libxml2 updated to version 2.9.14, fixing
  [CVE-2022-23308](https://nvd.nist.gov/vuln/detail/CVE-2022-23308).

* curl updated to version 7.83.1, fixing
  [CVE-2022-30115](https://curl.se/docs/CVE-2022-30115.html),
  [CVE-2022-27782](https://curl.se/docs/CVE-2022-27782.html),
  [CVE-2022-27781](https://curl.se/docs/CVE-2022-27781.html),
  [CVE-2022-27780](https://curl.se/docs/CVE-2022-27780.html),
  [CVE-2022-27779](https://curl.se/docs/CVE-2022-27779.html) and
  [CVE-2022-27778](https://curl.se/docs/CVE-2022-27778.html).

<br>

---

## r151042a (2022-05-04)
Weekly release for w/c 2nd of May 2022.
> This is a non-reboot update

### Security Fixes

* OpenSSL has been updated to versions 3.0.3 and 1.1.1o, fixing four CVEs.

<br>

---
Stable Release, 2nd of May 2022

`uname -a` shows `omnios-r151042-2a01bcc289`

r151042 release repository: https://pkg.omnios.org/r151042/core

## Upgrade Notes

Upgrades are supported from the r151038 and r151040 releases only. If upgrading
from an earlier version, upgrade in stages, referring to the table at
<https://omnios.org/upgrade>.

The location of the system global configuration for `vim` has been changed to
`/etc/vimrc`. If you had previously created a system-wide vimrc file
under `/usr/share/vim/` then you will need to copy it to the new location.

OpenSSH no longer accepts RSA signatures using SHA-1 by default. When
connecting to very old servers, it may be necessary to selectively re-enable
RSA/SHA1. The following stanza in ~/.ssh/config will enable RSA/SHA1 for a
single destination host:
  ```
  Host old-host
      HostkeyAlgorithms +ssh-rsa
  ```

## New features since r151040

### System Features

* Manual pages have been resectioned to match the numbering scheme used on
  most platforms, instead of the legacy System V numbering. For example, man
  pages which were previously in section *1M* of the manual are now in
  section *8*.
  [illumos IPD 4](https://github.com/illumos/ipd/blob/master/ipd/0004/README.md)
  has more details.

* The standard OpenSSL is now version 3, and version 1.0.2 is not installed
  by default unless it is required by legacy packages. The default OpenSSL
  version can be selected using the `openssl` mediator, for example:
  ```
  pkg set-mediator -V 1.1 openssl
  ```

* `openjdk17` is now available and will be the default system java
  implementation if installed. As for most components, the default openjdk
  version can be changed via a mediator:
  ```
  pkg set-mediator -V 1.8 openjdk
  ```
  > Thanks to Peter Tribble for doing the work to get OpenJDK17 running on
  > illumos.

* Python has been upgraded to version 3.10, replacing version 3.9 used in
  the previous release.

* The python package now includes a variant which contains a dtrace ustack
  helper to aid debugging complex python applications - for more details and
  an example, see <https://omnios.org/article/python-ustack>.

* The system can now detect when its attached vioblk or NVMe disks are
  dynamically resized and grow ZFS pools accordingly (subject to the pool's
  `autoexpand` property).

### Commands and Command Options

* [ipadm(8)](https://man.omnios.org/ipadm) has gained support for configuring
  and managing IP-multiPath (IPMP) interfaces.

* [ar(1)](https://man.omnios.org/man1/ar)  now supports the `-s` option on its
  own. It was previously necessary to also specify `-t` and this change makes
  it easier to build third party software.

* The [dd(1)](https://man.omnios.org/man1/dd) command now supports `status=` to
  allow choosing the way in which information about transfers is reported.

* [snoop(8)](https://man.omnios.org/snoop) has been updated to be able to
  decode more DNS resource record types.

* Cron jobs can now support a randomised delay via the `RANDOM_DELAY` keyword;
  see [crontab(1)](https://man.omnios.org/crontab).

* The [diff(1)](https://man.omnios.org/diff) command now supports the `-q`
  option.

* Direct execution of compiled ksh scripts and of Java .jar files is now
  supported.

### Libraries and Library Functions

* The [memrchr(3C)](https://man.omnios.org/memrchr) function has been added
  to the standard C library.

* Static initialisers are now provided for error checking and recursive
  mutexes:
  * `PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP`
  * `PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP`

  These complement the existing:

  * `PTHREAD_MUTEX_INITIALIZER`

* The `TCP_QUICKACK` socket option is now supported; see
  [tcp(7P)](https://man.omnios.org/man7p/tcp).

* `fchmodat(AT_SYMLINK_NOFOLLOW)` now works for plain files (non-symlinks).

### Zones

* Any error output emitted by a zone during boot was previously lost and is
  now shown by [zoneadm(8)](https://man.omnios.org/zoneadm).

### LX zones

* Added support for running more recent distributions which use newer versions
  of glibc.

* Compatibility fixes to the `sendfile` system call.

* Improve support for Linux's SECCOMP. This allows elasticsearch8 to run in
  LX zones.

### Bhyve

* The built-in VNC server has been improved, allows multiple concurrent
  connections and supports more alternative pixel formats.

* The internal clock implementation has been improved, resulting in better
  timer calibration by guests.

* The bhyve SMBIOS type 3 structure was incorrect.

* Persistent UEFI environment variables are now supported. These are enabled
  by default when booting with a UEFI bootrom but can be disabled on a
  per-zone basis via the new `uefivars` attribute - see
  [bhyve(7)](https://man.omnios.org/man7/bhyve).

* The emulated NVMe device has received many fixes, now reports as NVMe 1.4,
  and passes the
  [UNH NVMe compliance tests](https://www.iol.unh.edu/testing/storage/nvme).

* Dynamic disk resizing is now supported for both virtio and NVMe disks.
  Guests receive notifications when a disk is resized and many (including
  OmniOS) will automatically detect the new size.

### ZFS

* A new ZFS channel program is available, `zfs.sync.change-key`, which allows
  changing a dataset's encryption key in the context of a channel program.

* `zpool online -e` can now properly expand whole-disk EFI pools that are
  backed by blkdev or sd drivers.

### Drivers and Hardware Support

* Support for Amazon Nitro instances has been added via the new `ENA` driver.

* It is now possible to use OmniOS inside a Gen 2 Hyper-V virtual machine
  via a serial console. VGA is not yet supported.

* There have been multiple improvements to NVMe support.

* The Intel I219 v16-v23 network cards are now supported.

* The bundled firmware for `cxgbe` network devices has been updated to version
  1.26.4.0.

* A new Smart Array storage controller driver (`smrt`) is available.

* Support for SMBIOS 3.5 has been added.

### Developer Features

* It is now possible to configure the system to include any DWARF data found
  in objects in their core files. This can be enabled globally or on a per
  process basis using [coreadm(8)](https://man.omnios.org/coreadm.8).

* There have been several improvements to the linker,
  [ld(1)](https://man.omnios.org/ld) to better support clang and rust.

* [elfdump(1)](https://man.omnios.org/elfdump) now understands LLVM section
  types.

* Kernel modules are now linked with `type=kmod`.

* The modular debugger - [mdb(8)](https://man.omnios.org/mdb) - can now support
  separators in numbers using the underscore (\_) character. This makes it
  easier to enter long numbers, e.g. `0x123_456_789`.

* The `sys/atomic.h` header file has been restructured to resolve problems with
  some guards.

* The `sys/mman.h` header file has been updated, fixing several problems with
  symbol visibility and portability.
  [illumos issue 14418](https://www.illumos.org/issues/14418) has more details.

### Deprecated features

* OpenSSH no longer accepts RSA signatures using SHA-1 by default.

* OpenSSH in OmniOS no longer provides support for GSSAPI key exchange.
  This was removed in release r151038.

* Python 2 is now end-of-life and will not receive any further updates. The
  `python-27` package is still available for backwards compatibility but will
  be maintained only on a best-efforts basis.

* OpenSSL 1.0.x is deprecated and reached end-of-support at the end of 2019.
  OmniOS core software uses the newer OpenSSL 3 and 1.1.1 libraries but retains
  the OpenSSL 1.0.2 libraries for backwards compatibility. The 1.0.2 libraries
  are maintained solely on a best-efforts basis.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| **compress/lzip** | _New_ | 1.23
| compress/zstd | 1.5.0 | 1.5.2
| data/iso-codes | 4.7.0 | 4.9.0
| database/sqlite-3 | 3.36.0 | 3.38.2
| developer/build/automake | 1.16.4 | 1.16.5
| developer/dtrace/toolkit | 0.99 | 0.99.20220214
| ~~developer/gcc44~~ | 4.4.4 | _Removed_
| ~~developer/gcc44/libgmp-gcc44~~ | 5.0.2 | _Removed_
| ~~developer/gcc44/libmpc-gcc44~~ | 0.8.2 | _Removed_
| ~~developer/gcc44/libmpfr-gcc44~~ | 3.1.0 | _Removed_
| developer/gnu-binutils | 2.37 | 2.38
| developer/versioning/git | 2.33.2 | 2.35.2
| developer/versioning/mercurial | 5.9.1 | 6.1
| **driver/storage/smrt** | _New_ | 0.5.11
| file/gnu-coreutils | 8.32 | 9.0
| file/gnu-findutils | 4.8.0 | 4.9.0
| library/c++/sigcpp | 3.0.7 | 3.2.0
| library/expat | 2.4.7 | 2.4.8
| library/glib2 | 2.68.4 | 2.72.0
| **library/lzlib** | _New_ | 1.13
| library/ncurses | 6.2 | 6.3
| library/nghttp2 | 1.45.1 | 1.47.0
| library/pcre2 | 10.37 | 10.39
| **library/python-3/asn1crypto-310** | _New_ | 1.5.1
| ~~library/python-3/asn1crypto-39~~ | 1.4.0 | _Removed_
| **library/python-3/attrs-310** | _New_ | 21.4.0
| ~~library/python-3/attrs-39~~ | 21.2.0 | _Removed_
| **library/python-3/cffi-310** | _New_ | 1.15.0
| ~~library/python-3/cffi-39~~ | 1.14.6 | _Removed_
| **library/python-3/cheroot-310** | _New_ | 8.6.0
| ~~library/python-3/cheroot-39~~ | 8.5.2 | _Removed_
| **library/python-3/cherrypy-310** | _New_ | 18.6.1
| ~~library/python-3/cherrypy-39~~ | 18.6.1 | _Removed_
| **library/python-3/coverage-310** | _New_ | 6.3.2
| ~~library/python-3/coverage-39~~ | 5.5 | _Removed_
| **library/python-3/cryptography-310** | _New_ | 36.0.2
| ~~library/python-3/cryptography-39~~ | 3.4.8 | _Removed_
| **library/python-3/idna-310** | _New_ | 3.3
| ~~library/python-3/idna-39~~ | 3.2 | _Removed_
| **library/python-3/jaraco-310** | _New_ | 1.0.0
| ~~library/python-3/jaraco-39~~ | 1.0.0 | _Removed_
| **library/python-3/js-regex-310** | _New_ | 1.0.1
| ~~library/python-3/js-regex-39~~ | 1.0.1 | _Removed_
| **library/python-3/jsonrpclib-310** | _New_ | 0.4.3.2
| ~~library/python-3/jsonrpclib-39~~ | 0.4.2 | _Removed_
| **library/python-3/jsonschema-310** | _New_ | 4.4.0
| ~~library/python-3/jsonschema-39~~ | 3.2.0 | _Removed_
| **library/python-3/mako-310** | _New_ | 1.2.0
| ~~library/python-3/mako-39~~ | 1.1.5 | _Removed_
| **library/python-3/markupsafe-310** | _New_ | 2.1.1
| **library/python-3/meson-310** | _New_ | 0.62.0
| ~~library/python-3/meson-39~~ | 0.59.1 | _Removed_
| **library/python-3/more-itertools-310** | _New_ | 8.12.0
| ~~library/python-3/more-itertools-39~~ | 8.9.0 | _Removed_
| **library/python-3/orjson-310** | _New_ | 3.6.7
| ~~library/python-3/orjson-39~~ | 3.6.3 | _Removed_
| **library/python-3/pip-310** | _New_ | 22.0.4
| ~~library/python-3/pip-39~~ | 21.2.4 | _Removed_
| **library/python-3/ply-310** | _New_ | 3.11
| ~~library/python-3/ply-39~~ | 3.11 | _Removed_
| **library/python-3/portend-310** | _New_ | 3.1.0
| ~~library/python-3/portend-39~~ | 2.7.1 | _Removed_
| **library/python-3/prettytable-310** | _New_ | 3.2.0
| ~~library/python-3/prettytable-39~~ | 2.2.0 | _Removed_
| **library/python-3/pybonjour-310** | _New_ | 1.1.1
| ~~library/python-3/pybonjour-39~~ | 1.1.1 | _Removed_
| **library/python-3/pycodestyle-310** | _New_ | 2.8.0
| ~~library/python-3/pycodestyle-39~~ | 2.7.0 | _Removed_
| **library/python-3/pycparser-310** | _New_ | 2.21
| ~~library/python-3/pycparser-39~~ | 2.20 | _Removed_
| **library/python-3/pycurl-310** | _New_ | 7.44.1
| ~~library/python-3/pycurl-39~~ | 7.44.1 | _Removed_
| **library/python-3/pyopenssl-310** | _New_ | 22.0.0
| ~~library/python-3/pyopenssl-39~~ | 20.0.1 | _Removed_
| **library/python-3/pyrsistent-310** | _New_ | 0.18.1
| ~~library/python-3/pyrsistent-39~~ | 0.18.0 | _Removed_
| **library/python-3/pytz-310** | _New_ | 2022.1
| ~~library/python-3/pytz-39~~ | 2021.1 | _Removed_
| **library/python-3/pyyaml-310** | _New_ | 6.0
| ~~library/python-3/pyyaml-39~~ | 5.4.1 | _Removed_
| **library/python-3/rapidjson-310** | _New_ | 1.6
| ~~library/python-3/rapidjson-39~~ | 1.4 | _Removed_
| **library/python-3/semantic-version-310** | _New_ | 2.9.0
| ~~library/python-3/semantic-version-39~~ | 2.8.5 | _Removed_
| **library/python-3/setuptools-310** | _New_ | 60.10.0
| ~~library/python-3/setuptools-39~~ | 58.0.4 | _Removed_
| **library/python-3/setuptools-rust-310** | _New_ | 1.1.2
| ~~library/python-3/setuptools-rust-39~~ | 0.12.1 | _Removed_
| **library/python-3/six-310** | _New_ | 1.16.0
| ~~library/python-3/six-39~~ | 1.16.0 | _Removed_
| **library/python-3/tempora-310** | _New_ | 5.0.1
| ~~library/python-3/tempora-39~~ | 4.1.1 | _Removed_
| **library/python-3/tomli-310** | _New_ | 2.0.1
| **library/python-3/typing-extensions-310** | _New_ | 4.1.1
| **library/python-3/wcwidth-310** | _New_ | 0.2.5
| ~~library/python-3/wcwidth-39~~ | 0.2.5 | _Removed_
| **library/python-3/zc.lockfile-310** | _New_ | 2.0
| ~~library/python-3/zc.lockfile-39~~ | 2.0 | _Removed_
| library/readline | 8.1.1 | 8.1.2
| network/dns/bind | 9.16.21 | 9.16.27
| network/openssh | 8.8.1 | 8.9.1
| network/openssh-server | 8.8.1 | 8.9.1
| network/service/isc-dhcp | 4.4.2.1 | 4.4.3
| network/socat | 1.7.4.1 | 1.7.4.3
| **runtime/java/jexec** | _New_ | 0.5.11
| runtime/perl | 5.34.0 | 5.34.1
| **runtime/python-310** | _New_ | 3.10.4
| ~~runtime/python-39~~ | 3.9.12 | _Removed_
| security/sudo | 1.9.8.2 | 1.9.10
| service/network/chrony | 4.1 | 4.2
| shell/bash | 5.1.8 | 5.1.16
| shell/tcsh | 6.22.4 | 6.24.0
| shell/zsh | 5.8 | 5.8.1
| system/bhyve/firmware | 20210302 | 20220329
| system/data/hardware-registry | 2021.9.23 | 2021.12.23
| system/data/urxvt-terminfo | 9.26 | 9.30
| system/data/zoneinfo | 2021.5 | 2022.1
| ~~system/kernel/dtrace/providers/xdt~~ | 0.5.11 | _Removed_
| system/library/dbus | 1.12.20 | 1.14.0
| system/library/libdbus | 1.12.20 | 1.14.0
| system/library/mozilla-nss | 3.70 | 3.76.1
| system/library/mozilla-nss/header-nss | 3.70 | 3.76.1
| **system/library/python/libbe-310** | _New_ | 0.5.11
| ~~system/library/python/libbe-39~~ | 0.5.11 | _Removed_
| **system/library/python/solaris-310** | _New_ | 0.5.11
| ~~system/library/python/solaris-39~~ | 0.5.11 | _Removed_
| **system/library/python/zfs-310** | _New_ | 0.5.11
| ~~system/library/python/zfs-39~~ | 0.5.11 | _Removed_
| system/management/cloud-init | 21.3 | 22.1
| system/pciutils/pci.ids | 2.2.20210923 | 2.2.20211215
| system/rsyslog | 8.2108.0 | 8.2202.0
| system/test/fio | 3.28 | 3.29
| system/virtualization/open-vm-tools | 11.3.0 | 12.0.0
| terminal/screen | 4.8.0 | 4.9.0
| text/gawk | 5.1.0 | 5.1.1
| web/curl | 7.79.1 | 7.83.0
| web/wget | 1.21.2 | 1.21.3
| **web/wget2** | _New_ | 2.0.0
