<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151046

## r151046bt (2024-09-15)
Weekly release for w/c 9th of September 2024.
> This is a non-reboot update

### Security Fixes

* Python updated to version 3.11.10

* Expat updated to version 2.6.3

<br>

---

## r151046bs (2024-09-06)
Weekly release for w/c 2nd of September 2024.
> This is a non-reboot update

### Security Fixes

* OpenSSL updated to version 3.0.15.

* Git updated to version 2.40.3

### Other Changes

* The `bhyve` branded zone can now handle up to 16 VNICs.

<br>

---

## r151046bn (2024-08-01)
Weekly release for w/c 29th of July 2024.
> This is a non-reboot update

### Security Fixes

* Curl updated to version 8.9.1.

* OpenJDK packages updated to versions 1.8.422-05, 11.0.24+8 and 17.0.12+7.

<br>

---

## r151046bm (2024-07-22)
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

## r151046bj (2024-07-01)
Weekly release for w/c 1st of July 2024.
> This is a non-reboot update

### Security Fixes

- The `openssh` and `openssh-server` packages have been updated to mitigate
  the
  [regreSSHion security vulnerability](https://blog.qualys.com/vulnerabilities-threat-research/2024/07/01/regresshion-remote-unauthenticated-code-execution-vulnerability-in-openssh-server).

<br>

---

## r151046bi (2024-06-28)
Weekly release for w/c 24th of June 2024.
> This update requires a reboot

### Other Changes

* The `ena` driver has been updated fixing a panic under heavy traffic.

* `rsync` is now built with IPv6 support.

<br>

---

## r151046bf (2024-06-07)
Weekly release for w/c 3rd of June 2024.
> This update requires a reboot

### Security Fixes

* OpenSSL packages have been updated to versions 3.0.14 and 1.1.1w-2.

* OpenJDK packages have been updated to versions 1.8.412-08, 11.0.23+9 and
  17.0.11+9.

### Other Changes

* Support for 38xx HBAs has been added to the `mpt_sas` driver.

<br>

---

## r151046be (2024-05-31)
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

## r151046ax (2024-04-11)
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

* A bug in `readline` that could cause crashes with unknown locales has been
  resolved.

* The system PCI and USB hardware databases have been updated.

* For Intel CPUs which are not vulnerable to
  [Post-barrier Return Stack Buffer (PBRSB)](https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/post-barrier-return-stack-buffer-predictions.html)
  the kernel no longer spends time mitigating this.

<br>

---

## r151046au (2024-03-22)
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

## r151046ap (2024-02-15)
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

## r151046an (2024-02-01)
Weekly release for w/c 29th of January 2024.
> This is a non-reboot update

### Security Fixes

* `openssl` has been updated to version 3.0.13. Security fixes have been
  back-ported to the legacy 1.1 and 1.0 openssl packages.

* `unzip` has been updated with a number of security fixes.

* OpenJDK packages have been updated to 1.8.402-06, 11.0.22+7 and 17.0.10+7.

### Other Changes

* `unzip` now supports newer compression versions by virtue of being linked
  to libbz2.

* The virtio-scsi driver is now included in installation media and images to
  support installation in virtual environments with virtio-scsi boot disks.

<br>

---

## r151046aj (2024-01-08)
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

## r151046ag (2023-12-10)
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

## r151046ac (2023-11-15)
Weekly release for w/c 13th of November 2023.
> This update requires a reboot

### Security Fixes

* Intel CPU microcode updated to 20231114, including a security update for
  [INTEL-SA-00950](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00950.html).

* AMD CPU microcode updated to 20231019.

### Other Changes

* The `pgrep` utility could print out the wrong process name and arguments when
  the `-o` or `-n` option was used in conjunction with `-f` or `-v`.

<br>

---

## r151046z (2023-10-26)
Weekly release for w/c 23rd of October 2023.
> This is a non-reboot update

### Security Fixes

- `openssl` updated to version 3.0.12, fixing
  [CVE-2023-5363](https://www.openssl.org/news/secadv/20231024.txt)

<br>

---

## r151046x (2023-10-11)
Weekly release for w/c 09th of October 2023.
> This is a non-reboot update

### Security Fixes

* `curl` updated to version 8.4.0, fixing
  [CVE-2023-38545](https://curl.se/docs/CVE-2023-38545.html),
  [CVE-2023-38546](https://curl.se/docs/CVE-2023-38546.html).

### Other Changes

* [pkgdepend(1)](https://man.omnios.org/pkgdepend) used an excessive amount of
  memory when performing the resolution step.

<br>

---

## r151046u (2023-09-20)
Weekly release for w/c 18th of September 2023.
> This is a non-reboot update

### Security Fixes

* Curl has been updated to version 8.3.0

* OpenJDK has has been updated to 11.0.20.1+1 and 17.0.8.1+1

* Python has been updated to version 3.11.5

* OpenSSL has been updated to version 3.0.11

<br>

---

## r151046q (2023-08-24)
Weekly release for w/c 21st of August 2023.
> This update requires a reboot

### Security Fixes

- bhyve: fully reset the fwctl state if the guest requests it
  [CVE-2023-3494](https://www.cve.org/CVERecord?id=CVE-2023-3494).

- Update Intel CPU microcode to 20230808. Contains mitigations for
  [CVE-2022-40982](https://www.cve.org/CVERecord?id=CVE-2022-40982),
  [CVE-2022-41804](https://www.cve.org/CVERecord?id=CVE-2022-41804),
  [CVE-2023-23908](https://www.cve.org/CVERecord?id=CVE-2023-23908).

- Update AMD CPU microcode to 20230808. Contains mitigations for
  [CVE-2023-20569](https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7005.html).

- `screen` has been updated to version 4.9.1 which includes a fix for
  [CVE-2023-24626](https://www.cve.org/CVERecord?id=CVE-2023-24626). Note that
  this exploit required that `screen` be installed set-uid, which it is not be
  default on OmniOS.

### Other Changes

- bhyve: take more care around `VM_MAXCPU`. A priviliged user could trigger a
  kernel panic.

- LX: always set the `AT_SECURE` auxval to better emulate Linux and fix
  problems with recent `dconf` [OS-8480](https://smartos.org/bugview/OS-8480).

- The version of the nettle cryptography library bundled with chrony has been
  updated.

<br>

---

## r151046n (2023-08-03)
Weekly release for w/c 31st of July 2023.
> This is a non-reboot update

### Security Fixes

- OpenSSL packages updated to versions 3.0.10 / 1.1.1v / 1.0.2u-1, resolving
  [CVE-2023-3817](https://www.openssl.org/news/secadv/20230731.txt),
  [CVE-2023-3446](https://www.openssl.org/news/secadv/20230719.txt),
  [CVE-2023-2975](https://www.openssl.org/news/secadv/20230714.txt).

- OpenJDK 8 has been updated to version 1.8.0u382-b05.

<br>

---

## r151046m (2023-07-25)
Weekly release for w/c 24th of July 2023.
> This update requires a reboot

### Changes

* AMD CPU microcode updated to 20230719, mitigating
  [CVE-2023-20593](https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7008.html)
  on some Zen2 processors.

* Intel CPU microcode updated to 20230512, refer to Intel's
  [release notes](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases)
  for details.

<br>

---

## r151046l (2023-07-20)
Weekly release for w/c 17th of July 2023.
> This update requires a reboot

### Security Fixes

* OpenSSH updated to version 9.3p2, fixing
  [CVE-2023-38408](https://blog.qualys.com/vulnerabilities-threat-research/2023/07/19/cve-2023-38408-remote-code-execution-in-opensshs-forwarded-ssh-agent).

* The prgetsecflags() interface leaked a small (4 byte) portion of kernel stack
  memory - [illumos 15788](https://www.illumos.org/issues/15788).

* OpenJDK packages have been updated to 11.0.20+8 and 17.0.8+7.

### Other Changes

* Various improvements to the SMB idmap service have been backported:
  * [illumos 14306](https://www.illumos.org/issues/14306)
  * [illumos 15556](https://www.illumos.org/issues/15556)
  * [illumos 15564](https://www.illumos.org/issues/15564)
  Most notably, it was previously possible to get flurries of log messages
  of the form `Can't get SID for ID=0 type=0` and this is now resolved.

* The UUID generation library could produce invalid V4 UUIDs.

* An issue with python header files that could cause some third party software
  to fail compilation has been resolved.

<br>

---

## r151046h (2023-06-20)
Weekly release for w/c 19th of June 2023.
> This update requires a reboot

### Security Fixes

* Python has been updated to version 3.11.4;

* Vim has been updated to version 9.0.1443.

### Other Changes

* SMB NetLogon Client Seal support;

* Windows clients could get disconnected when copying files to an SMB share;

* %ymm registers were not correctly restored after signal handler;

* The `svccfg` command now supports a `-z` flag to manage services within
  zones;

* The startup timeout for the `system/zones` service has been increased to
  resolve problems when starting a large number of bhyve zones in parallel in
  conjunction with a memory reservoir configuration;

* Use automatic IBRS when available;

* `blkdev` and `lofi` did not properly initialise cmlb minor nodes;

* The ping command would fail when invoked with `-I 0.01`;

* In exceptional circumstances, a zone could become stuck during halt due to
  lingering IP references;

* An issue with resolving DNS names which have only multiple AAAA records
  has been resolved;

* Improvements within the `nvme` driver to resolve a race and allow it to bind
  to devices that are under a legacy PCI root;

* In exception circumstances, the system could panic when dumping a userland
  process core.

<br>

---

## r151046e (2023-05-31)
Weekly release for w/c 29th of May 2023.
> This is a non-reboot update

### Security Fixes

* Curl has been updated to version 8.1.2, fixing
  [CVE-2023-28319](https://curl.se/docs/CVE-2023-28319.html),
  [CVE-2023-28320](https://curl.se/docs/CVE-2023-28320.html),
  [CVE-2023-28321](https://curl.se/docs/CVE-2023-28321.html),
  [CVE-2023-28322](https://curl.se/docs/CVE-2023-28322.html).

* OpenSSL has been updated to versions 1.1.1u and 3.0.9, fixing
  [CVE-2023-2650](https://www.openssl.org/news/secadv/20230530.txt).
  OpenSSL 1.0.2 has also been patched against this.

### Other Changes

<br>

---

Stable and Long-Term-Supported (LTS) Release, 1st of May 2023

`uname -a` shows `omnios-r151046-82ebda23c9`

r151046 release repository: https://pkg.omnios.org/r151046/core

## Upgrade Notes

Upgrades are supported from the r151038, r151040, r151042 and r151044 releases
only. If upgrading from an earlier version, upgrade in stages, referring to the
table at <https://omnios.org/upgrade>.

## New features since r151044

### System Features

* Python has been upgraded to version 3.11, replacing version 3.10 used in the
  previous release.

* NVMe devices are now identified using their namespace GUID, if supported.
  This may result in the device ID of any NVMe drives changing on the first
  boot into this release, with accompanying messages on the console.

* Joining a windows domain via `smbadm join` now automatically updates
  the local administrators group to include domain administrators. If
  necessary, `smbadm remove-member` can be used to adjust membership.

* SMB now supports 256-bit ciphers.

* SMB now has a new configuration option to enable support for short names.
  Only very old applications on old clients need short names, however it is
  necessary to support running the Windows Protocol Test Suites.

* The [omnios-build](https://github.com/omniosorg/omnios-build) framework has
  seen extensive changes as a result of introducing support for building
  packages for different architectures. Many packages can now be built for
  64-bit ARM by passing `-a aarch64` to the build script, and a regularly
  updated testing image is maintained at
  <https://downloads.omnios.org/media/braich/>.

### Commands and Command Options

* The `which` command has been replaced. The new version fixes a number of
  issues with the old but will no-longer show aliases when invoked from the
  csh.

* `csh` itself is now mediated and will automatically be replaced by `tcsh`
  if that package is installed. To switch /usr/bin/csh back to the illumos
  version, invoke:
  ```
  pfexec pkg set-mediator -I illumos csh
  ```

* `nvmeadm` has been updated to show and refer to namespaces by their
  namespace IDs, rather than an index. There have also been changes in the
  `list` sub-command to better support namespaces.

* `smbadm` has been enhanced with the ability to read credentials from stdin.

* The `ls` command can now show SIDs instead of ephemeral IDs. Refer to
  [ls(1)](https://man.omnios.org/ls), in particular the section that discusses
  the `-n` option.

* `pcieadm` has been updated so that its help messages include the list of
  available fields.

* `find`'s -useracl and -groupacl options could produce false positive matches
  due to ignoring an ACL entry's type.

* The `cxgbetool` command now accepts instance names rather than device paths,
  making it easier to use.

* The `media/cdrtools` package has been replaced by `media/xorriso` which
  provides compatible `cdrecord` and `mkisofs` utilities.

### Libraries and Library Functions

* The `isatty()` function has been updated so that it always sets `errno`
  when returning 0. Although both behaviours are compliant with the POSIX
  standard, some third party software incorrectly expects errno to be set.

* When retrieving a list of interface addresses via the `SIOCGLIFCONF` ioctl,
  the `sin6_scope_id` field is now filled in.

* libpcre2 now includes 16 and 32-bit character support.

### Zones

* There have been several improvements to zone networking so that links
  created directly within a zone are now properly cleaned up. In general,
  cleaning up links on zone halt is much improved.

### Bhyve

* The `virtio-viona` network driver now supports a control queue and
  promiscuous mode.

* A new `kstat` has been added to show details of the vmm reservoir.

* The virtio 9p buffers have been expanded to improve performance.

* bhyve supports more customisation of `smbios` data via the `-B` option
  and via configuration file directives.

* The emulated `nvme` driver has been updated as a result of additional
  compliance testing.

### ZFS

* The ZFS `autoexpand` property now works for root pools.

* It is now possible to directly import a root pool from a `/devices` path.

* `zpool list` no longer truncates long device names to 64 characters.

* `zfs allow` could display incorrect information for filesystems which had
  `allow -c` set but not `allow -s`.

### Package Management

* The `snoop` command has been split into its own package.

### Drivers

* The bundled firmware in the `cxgbe` driver has been updated to version
  1.27.1.0.

### Developer Features

* `ctfdump` now additionally displays bitfield member offsets in bytes and
  fractions of bytes.

* `errc`, `verrc`, `warnc` and `vwarnc` functions have been added to libc.

* `ld` now fills out more of the `PT_DYNAMIC` section which resolves
  inter-operability problems with recently released `binutils`.

* [intro(9F)](https://man.omnios.org/intro.9f) has been rewritten and
  extended to better introduce kernel programming topics.

* The `gcc12` compiler has a new `-fforce-omit-frame-pointer` that can be used
  for building things that absolutely require the frame pointer to be omitted.
  This hinders the debugability of the generated artefacts with tools such as
  `mdb` and `dtrace`.

* `gcc` has been updated to allow the `%h` and `%hh` length modifiers in
  kernel code.

### Deprecated features

* The `grub` boot loader is deprecated and is scheduled for removal in
  the r151048 release. It will be supported in r151046 for the full LTS time
  frame, up to May 2026. If you have not yet migrated to the new boot loader,
  and would like assistance, please
  [get in touch](https://omnios.org/about/contact).

* The Service Location Protocol (SLP) service that was provided by the
  `service/network/slp` package is no longer shipped with OmniOS. SLP is a
  legacy protocol that has a number of known security problems, such as
  [CVE-2023-29552](https://nvd.nist.gov/vuln/detail/CVE-2023-29552).

* OpenSSH in OmniOS no longer provides support for GSSAPI key exchange.
  This was removed in release r151038.

* Python 2 is now end-of-life and will not receive any further updates. The
  `python-27` package is still available for backwards compatibility but will
  be maintained only on a best-efforts basis.

* OpenSSL 1.0.x is deprecated and reached end-of-support at the end of 2019.
  OpenSSL 1.1.1 will reach end-of-support in September 2023.
  OmniOS has transitioned to OpenSSL 3 and still ships OpenSSL 1.1.1 for
  compatibility. The OpenSSL 1.0.2 libraries are also retained for
  backwards compatibility but are maintained solely on a best-efforts basis.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| compress/xz | 5.2.6 | 5.4.2
| data/iso-codes | 4.11.0 | 4.13.0
| database/sqlite-3 | 3.39.4 | 3.41.2
| developer/build/gnu-make | 4.3 | 4.4.1
| developer/gnu-binutils | 2.39 | 2.40
| developer/nasm | 2.15.5 | 2.16.1
| developer/swig | 4.0.2 | 4.1.1
| developer/versioning/git | 2.37.7 | 2.40.1
| developer/versioning/mercurial | 6.2.2 | 6.3.3
| file/gnu-coreutils | 9.1 | 9.3
| library/c++/sigcpp | 3.2.0 | 3.4.0
| library/expat | 2.4.9 | 2.5.0
| library/glib2 | 2.74.0 | 2.74.6
| library/libffi | 3.4.3 | 3.4.4
| library/mpc | 1.2.1 | 1.3.1
| library/mpfr | 4.1.0 | 4.2.0
| library/ncurses | 6.3 | 6.4
| library/nghttp2 | 1.50.0 | 1.52.0
| library/nspr | 4.34.1 | 4.35
| library/nspr/header-nspr | 4.34.1 | 4.35
| library/pcre2 | 10.40 | 10.42
| library/python-3/attrs-311 | 22.1.0 | 22.2.0
| library/python-3/coverage-311 | 6.4.4 | 7.2.2
| **library/python-3/crossenv-311** | _New_ | 1.4.0
| library/python-3/cryptography-311 | 38.0.1 | 39.0.2
| library/python-3/jsonschema-311 | 4.16.0 | 4.17.3
| library/python-3/meson-311 | 0.63.2 | 1.0.1
| library/python-3/orjson-311 | 3.8.0 | 3.8.8
| library/python-3/pip-311 | 22.2.2 | 23.0.1
| library/python-3/pycodestyle-311 | 2.9.1 | 2.10.0
| library/python-3/pyopenssl-311 | 22.0.0 | 23.0.0
| library/python-3/pyrsistent-311 | 0.18.1 | 0.19.3
| library/python-3/rapidjson-311 | 1.8 | 1.10
| library/python-3/setuptools-311 | 65.3.0 | 67.6.0
| library/python-3/typing-extensions-311 | 4.3.0 | 4.5.0
| library/readline | 8.1.2 | 8.2
| ~~media/cdrtools~~ | 3.1 | _Removed_
| **media/xorriso** | _New_ | 1.5.4.2
| network/dns/bind | 9.18.7 | 9.18.14
| network/openssh | 9.0.1 | 9.3.1
| network/openssh-server | 9.0.1 | 9.3.1
| network/rsync | 3.2.6 | 3.2.7
| network/service/isc-dhcp | 4.4.3 | 4.4.3.1
| **network/snoop** | _New_ | 0.5.11
| network/socat | 1.7.4.3 | 1.7.4.4
| ~~runtime/python-310~~ | 3.10.11 | _Removed_
| **runtime/python-311** | _New_ | 3.11.3
| security/sudo | 1.9.12.2 | 1.9.13.3
| service/network/ntpsec | 1.2.1 | 1.2.2
| ~~service/network/slp~~ | 0.5.11 | _Removed_
| shell/bash | 5.1.16 | 5.2.15
| shell/tcsh | 6.24.1 | 6.24.7
| system/bhyve/firmware | 20220329 | 20230201
| system/data/hardware-registry | 2022.9.9 | 2023.2.23
| system/data/urxvt-terminfo | 9.30 | 9.31
| system/library/dbus | 1.14.2 | 1.14.6
| system/library/libdbus | 1.14.2 | 1.14.6
| system/library/mozilla-nss | 3.83 | 3.89
| system/library/mozilla-nss/header-nss | 3.83 | 3.89
| system/library/pcap | 1.10.1 | 1.10.3
| system/management/cloud-init | 22.3 | 23.1.1
| system/pciutils | 3.8.0 | 3.9.0
| system/pciutils/pci.ids | 2.2.20220909 | 2.2.20230223
| system/rsyslog | 8.2208.0 | 8.2302.0
| system/test/fio | 3.32 | 3.34
| system/virtualization/open-vm-tools | 12.1.0 | 12.2.0
| text/gawk | 5.2.0 | 5.2.1
| text/gnu-diffutils | 3.8 | 3.9
| text/gnu-gettext | 0.21 | 0.21.1
| text/gnu-grep | 3.8 | 3.10
| text/gnu-sed | 4.8 | 4.9

