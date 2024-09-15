<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOS v11 r151048

## r151048as (2024-09-15)
Weekly release for w/c 9th of September 2024.
> This is a non-reboot update

### Security Fixes

* Python updated to version 3.11.10

* Expat updated to version 2.6.3

<br>

---

## r151048ar (2024-09-06)
Weekly release for w/c 2nd of September 2024.
> This is a non-reboot update

### Security Fixes

* OpenSSL updated to version 3.1.7.

* Git updated to version 2.42.3

<br>

---

## r151048am (2024-08-01)
Weekly release for w/c 29th of July 2024.
> This is a non-reboot update

### Security Fixes

* Curl updated to version 8.9.1.

* OpenJDK packages updated to versions 1.8.422-05, 11.0.24+8 and 17.0.12+7.

<br>

---

## r151048al (2024-07-22)
Weekly release for w/c 22nd of July 2024.
> This update requires a reboot

### Security Fixes

* AMD CPU Microcode updated to version 20240710.

### Other Changes

* The compatibility copy of the PCI IDs file in `/usr/share/pci.ids.gz`
  delivered by `pkg://system/pciutils/pci.ids` was mistakenly empty. This file
  has been removed and the same package now provides a symbolic link from
  `/usr/share/pci.ids` to `/usr/share/hwdata/pci.ids` to support software
  which incorrectly assumes the wrong location.

<br>

---

## r151048ai (2024-07-01)
Weekly release for w/c 1st of July 2024.
> This is a non-reboot update

### Security Fixes

- The `openssh` and `openssh-server` packages have been updated to mitigate
  the
  [regreSSHion security vulnerability](https://blog.qualys.com/vulnerabilities-threat-research/2024/07/01/regresshion-remote-unauthenticated-code-execution-vulnerability-in-openssh-server).

<br>

---

## r151048ah (2024-06-28)
Weekly release for w/c 24th of June 2024.
> This update requires a reboot

### Other Changes

* The `ena` driver has been updated fixing a panic under heavy traffic.

* `rsync` is now built with IPv6 support.

<br>

---

## r151048ae (2024-06-07)
Weekly release for w/c 3rd of June 2024.
> This is a non-reboot update

### Security Fixes

* OpenSSL packages have been updated to versions 3.1.6 and 1.1.1w-2.

* OpenJDK packages have been updated to versions 1.8.412-08, 11.0.23+9 and
  17.0.11+9.

<br>

---

## r151048ad (2024-05-31)
Weekly release for w/c 27th of May 2024.
> This update requires a reboot

### Security Fixes

* `ncurses` has been updated to version 6.4.20240309.

* `tmux` has been updated to version 3.3a, and patched to resolve
  [CVE-2022-47016](https://www.cve.org/CVERecord?id=CVE-2022-47016).

### Other Changes

* The algorithm for picking a hot spare to use in a ZFS pool has been updated
  so that spares are first sorted in ascending size order. This means that
  the smallest appropriate usable spare will be selected.

* Added support for Open File Descriptor (OFD) locks to the `lx` zone brand
  in order to support systemd v254 and newer.

* The bhyve emulated USB tablet device which is used for mouse support under
  VNC has been fixed so that it works properly with Linux guests running
  newer kernel versions.

* If given a very large input (2^29 bytes or more), the illumos crypto
  code could previously produce incorrect SHA1 hashes. This has been resolved
  in this update.

<br>

---

## r151048w (2024-04-11)
Weekly release for w/c 8th of April 2024.
> This update requires a reboot

### Security Fixes

* For Intel CPUs that are vulnerable to
  [Native Branch History Injection](https://www.vusec.net/projects/native-bhi/),
  the kernel now takes steps to scrub the CPU's Branch History Buffer (BHB)
  on certain context switches.

* `curl` has been updated to version 8.7.1, addressing:
  [CVE-2024-2466](https://curl.se/docs/CVE-2024-2466.html),
  [CVE-2024-2398](https://curl.se/docs/CVE-2024-2398.html),
  [CVE-2024-2379](https://curl.se/docs/CVE-2024-2379.html) and
  [CVE-2024-2004](https://curl.se/docs/CVE-2024-2004.html).

* Python has been updated to 3.11.9

### Other Changes

* A panic in ZFS in conjunction with SMB2 has been fixed.

* A bug in `readline` that could cause crashes with unknown locales has been
  resolved.

* The system PCI and USB hardware databases have been updated.

* For Intel CPUs which are not vulnerable to
  [Post-barrier Return Stack Buffer (PBRSB)](https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/post-barrier-return-stack-buffer-predictions.html)
  the kernel no longer spends time mitigating this.

<br>

---

## r151048t (2024-03-22)
Weekly release for w/c 18th of March 2024.
> This update requires a reboot

### Security Fixes

* AMD CPU microcode has been updated to 20240116.

* Intel CPU microcode has been updated to 20240312.

* Introduced a workaround for the recently published Intel Register File Data
  Sampling [RFDS] vulnerability in some Intel Atom CPUs -
  [INTEL-SA-00898](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00898.html)

### Other Changes

* Fix for a kernel panic in the SMB server caused by a race between cancel and
  completion functions -
  [illumos 15985](https://www.illumos.org/issues/15985).

* SHA-2 calculations that use libmd and a very large block size could
  produce incorrect hashes.

* A POSIX normal lock would not properly deadlock on re-entry in a
  single-threaded application -
  [illumos 16200](https://www.illumos.org/issues/16200).

* Clock calibration in KVM environments now retrieves the clock frequency
  directly via an MSR. This fixes the calculation in environments such as AWS.
  This calibration method was previously only tried in VMWare guests.

* Added support for e1000g I219 V17 and LM+V24-27,29 network cards.

* The `ena` network driver has received a number of fixes that make it more
  stable on multi-processor instance types, and support for device reset has
  been added.

<br>

---

## r151048o (2024-02-15)
Weekly release for w/c 12th of February 2024.
> This update requires a reboot

### Security Fixes

* `curl` updated to version 8.6.0 fixing
  [CVE-2024-0853](https://curl.se/docs/CVE-2024-0853.html).

* `libxml2` updated to version 2.11.7, fixing
  [CVE-2024-25062](https://www.cve.org/CVERecord?id=CVE-2024-25062).

### Other Changes

* The `ena` network driver has received a number of fixes that make it more
  stable in recent AWS EC2 instance types.

* Some improvements to PCI enumeration under BIOS boot as AWS EC2 guest have
  been integrated.

* Timezone data has been updated to version 2024a.

<br>

---

## r151048m (2024-02-02)
Weekly release for w/c 29th of January 2024.
> This is a non-reboot update

### Security Fixes

* `openssl` has been updated to version 3.1.5. Security fixes have been
  back-ported to the legacy 1.1 and 1.0 openssl packages.

* `unzip` has been updated with a number of security fixes.

* OpenJDK packages have been updated to 1.8.402-06, 11.0.22+7 and 17.0.10+7.

### Other Changes

* `unzip` now supports newer compression versions by virtue of being linked
  to libbz2.

* The virtio-scsi driver is now included in installation media and images to
  support installation in virtual environments with virtio-scsi boot disks.

* The `zlib` package has been updated to version 1.3.1.

<br>

---

## r151048i (2024-01-08)
Weekly release for w/c 1st of January 2024.
> This update requires a reboot

### Security Fixes

* AMD CPU microcode has been updated to 20231205.

* OpenSSH has been updated to version 9.6p1, containing mitigations for
  [CVE-2023-48795](https://www.cve.org/CVERecord?id=CVE-2023-48795),
  [CVE-2023-46445](https://www.cve.org/CVERecord?id=CVE-2023-46445),
  [CVE-2023-46446](https://www.cve.org/CVERecord?id=CVE-2023-46446),
  collectively known as the [Terrapin attack](https://terrapin-attack.com).

### Other Changes

* A problem that could result in
  [TCP data being lost](https://www.illumos.org/issues/16060)
  during connection shutdown has been resolved.

* Timezone data has been updated to 2023d.

* A problem that could result in the unnecessary recompilation of python
  objects has been addressed. Updated `python-311` and `cloud-init` packages
  have been published.

<br>

---

## r151048f (2023-12-11)
Weekly release for w/c 11th of December 2023.
> This update requires a reboot

### Security Fixes

* `curl` has been updated to version 8.5.0.

* The OpenJDK packages have been upgraded to versions 1.8.392-08, 11.0.21+9
  and 17.0.9+9.

* `perl` has been upgraded to version 5.63.3.

### Other Changes

* A race condition in ZFS could cause a very recently written file to appear to
  contain holes if inspected with `lseek(SEEK_DATA)`. This is very hard to hit
  in practice, although the GNU `cp` command can trigger it and produce empty
  target files. The native illumos/OmniOS `cp` does not use lseek in this way
  and is unaffected.

<br>

---

## r151048b (2023-11-15)
Weekly release for w/c 13th of November 2023.
> This update requires a reboot

### Security Fixes

* Intel CPU microcode updated to 20231114, including a security update for
  [INTEL-SA-00950](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00950.html).

* AMD CPU microcode updated to 20231019.

### Other Changes

* The UUID of a bhyve VM was changing on every zone restart. For VMs using
  cloud-init, this caused them to be considered as a new host on each cold
  boot.

<br>

---

Stable Release, 6th of Nov 2023

`uname -a` shows `omnios-r151048-24333ee74c`

r151048 release repository: https://pkg.omnios.org/r151048/core

## Upgrade Notes

Upgrades are supported from the r151046 release only. If upgrading from an
earlier version, upgrade in stages, referring to the table at
<https://omnios.org/upgrade>.

## New features since r151046

### System Features

* OmniOS userland is now built with gcc version 13.

* A number of improvements to datalink management have been integrated from
  upstream illumos. Known problems that could cause zones to get stuck
  while shutting down have been resolved.

* A number of issues with managing interface state around IPv6 address have
  been resolved in this release.

* Support for Zen 4 CPU performance counters has been added.

* Use automatic IBRS on AMD Zen 4 platforms. This improves performance
  and reduces the overhead of virtual machine context switching.

* A number of improvements to the in-kernel CIFS/SMB support have been imported
  from upstream illumos.

* The lofi(4D) driver now supports DISCARD/TRIM.

* Support for SMBIOS 3.7 has been added.

### Commands and Command Options

* The `which` command has been replaced with an implementation written in C
  rather than in csh. The new version bases its decision on what the current
  user can execute on assigned privilege and not just file mode bits, so
  the output may be different in some cases. The new version does also not
  show csh alias expansions when invoked from csh, but note that tcsh is not
  affected by this as it has a built-in `which` command.

* There is a new datalink property, `media`, which shows the media that is in
  use, as reported by the underlying driver. This new property is also present
  in the topology tree.

* The `ld` command parameter parsing has been tightened up, meaning that
  invalid combinations of options are now rejected as they should be.

* While it has always been supported, `make -w` is now documented in
  [make(1)](https://man.omnios.org/man1/make).

* The [svccfg(8)](https://man.omnios.org/svccfg) has gained a `-z` option,
  allowing it to operate on services within a non-global zone.

* `ping` would fail if given an interval of 0.01 seconds.

* `prtconf -dp` now works as the man page would suggest. Previously `-d` was
  ignored in the presence of `-p`.

* `printmgr` has been removed. It has not been functional with modern java
  for a long time.

* [snoop(8)](https://man.omnios.org/snoop) can now capture into rotating
  output files via the new `-O` option.

* [ucodeadm(8)](https://man.omnios.org/ucodeadm) has gained a `-t` option
  to specify the type of the microcode file being processed, rather than
  relying on the file name.

* `dtrace` performance has been improved when setting up or tearing down many
  probes on systems with a high cpu count.

* `truss` could fail to properly trace processes after switching data
  model.

### Libraries and Library Functions

* The uuid library is now shipped with a pkg-config file to make using this
  easier from external software.

* libuuid could previously produce invalid V4 UUIDs.

* Name resolution for a DNS name which resolved only to multiple AAAA records
  would previously fail.

* The [getaddrinfo(3socket)](https://man.omnios.org/man3socket/getaddrinfo)
  function now supports being called with a socket type of ANY and with
  `AI_NUMERICSERV` present in the flags.

* A possible double free in `getallifaddrs()` has been fixed.

* [strtonumx(3C)](https://man.omnios.org/strtonumx) has been added as a
  companion to the existing `strtonum(3C)` function.

### Zones

* A new experimental `emu` zone brand for running emulated systems (under qemu)
  is available. There is an example walk-through of using this to boot
  the experimental OmniOS aarch64/arm64 distribution in an emu-branded zone
  at https://omnios.org/setup/zadm

### LX Zones

* Booting a busybox distribution in an LX zone could previously corrupt the
  `/etc/init.d/networking` file in the zone.

* The `AT_SECURE` auxval is now always set for the root user. This improves
  compatibility with some applications.

* The `IPV6_RECVERR` socket option is now accepted by setsockopt(). It is
  implemented as a no-op, in the same way as `IP_RECVERR`, but it no longer
  generates an error which sates some applications.

### Bhyve

* Guest page table population is now significantly faster, which improves
  guest boot times.

* The `viona` virtual network driver now copies transmission buffers by default
  when handing them off. This improves situations when it was possible to
  starve the system of buffers on high bandwidth connections.

* A number of improvements have been made to the real-time clock within
  bhyve.

### Package Management

* [pkg list](https://man.omnios.org/man1/pkg) has gained `-o` and `-F` options
  to control which columns are included in the output, and the format of
  that output.

* [pkg list -i](https://man.omnios.org/man1/pkg) shows installable packages.
  These are packages which are available in the catalogue but are not installed
  on the current system image.

* When packaging software, the `pkgdepend resolve` step would previously
  consume excessive memory.

### Hardware Support

* NVMe 2.x devices are now supported, although currently only with NVMe 1.x
  features.

* ATA PASS-THROUGH(16) is now supported. This enables the use of
  `smartctl` command on SATA disks without having to force the pass-through
  mode via `-d sat,12`.

* Kernel support for newer AMD CPU revisions and socket types has been
  introduced.

* The bundled firmware for cxgbe network cards has been updated to version
  1.27.4.0.

* The cxgbe driver now produces kstats for FEC events.

### Developer Features

* Version 13 of the `gcc` compiler has been added.

* The performance of the warning check phase of `nightly` has been
  significantly improved.

* The `header-nspr`, `header-nss` and `header-idnkit` packages have been merged
  into `library/nspr`, `library/nss` and `library/idnkit` respectively.

### Deprecated features

* The `grub` boot loader is deprecated and will be removed in a future
  release. It will be supported in r151046 for the full LTS time frame, up to
  May 2026. If you have not yet migrated to the new boot loader, and would like
  assistance, please
  [get in touch](https://omnios.org/about/contact).

* Version 11 of the `gcc` compiler has been removed. Existing installed packages
  will be retained but no longer receive updates.

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
| archiver/gnu-tar | 1.34 | 1.35
| compress/brotli | 1.0.9 | 1.1.0
| compress/gzip | 1.12 | 1.13
| compress/xz | 5.4.2 | 5.4.4
| data/iso-codes | 4.13.0 | 4.15.0
| database/sqlite-3 | 3.41.2 | 3.43.1
| developer/gcc10 | 10.4.0 | 10.5.0
| ~~developer/gcc11~~ | 11.3.0 | _Removed_
| developer/gcc12 | 12.2.0 | 12.3.0
| **developer/gcc13** | _New_ | 13.2.0
| developer/gnu-binutils | 2.40 | 2.41
| developer/versioning/git | 2.40.1 | 2.42.0
| developer/versioning/mercurial | 6.3.3 | 6.5.2
| file/gnu-coreutils | 9.3 | 9.4
| library/glib2 | 2.74.6 | 2.78.0
| library/gmp | 6.2.1 | 6.3.0
| ~~library/idnkit/header-idnkit~~ | 2.3 | _Removed_
| library/libxml2 | 2.10.4 | 2.11.5
| library/mpfr | 4.2.0 | 4.2.1
| library/nghttp2 | 1.52.0 | 1.56.0
| ~~library/nspr/header-nspr~~ | 4.35 | _Removed_
| library/python-3/attrs-311 | 22.2.0 | 23.1.0
| library/python-3/coverage-311 | 7.2.2 | 7.3.0
| library/python-3/cryptography-311 | 39.0.2 | 41.0.3
| library/python-3/meson-311 | 1.0.1 | 1.2.1
| library/python-3/orjson-311 | 3.8.8 | 3.9.5
| library/python-3/pip-311 | 23.0.1 | 23.2.1
| library/python-3/pycodestyle-311 | 2.10.0 | 2.11.0
| library/python-3/pyopenssl-311 | 23.0.0 | 23.2.0
| library/python-3/pyyaml-311 | 6.0 | 6.0.1
| library/python-3/rapidjson-311 | 1.10 | 1.11
| library/python-3/setuptools-311 | 67.6.0 | 68.1.2
| library/python-3/setuptools-rust-311 | 1.5.2 | 1.7.0
| library/python-3/typing-extensions-311 | 4.5.0 | 4.7.1
| library/security/openssl-11 | 1.1.1.22 | 1.1.1.23
| library/security/openssl-3 | 3.0.12 | 3.1.4
| library/unixodbc | 2.3.11 | 2.3.12
| library/zlib | 1.2.13 | 1.3
| media/xorriso | 1.5.4.2 | 1.5.6.2
| network/dns/bind | 9.18.14 | 9.18.19
| network/openssh | 9.3.2 | 9.4.1
| network/openssh-server | 9.3.2 | 9.4.1
| security/sudo | 1.9.13.3 | 1.9.14.3
| service/network/chrony | 4.3 | 4.4
| shell/pipe-viewer | 1.6.20 | 1.8.0
| shell/tcsh | 6.24.7 | 6.24.10
| system/data/hardware-registry | 2023.2.23 | 2023.8.24
| system/library/dbus | 1.14.6 | 1.14.10
| system/library/g++-runtime | 12 | 13
| system/library/gcc-runtime | 12 | 13
| system/library/gfortran-runtime | 12 | 13
| system/library/gobjc-runtime | 12 | 13
| system/library/libdbus | 1.14.6 | 1.14.10
| system/library/mozilla-nss | 3.89 | 3.93
| ~~system/library/mozilla-nss/header-nss~~ | 3.89 | _Removed_
| system/library/pcap | 1.10.3 | 1.10.4
| system/management/cloud-init | 23.1.1 | 23.1.2
| system/management/snmp/net-snmp | 5.9.3 | 5.9.4
| system/pciutils | 3.9.0 | 3.10.0
| system/pciutils/pci.ids | 2.2.20230223 | 2.2.20230812
| system/rsyslog | 8.2302.0 | 8.2308.0
| system/test/fio | 3.34 | 3.35
| system/virtualization/open-vm-tools | 12.2.0 | 12.3.0
| **system/zones/brand/emu** | _New_ | 0.5.11
| text/gawk | 5.2.1 | 5.2.2
| text/gnu-diffutils | 3.9 | 3.10
| text/gnu-gettext | 0.21.1 | 0.22.2
| text/gnu-grep | 3.10 | 3.11
| text/groff | 1.22.4 | 1.23.0
| text/less | 608 | 643
| web/wget | 1.21.3 | 1.21.4
| web/wget2 | 2.0.1 | 2.1.0
