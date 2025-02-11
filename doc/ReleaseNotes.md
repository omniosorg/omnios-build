<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151050

## r151050ao (2025-02-11)
Weekly release for w/c 10th of February 2025.
> This is a non-reboot update

### Security Fixes

* OpenSSL updated to version 3.1.8, addressing:
  [CVE-2024-13176](https://www.openssl.org/news/vulnerabilities.html#CVE-2024-13176),
  [CVE-2024-9143](https://www.openssl.org/news/vulnerabilities.html#CVE-2024-9143).

* Python updated to version 3.12.9.

<br>

---

## r151050an (2025-02-05)
Weekly release for w/c 3rd of February 2025.
> This update requires a reboot

### Security Fixes

* OpenJDK packages updated to versions 1.8.442-06, 11.0.26+4, 17.0.14+17 and
  21.0.6+7.

* Fix for P == Q corner case in ECC; see
  [illumos 17137](https://www.illumos.org/issues/17137).

* Curl updated to 8.12.0, addressing
  [CVE-2025-0167](https://curl.se/docs/CVE-2025-0167.html),
  [CVE-2025-0665](https://curl.se/docs/CVE-2025-0665.html),
  [CVE-2025-0725](https://curl.se/docs/CVE-2025-0725.html).

<br>

---

## r151050al (2025-01-23)
Weekly release for w/c 20th of January 2025.
> This is a non-reboot update

### Other Changes

* Updated `rsync` to 3.4.1 fixing regressions introduced in 3.4.0.

* Updated `perl` to 5.38.3.

<br>

---

## r151050ak (2025-01-14)
Weekly release for w/c 13th of January 2025.
> This is a non-reboot update

### Security Fixes

* git updated to version 2.44.3, fixing
  [CVE-2024-50349](https://www.cve.org/CVERecord?id=CVE-2024-50349),
  [CVE-2024-52006](https://www.cve.org/CVERecord?id=CVE-2024-52006).

* rsync updated to version 3.4.0, fixing
  [CVE-2024-12084](https://www.cve.org/CVERecord?id=CVE-2024-12084),
  [CVE-2024-12085](https://www.cve.org/CVERecord?id=CVE-2024-12085),
  [CVE-2024-12086](https://www.cve.org/CVERecord?id=CVE-2024-12086),
  [CVE-2024-12087](https://www.cve.org/CVERecord?id=CVE-2024-12087),
  [CVE-2024-12088](https://www.cve.org/CVERecord?id=CVE-2024-12088),
  [CVE-2024-12747](https://www.cve.org/CVERecord?id=CVE-2024-12747).

<br>

---

## r151050af (2024-12-11)
Weekly release for w/c 9th of December 2024.
> This update requires a reboot

### Security Fixes

* AMD CPU microcode updated to version 20241121

* Intel CPU microcode updated to version 20241112

* Python updated to 3.12.8

### Other Changes

* Curl updated to version 8.11.1

<br>

---

## r151050ac (2024-11-20)
Weekly release for w/c 18th of November 2024.
> This is a non-reboot update

### Security Fixes

- `curl` updated to version 8.11.0

- `expat` updated to version 2.6.4

- `wget` updated to version 1.25.0

- OpenJDK packages updated to versions 1.8.432-06, 11.0.25+9, 17.0.13+11 and
  21.0.5+11.

<br>

---

## r151050y (2024-10-22)
Weekly release for w/c 21st of October 2024.
> This is a non-reboot update

### Changes

* The `gcc10` compiler has been updated to understand that various illumos
  kernel functions that take format strings can now understand the `%j` and
  `%z` length modifiers.

<br>

---

## r151050v (2024-09-30)
Weekly release for w/c 30th of September 2024.
> This update requires a reboot

### Security Fixes

* Intel CPU microcode has been updated to 20240910.

<br>

---

## r151050s (2024-09-15)
Weekly release for w/c 9th of September 2024.
> This is a non-reboot update

### Security Fixes

* Python updated to version 3.12.6

* Expat updated to version 2.6.3

<br>

---

## r151050r (2024-09-06)
Weekly release for w/c 2nd of September 2024.
> This is a non-reboot update

### Security Fixes

* OpenSSL updated to version 3.1.7.

* Git updated to version 2.44.2

<br>

---

## r151050m (2024-08-01)
Weekly release for w/c 29th of July 2024.
> This is a non-reboot update

### Security Fixes

* Curl updated to version 8.9.1.

* OpenJDK packages updated to versions 1.8.422-05, 11.0.24+8, 17.0.12+7
  and 21.0.4+7.

<br>

---

## r151050l (2024-07-23)
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

## r151050i (2024-07-01)
Weekly release for w/c 1st of July 2024.
> This is a non-reboot update

### Security Fixes

- The `openssh` and `openssh-server` packages have been updated to mitigate
  the
  [regreSSHion security vulnerability](https://blog.qualys.com/vulnerabilities-threat-research/2024/07/01/regresshion-remote-unauthenticated-code-execution-vulnerability-in-openssh-server).

<br>

---

## r151050h (2024-06-28)
Weekly release for w/c 24th of June 2024.
> This update requires a reboot

### Security Fixes

* Python 3.12 has been updated to version 3.12.4

### Other Changes

* The `ena` driver has been updated fixing a panic under heavy traffic.

* `rsync` is now built with IPv6 support.

* The `TCP_INFO` socket option for lx zones has been fixed.

<br>

---

## r151050e (2024-06-07)
Weekly release for w/c 3rd of June 2024.
> This is a non-reboot update

### Security Fixes

* OpenSSL packages have been updated to versions 3.1.6 and 1.1.1w-1.

* OpenJDK packages have been updated to versions 1.8.412-08, 11.0.23+9,
  17.0.11+9 and 21.0.3+9.

### Other Changes

* `xz` has been updated to version 5.6.2, the first release following the
  [backdoor incident](https://tukaani.org/xz-backdoor/).

<br>

---

## r151050d (2024-05-31)
Weekly release for w/c 27th of May 2024.
> This update requires a reboot

### Security Fixes

* `ncurses` has been updated to version 6.4.20240309.

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

Stable Release, 6th of May 2024

`uname -a` shows `omnios-r151050-6f87d0b5d63`

r151050 release repository: https://pkg.omnios.org/r151050/core

## Upgrade Notes

Upgrades are supported from the r151046 and r151048 releases only. If upgrading
from an earlier version, upgrade in stages, referring to the table at
<https://omnios.org/upgrade>.

## New features since r151048

### System Features

* Python 3 has been updated to version 3.12.

* Perl has been updated to version 5.38.

* SMB1 is disabled by default, the new default minimum SMB protocol version is
  2.1. SMB1 can be re-enabled if necessary using `sharectl`, for example:
  ```
  sharectl set -p min_protocol=1 smb
  ```

* Support for the `xenl` terminal feature has been implemented. Also known as
  `eat_newline_glitch`, this allows a newline after 80 columns to be ignored
  which can improve the rendering of some terminal programs.

* Kernel statistics (kstats) for PCIe native hotplug events have been added.

### Commands and Command Options

* OpenJDK 21 has been added.

* The -n and -o options to `pgrep` would previously print the wrong process
  arguments. This has been corrected.

* The `pcieadm` command can now decode readiness time reporting information.

### Libraries and Library Functions

* A new `libnvme.so` library is available allowing better programmatic access
  to NVMe drives. The `nvmeadm` CLI utility has been re-implemented in terms of
  this library and has been extended with additional options for formatting
  output, accessing vendor-specific log pages and more. See
  [the manual](https://man.omnios.org/nvmeadm) for more details.

* The system C library now provides
  [execvpe(2)](https://man.omnios.org/execvpe) and
  [fexecve(2)](https://man.omnios.org/fexecve) functions.

* The static version of the ncurses library, `libncurses.a` is no longer
  shipped.

* [getaddrinfo(3socket)](https://man.omnios.org/man3socket/getaddrinfo)
  now works correctly with socktype 0 and the `AI_NUMERICSERV` option.

* `libpsl`, the C library for the Public Suffix List, is now available and used
  by packages such as curl.

* Man pages for [libjedec(3jedec)](https://man.omnios.org/libjedec)
  are now available.

* A Generic SPD decoding library is now available.

### LX zones

* Support for `getsockopt(TCP_INFO)` has been added.

### Bhyve

* The bhyve UEFI bootrom has been updated to the 202308 stable version of
  EDK-II.

### ZFS

* The minimum size of the ARC has been reduced, allowing it to better shrink as
  necessary on systems with a lot of RAM.

* ZFS scrubs now pause when system memory is low, and resume automatically
  afterwards.

### Hardware Support

* The Intel I219 V17 and LM+V24-27 and LM+V24-29 network adapter variants are
  now supported.

* A new `igc` driver supporting the Intel I225/226 adapters has been added.

* A virtio random driver has been added, `viorand`.

* A virtio SCSI driver (`vioscsi`) is now available and included in the default
  system installation.

* Emulex LPe35000/LPe36000 32Gb/64Gb fibre channel chipsets are now supported.

* QLogic 16Gb FC-HBA 7288 is now supported.

* Support for the Microsemi SmartPQI HBA has been added.

* ATTO Celerity FC-162E Gen 5 and Celerity FC-162P Gen 6 16GB FC cards are now
  supported.

* A new `lmrc` driver has been added, supporting the Aero and Ventura
  generations of MegaRAID SAS controllers.

* NVMe drives based on the Phison E18 controller that have certain quirks now
  show up and can be used.

* Calibration of the system clock under KVM and other hypervisors now uses
  information from the hypervisor and avoids trying to use the legacy PIT
  which is known to be broken with some cloud providers.

* Improved support for AMD Zen4 systems.

### Virtualisation

* Hyper-V Gen2 VMs now have better support including a display and keyboard
  driver. Previously these were only useable with a serial console.

### Developer Features

* The system disassembler has been extended to support more AVX-512 and other
  newer instructions.

* The speed of the system linker when confronted with objects containing a
  large number of symbols has been significantly improved.

* `mdb` has gained a `::mutex` command for displaying user-level mutexes.

* `mdb` has gained a `::vmm` command for inspecting bhyve virtual machines.

* `mdb` has also gained a `::tdelta` command to display time deltas, and the
  `::msgbuf` command has a new `-t` flag to include time deltas in the output.

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
| compress/lzip | 1.23 | 1.24.1
| compress/xz | 5.4.4 | 5.6.1
| data/iso-codes | 4.15.0 | 4.16.0
| database/sqlite-3 | 3.43.1 | 3.45.2
| developer/build/autoconf | 2.71 | 2.72
| developer/build/libtool | 2.4.6 | 2.4.7
| developer/gnu-binutils | 2.41 | 2.42
| developer/swig | 4.1.1 | 4.2.1
| developer/versioning/git | 2.42.0 | 2.44.0
| developer/versioning/mercurial | 6.5.2 | 6.7
| **driver/crypto/viorand** | _New_ | 0.5.11
| **driver/network/dnet** | _New_ | 0.5.11
| **driver/network/igc** | _New_ | 0.5.11
| ~~driver/network/platform~~ | 0.5.11 | _Removed_
| **driver/storage/lmrc** | _New_ | 0.5.11
| **driver/storage/smartpqi** | _New_ | 0.5.11
| editor/vim | 9.0.1443 | 9.0.2136
| library/c++/sigcpp | 3.4.0 | 3.6.0
| library/expat | 2.5.0 | 2.6.2
| library/glib2 | 2.78.0 | 2.80.0
| library/libffi | 3.4.4 | 3.4.5
| library/libidn | 1.41 | 1.42
| **library/libpsl** | _New_ | 0.21.5
| library/libtool/libltdl | 2.4.6 | 2.4.7
| library/libxml2 | 2.11.7 | 2.12.6
| library/lzlib | 1.13 | 1.14
| library/nghttp2 | 1.56.0 | 1.60.0
| library/pcre2 | 10.42 | 10.43
| library/perl-5/xml-parser | 2.46 | 2.47
| ~~library/python-3/asn1crypto-311~~ | 1.5.1 | _Removed_
| **library/python-3/asn1crypto-312** | _New_ | 1.5.1
| ~~library/python-3/attrs-311~~ | 23.1.0 | _Removed_
| **library/python-3/attrs-312** | _New_ | 23.2.0
| ~~library/python-3/cffi-311~~ | 1.15.1 | _Removed_
| **library/python-3/cffi-312** | _New_ | 1.16.0
| ~~library/python-3/coverage-311~~ | 7.3.0 | _Removed_
| **library/python-3/coverage-312** | _New_ | 7.4.3
| ~~library/python-3/crossenv-311~~ | 1.4.0 | _Removed_
| **library/python-3/crossenv-312** | _New_ | 1.4.0
| ~~library/python-3/cryptography-311~~ | 41.0.3 | _Removed_
| **library/python-3/cryptography-312** | _New_ | 42.0.5
| ~~library/python-3/idna-311~~ | 3.4 | _Removed_
| **library/python-3/idna-312** | _New_ | 3.6
| ~~library/python-3/js-regex-311~~ | 1.0.1 | _Removed_
| **library/python-3/js-regex-312** | _New_ | 1.0.1
| ~~library/python-3/jsonrpclib-311~~ | 0.4.3.2 | _Removed_
| **library/python-3/jsonrpclib-312** | _New_ | 0.4.3.2
| ~~library/python-3/jsonschema-311~~ | 4.17.3 | _Removed_
| **library/python-3/jsonschema-312** | _New_ | 4.17.3
| ~~library/python-3/meson-311~~ | 1.2.1 | _Removed_
| **library/python-3/meson-312** | _New_ | 1.4.0
| ~~library/python-3/orjson-311~~ | 3.9.5 | _Removed_
| **library/python-3/orjson-312** | _New_ | 3.9.15
| **library/python-3/packaging-312** | _New_ | 24.0
| ~~library/python-3/pip-311~~ | 23.2.1 | _Removed_
| **library/python-3/pip-312** | _New_ | 24.0
| ~~library/python-3/pycodestyle-311~~ | 2.11.0 | _Removed_
| **library/python-3/pycodestyle-312** | _New_ | 2.11.1
| ~~library/python-3/pycparser-311~~ | 2.21 | _Removed_
| **library/python-3/pycparser-312** | _New_ | 2.21
| ~~library/python-3/pycurl-311~~ | 7.44.1 | _Removed_
| **library/python-3/pycurl-312** | _New_ | 7.44.1
| ~~library/python-3/pyopenssl-311~~ | 23.2.0 | _Removed_
| **library/python-3/pyopenssl-312** | _New_ | 24.1.0
| ~~library/python-3/pyrsistent-311~~ | 0.19.3 | _Removed_
| **library/python-3/pyrsistent-312** | _New_ | 0.20.0
| ~~library/python-3/pyyaml-311~~ | 6.0.1 | _Removed_
| **library/python-3/pyyaml-312** | _New_ | 6.0.1
| ~~library/python-3/rapidjson-311~~ | 1.11 | _Removed_
| **library/python-3/rapidjson-312** | _New_ | 1.16
| ~~library/python-3/semantic-version-311~~ | 2.10.0 | _Removed_
| **library/python-3/semantic-version-312** | _New_ | 2.10.0
| ~~library/python-3/setuptools-311~~ | 68.1.2 | _Removed_
| **library/python-3/setuptools-312** | _New_ | 69.1.1
| ~~library/python-3/setuptools-rust-311~~ | 1.7.0 | _Removed_
| **library/python-3/setuptools-rust-312** | _New_ | 1.9.0
| ~~library/python-3/six-311~~ | 1.16.0 | _Removed_
| **library/python-3/six-312** | _New_ | 1.16.0
| ~~library/python-3/tomli-311~~ | 2.0.1 | _Removed_
| **library/python-3/tomli-312** | _New_ | 2.0.1
| ~~library/python-3/typing-extensions-311~~ | 4.7.1 | _Removed_
| **library/python-3/typing-extensions-312** | _New_ | 4.10.0
| network/dns/bind | 9.18.19 | 9.18.24
| network/openssh | 9.6.1 | 9.7.1
| network/openssh-server | 9.6.1 | 9.7.1
| network/socat | 1.7.4.4 | 1.8.0.0
| **runtime/java/openjdk21** | _New_ | 21.0.2
| runtime/perl | 5.36.3 | 5.38.2
| ~~runtime/python-311~~ | 3.11.9 | _Removed_
| **runtime/python-312** | _New_ | 3.12.3
| security/sudo | 1.9.14.3 | 1.9.15.5
| service/network/chrony | 4.4 | 4.5
| service/network/ntpsec | 1.2.2 | 1.2.3
| shell/bash | 5.2.15 | 5.2.26
| shell/pipe-viewer | 1.8.0 | 1.8.5
| shell/tcsh | 6.24.10 | 6.24.11
| system/bhyve/firmware | 20230201 | 20230801
| system/library/mozilla-nss | 3.93 | 3.99
| ~~system/library/python/libbe-311~~ | 0.5.11 | _Removed_
| **system/library/python/libbe-312** | _New_ | 0.5.11
| ~~system/library/python/solaris-311~~ | 0.5.11 | _Removed_
| **system/library/python/solaris-312** | _New_ | 0.5.11
| ~~system/library/python/zfs-311~~ | 0.5.11 | _Removed_
| **system/library/python/zfs-312** | _New_ | 0.5.11
| system/management/cloud-init | 23.1.2 | 23.4.1
| ~~system/network/spdadm~~ | 0.5.11 | _Removed_
| system/pciutils | 3.10.0 | 3.11.1
| system/rsyslog | 8.2308.0 | 8.2402.0
| system/test/fio | 3.35 | 3.36
| **system/test/nvmetest** | _New_ | 0.5.11
| system/virtualization/open-vm-tools | 12.3.0 | 12.3.5
| terminal/tmux | 3.3 | 3.4
| text/gawk | 5.2.2 | 5.3.0
| text/gnu-gettext | 0.22.2 | 0.22.5
| web/wget | 1.21.4 | 1.24.5
