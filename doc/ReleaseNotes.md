<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151044

## r151044at (2023-09-20)
Weekly release for w/c 18th of September 2023.
> This is a non-reboot update

### Security Fixes

* Curl has been updated to version 8.3.0

* OpenJDK has has been updated to 11.0.20.1+1 and 17.0.8.1+1

* Python has been updated to version 3.10.13

* OpenSSL has been updated to version 3.0.11

<br>

---

## r151044ap (2023-08-24)
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

## r151044am (2023-08-03)
Weekly release for w/c 31st of July 2023.
> This is a non-reboot update

### Security Fixes

- OpenSSL packages updated to versions 3.0.10 / 1.1.1v / 1.0.2u-4, resolving
  [CVE-2023-3817](https://www.openssl.org/news/secadv/20230731.txt),
  [CVE-2023-3446](https://www.openssl.org/news/secadv/20230719.txt),
  [CVE-2023-2975](https://www.openssl.org/news/secadv/20230714.txt).

- OpenJDK 8 has been updated to version 1.8.0u382-b05.

<br>

---

## r151044al (2023-07-25)
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

## r151044ak (2023-07-20)
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

<br>

---

## r151044ag (2023-06-20)
Weekly release for w/c 19th of June 2023.
> This update requires a reboot

### Security Fixes

* Python has been updated to version 3.10.12;

* Vim has been updated to version 9.0.1443.

### Other Changes

* SMB NetLogon Client Seal support.

<br>

---

## r151044ad (2023-05-31)
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

<br>

---

## r151044y (2023-04-27)
Weekly release for w/c 24th of April 2023.
> This update requires a reboot

### Security Fixes

* `git` has been updated to version 2.37.7, fixing
  [CVE-2023-25652](https://nvd.nist.gov/vuln/detail/CVE-2023-25652),
  [CVE-2023-25815](https://nvd.nist.gov/vuln/detail/CVE-2023-25815),
  [CVE-2023-29007](https://nvd.nist.gov/vuln/detail/CVE-2023-29007).

* The `openjdk` packages have been updated to versions 17.0.7+7, 11.0.19+7
  and 1.8.372-07.

### Other Changes

* Perl has been updated to version 5.36.1

<br>

---

## r151044x (2023-04-21)
Weekly release for w/c 17th of April 2023.
> This update requires a reboot

### Security Fixes

* The bundled AMD CPU microcode has received an update for AMD Rome CPUs (processor family 17h).

* libxml2 has been updated to 2.10.4, fixing several CVEs.

* python 3.10 has been updated to 3.10.11.

* `pkg` has been patched, fixing
  [CVE-2023-21928](https://nvd.nist.gov/vuln/detail/CVE-2023-21928).

### Other Changes

* The `onbld` package now ships updated `.env` files to set gcc 10 as primary compiler for `illumos-gate` builds.
  See <https://illumos.topicbox.com/groups/developer/Tc01851d253a5fd32/heads-up-moving-to-gcc-10-primary>.

<br>

---

## r151044v (2023-04-07)
Weekly release for w/c 3rd of April 2023.
> This update requires a reboot

### Security Fixes

* The bundled Intel CPU microcode has been updated. See
  <https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20230214> for details.

* curl has been updated to version 8.0.1 fixing
  [6 security vulnerabilities](https://curl.se/docs/vuln-7.88.1.html)

* openssl has been updated to mitigate
  [CVE-2023-0464](https://www.openssl.org/news/secadv/20230322.txt)

* rsyslog has been updated to address a vulnerability in the `fastjson`
  component that it uses internally. Due to extra bounds checks employed
  by rsyslog, it is unlike that this problem could be exploited.

### Other Changes

* zstd has been updated to version 1.5.5 to fix a
  [rare corruption bug](https://github.com/facebook/zstd/releases/tag/v1.5.5).

* The timezone database has been updated to version 2023c.

* gcc 7 has been updated to the latest illumos version, gcc 7.5.0-il-2.

<br>

---

## r151044p (2023-02-21)
Weekly release for w/c 20th of February 2023.
> This update requires a reboot

### Security Fixes

* Git has been updated to version 2.37.6.

### Other Changes

* The bundled AMD CPU microcode has been updated.

* The `signalfd` driver could cause a system panic.

* It was possible that the system could panic if the in-zone NFS server was in
  use.


<br>

---

## r151044n (2023-02-07)
Weekly release for w/c 06th of February 2023.
> This is a non-reboot update

### Security Fixes

* OpenSSL packages updated to 3.0.8 and 1.1.1t, fixing
  [various vulnerabilities](https://www.openssl.org/news/secadv/20230207.txt)

* OpenSSL 1.0.2 has been also been patched to resolve vulnerabilities.

* OpenJDK packages updated to 17.0.6+10, 11.0.18+10 and 1.8.362-09

<br>

---

## r151044k (2023-01-18)
Weekly release for w/c 16th of January 2023.
> This is a non-reboot update

### Security Fixes

* The `git` package has been updated to a version which includes a fix for
  [CVE-2022-23521(https://github.com/git/git/security/advisories/GHSA-c738-c5qq-xg89).

* `sudo` has been updated to address
  [CVE-2023-22809](https://www.sudo.ws/security/advisories/sudoedit_any/).

<br>

---

## r151044h (2022-12-31)
Weekly release for w/c 26th of December 2022.
> This is a non-reboot update

### Security Fixes

* [15295 SMB servers did not always check IPC caller privileges](https://www.illumos.org/issues/15295)

<br>

---

## r151044g (2022-12-24)
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

* 15206 setcontext(2) should restore %fsbase

* Fix possible bhyve network interface deadlock

<br>

---

Stable Release, 7th of November 2022

`uname -a` shows `omnios-r151044-d3b715b9d1`

r151044 release repository: https://pkg.omnios.org/r151044/core

## Upgrade Notes

Upgrades are supported from the r151038, r151040 and r151042 releases only. If
upgrading from an earlier version, upgrade in stages, referring to the table at
<https://omnios.org/upgrade>.

## New features since r151042

### System Features

* Hot plug of NVMe drives on systems which do not support PCI power control now
  works correctly.

* OmniOS userland is now built with gcc version 12.

* A number of python modules have been removed in this release. Refer to
  the table at the end of this document for more details. When using Python
  for applications, it is recommended that the Python `venv` module is used to
  manage dependencies rather than relying on modules provided with the
  operating system.

* A patch that was previously applied to OpenSSH to resolve problems for
  VMWare guests using NAT mode has been removed. OpenSSH will now use
  standard DSCP options for QoS.

* The `ec2-credential` and `azure-agent` packages have been removed in favour
  of `cloud-init`. If you upgrade from a previous release which has these
  packages installed, they will be retained.

* A new tuneable kernel parameter has been added for `ipf` that allows response
  to outbound packets.
  ```
  echo 'set ipf:outboundrst = 1' > /etc/system.d/ipf
  ```
  This then allows the use of outbound rules using actions such as `return-rst`.

* The console driver now supports hiding the cursor and has received some
  improvements around colour and emboldening support.

### Commands and Command Options

* The `pwait` utility will now never wait on its own process ID.

* `format` will now recognise a new (unformatted) NVMe disk.

* The `strip` command could previously become confused when processing
  binaries containing a lot of debug sections.

* `psrinfo` would sometimes fail to emit the processor socket type, even if
  it knows it.

* `pcieadm` decoded the address of an expansion ROM incorrectly.

* The `pcieadm` utility has been enhanced with support for decoding 32.0GT/s
  speeds and NPEM capabilities.

### Libraries and Library Functions

* The [getifaddrs(3SOCKET)](https://man.omnios.org/getifaddrs) library
  function has been extended to enumerate more address families.

### LX zones

* It is now possible to specify multiple IP addresses per VNIC in an lx
  zone configuration.

### Bhyve

* Many updates and improvements to bhyve from upstream illumos.

* The `viona` driver now supports a control queue and promiscuous mode.

* The `::sysregs` command under `mdb -b` did not work on AMD, this has been
  resolved.

### Package Management

* The format of the OmniOS IPS repositories for this release has changed so
  that catalogues are stored in native UTF-8 format (see
  [pkgrepo(1)](https://man.omnios.org/pkgrepo#repository/format)). This allows
  clients such as pkg(1) to parse the catalogues faster and with less memory
  overhead but means that these repositories are not compatible with pkg
  clients older than that found in the r151038 release.

### Hardware Support

* PCIe hotplug is now supported for slots without a power controller. In
  particular, this means that the hotplug support for NVME drives should work
  on a wider variety of motherboards than before.

* A new AMD Unified Memory Controller driver is available.

* Additional AVX512 capabilities are now supported.

* SMBIOS 3.6 support has been added.

* Block devices now support GUIDs for device naming. This may cause some
  system devices to change their device path on first boot with this release.

### Installer

* A new post-installation option is available allowing the installation of
  the `cloud-init` service.

### Virtualisation

* A new VirtIO SCSI driver is available.

* A new Virtio 9p driver is available.

* The VMWare SCSI driver (pvscsi) has been modernised.

* The Hyper-V SCSI driver has been rewritten to use modern kernel frameworks.

### Developer Features

* Version 12 of the `gcc` compiler is available in this release and, if
  installed, becomes the system default version of gcc unless the mediator is
  manually changed.

* The C pre-processor (`/usr/lib/cpp`) now defines the `__illumos__` token.

* `perl` has been updated to version 5.36

* A new set of manual pages covering the MAC ring subsystem have been added.

* The mdb `::dtrace` command could previously truncate messages when processing
  a system crash dump.

### Deprecated features

* The kernel SSL framework (kssl) has been retired in this release.

* The Network Cache Accelerator (nca) has been retired in this release.

* OpenSSH in OmniOS no longer provides support for GSSAPI key exchange.
  This was removed in release r151038.

* Python 2 is now end-of-life and will not receive any further updates. The
  `python-27` package is still available for backwards compatibility but will
  be maintained only on a best-efforts basis.

* OpenSSL 1.0.x is deprecated and reached end-of-support at the end of 2019.
  OmniOS has transitioned to OpenSSL 3 and still ships OpenSSL 1.1.1 for
  compatibility. The OpenSSL 1.0.2 libraries are also retained for
  backwards compatibility but are maintained solely on a best-efforts basis.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| compress/lz4 | 1.9.3 | 1.9.4
| data/iso-codes | 4.9.0 | 4.11.0
| database/sqlite-3 | 3.38.2 | 3.39.4
| developer/gcc10 | 10.3.0 | 10.4.0
| developer/gcc11 | 11.2.0 | 11.3.0
| **developer/gcc12** | _New_ | 12.2.0
| developer/gnu-binutils | 2.38 | 2.39
| developer/macro/cpp | 0.5.11 | 20220808
| ~~developer/tnf~~ | 0.5.11 | _Removed_
| developer/versioning/git | 2.35.2 | 2.37.3
| developer/versioning/mercurial | 6.1 | 6.2.2
| **driver/storage/vio9p** | _New_ | 0.5.11
| **driver/storage/vioscsi** | _New_ | 0.5.11
| editor/vim | 8.2.4691 | 9.0.0
| file/gnu-coreutils | 9.0 | 9.1
| library/glib2 | 2.72.0 | 2.74.0
| library/libffi | 3.4.2 | 3.4.3
| library/libidn | 1.38 | 1.41
| library/nghttp2 | 1.47.0 | 1.50.0
| library/nspr | 4.32 | 4.34.1
| library/nspr/header-nspr | 4.32 | 4.34.1
| library/pcre2 | 10.39 | 10.40
| library/python-3/attrs-310 | 21.4.0 | 22.1.0
| library/python-3/cffi-310 | 1.15.0 | 1.15.1
| ~~library/python-3/cheroot-310~~ | 8.6.0 | _Removed_
| ~~library/python-3/cherrypy-310~~ | 18.6.1 | _Removed_
| library/python-3/coverage-310 | 6.3.2 | 6.4.4
| library/python-3/cryptography-310 | 36.0.2 | 38.0.1
| library/python-3/idna-310 | 3.3 | 3.4
| ~~library/python-3/jaraco-310~~ | 1.0.0 | _Removed_
| library/python-3/jsonschema-310 | 4.4.0 | 4.16.0
| ~~library/python-3/mako-310~~ | 1.2.0 | _Removed_
| ~~library/python-3/markupsafe-310~~ | 2.1.1 | _Removed_
| library/python-3/meson-310 | 0.62.0 | 0.63.2
| ~~library/python-3/more-itertools-310~~ | 8.12.0 | _Removed_
| library/python-3/orjson-310 | 3.6.7 | 3.8.0
| library/python-3/pip-310 | 22.0.4 | 22.2.2
| ~~library/python-3/ply-310~~ | 3.11 | _Removed_
| ~~library/python-3/portend-310~~ | 3.1.0 | _Removed_
| ~~library/python-3/prettytable-310~~ | 3.2.0 | _Removed_
| ~~library/python-3/pybonjour-310~~ | 1.1.1 | _Removed_
| library/python-3/pycodestyle-310 | 2.8.0 | 2.9.1
| ~~library/python-3/pytz-310~~ | 2022.1 | _Removed_
| library/python-3/rapidjson-310 | 1.6 | 1.8
| library/python-3/semantic-version-310 | 2.9.0 | 2.10.0
| library/python-3/setuptools-310 | 60.10.0 | 65.3.0
| library/python-3/setuptools-rust-310 | 1.1.2 | 1.5.2
| ~~library/python-3/tempora-310~~ | 5.0.1 | _Removed_
| library/python-3/typing-extensions-310 | 4.1.1 | 4.3.0
| ~~library/python-3/wcwidth-310~~ | 0.2.5 | _Removed_
| ~~library/python-3/zc.lockfile-310~~ | 2.0 | _Removed_
| library/unixodbc | 2.3.9 | 2.3.11
| library/zlib | 1.2.12 | 1.2.13
| network/dns/bind | 9.16.27 | 9.18.7
| network/openssh | 8.9.1 | 9.0.1
| network/openssh-server | 8.9.1 | 9.0.1
| network/rsync | 3.2.3 | 3.2.6
| runtime/perl | 5.34.1 | 5.36.0
| security/sudo | 1.9.10 | 1.9.11.3
| service/network/chrony | 4.2 | 4.3
| shell/zsh | 5.8.1 | 5.9
| system/data/hardware-registry | 2021.12.23 | 2022.9.9
| system/data/zoneinfo | 2022.2 | 2022.6
| system/library/dbus | 1.14.0 | 1.14.2
| system/library/g++-runtime | 11 | 12
| system/library/gcc-runtime | 11 | 12
| system/library/gfortran-runtime | 11 | 12
| system/library/gobjc-runtime | 11 | 12
| system/library/libdbus | 1.14.0 | 1.14.2
| system/library/mozilla-nss | 3.76.1 | 3.83
| system/library/mozilla-nss/header-nss | 3.76.1 | 3.83
| ~~system/library/processor~~ | 0.5.11 | _Removed_
| system/management/cloud-init | 22.1 | 22.3
| ~~system/management/ec2-credential~~ | 1.0 | _Removed_
| system/management/ipmitool | 1.8.18 | 1.8.19
| ~~system/network/http-cache-accelerator~~ | 0.5.11 | _Removed_
| system/pciutils | 3.7.0 | 3.8.0
| system/pciutils/pci.ids | 2.2.20211215 | 2.2.20220909
| system/rsyslog | 8.2202.0 | 8.2208.0
| system/test/fio | 3.29 | 3.32
| **system/test/smbsrvtest** | _New_ | 0.5.11
| ~~system/tnf~~ | 0.5.11 | _Removed_
| ~~system/virtualization/azure-agent~~ | 2.2.54 | _Removed_
| terminal/tmux | 3.2 | 3.3
| text/gawk | 5.1.1 | 5.2.0
| text/gnu-grep | 3.7 | 3.8
| text/less | 590 | 608
| web/wget2 | 2.0.0 | 2.0.1
