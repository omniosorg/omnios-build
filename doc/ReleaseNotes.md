<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOS r151038

## r151038co (2023-02-07)
Weekly release for w/c 06th of February 2023.
> This is a non-reboot update

### Security Fixes

* OpenSSL updated to 1.1.1t, fixing
  [various vulnerabilities](https://www.openssl.org/news/secadv/20230207.txt)

* OpenSSL 1.0.2 has been also been patched to resolve vulnerabilities.

* OpenJDK packages updated to 11.0.18+10 and 1.8.362-09

<br>

---

## r151038cl (2023-01-18)
Weekly release for w/c 16th of January 2023.
> This is a non-reboot update

### Security Fixes

* The `git` package has been updated to a version which includes a fix for
  [CVE-2022-23521(https://github.com/git/git/security/advisories/GHSA-c738-c5qq-xg89).

* `sudo` has been updated to address
  [CVE-2023-22809](https://www.sudo.ws/security/advisories/sudoedit_any/).

<br>

---

## r151038ci (2022-12-31)
Weekly release for w/c 26th of December 2022.
> This is a non-reboot update

### Security Fixes

* [15295 SMB servers did not always check IPC caller privileges](https://www.illumos.org/issues/15295)

<br>

---

## r151038ch (2022-12-24)
Weekly release for w/c 19th of December 2022.
> This update requires a reboot

### Security Fixes

* Curl updated to 7.87.0

* Intel CPU microcode updated to 20221108

* Python updated to version 3.9.15

* Sudo updated to version 1.9.12p1

### Other Changes

* Fix for excessive CPU consumption by rust binaries in lx zones

* 14041 Dell R650 Xeon Gold 5318Y not booting

* 15286 do_composition() needs sign awareness

<br>

---

## r151038ca (2022-11-01)
Weekly release for w/c 31st of October 2022.
> This is a non-reboot update

### Fixes

* OpenSSL upgraded to version 1.1.1s.

<br>

---

## r151038bz (2022-10-26)
Weekly release for w/c 24th of October 2022.
> This is a non-reboot update

### Security Fixes

* curl updated to version 7.86.0, fixing
  [CVE-2022-42916](https://curl.se/docs/CVE-2022-42916.html),
  [CVE-2022-42915](https://curl.se/docs/CVE-2022-42915.html),
  [CVE-2022-35260](https://curl.se/docs/CVE-2022-35260.html) and
  [CVE-2022-32221](https://curl.se/docs/CVE-2022-32221.html).

* OpenJDK packages updated to versions 1.8.352-08 and 11.0.17+8.

### Other Changes

* The 64-bit `libzstd.pc` file was incorrect.

<br>

---

## r151038by (2022-10-19)
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

* Python has been updated to version 3.9.15

* The bhyve VNC server did not properly handle connections from the native
  Screen Sharing client in MacOS Ventura

<br>

---

## r151038bv (2022-09-27)
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

* Python has been updated to version 3.9.14

<br>

---

## r151038br (2022-08-30)
Weekly release for w/c 29th of August 2022.
> This is a non-reboot update

### Security Fixes

* `open-vm-tools` updated to version 12.1.0, fixing
  [CVE-2022-31676](https://www.vmware.com/security/advisories/VMSA-2022-0024.html)

### Other Changes

* `library/libxml2` updated to version 2.10.1

<br>

---

## r151038bq (2022-08-25)
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

## r151038bo (2022-08-09)
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

* OpenJDK packages updated to versions 1.8.345-01 and 11.0.16+8

* OpenSSL updated to version 1.1.1q

### Other Changes

* Updates to ZFS to gracefully handle unknown/invalid vdev device IDs

<br>

---

## r151038bi (2022-06-30)
Weekly release for w/c 27th of June 2022.
> This update requires a reboot

### Security Fixes

* Intel CPU microcode has been updated to version 20220510.

* curl updated to version 7.84.0, fixing
  [CVE-2022-32208](https://curl.se/docs/CVE-2022-32208.html),
  [CVE-2022-32207](https://curl.se/docs/CVE-2022-32207.html),
  [CVE-2022-32206](https://curl.se/docs/CVE-2022-32206.html) and
  [CVE-2022-32205](https://curl.se/docs/CVE-2022-32205.html).

<br>

---

## r151038bh (2022-06-22)
Weekly release for w/c 20th of June 2022.
> This update requires a reboot

### Security Fixes

* OpenSSL has been updated to version 1.1.1p, fixing
  [CVE-2022-2068](https://www.openssl.org/news/secadv/20220621.txt).

* Intel CPU microcode has been updated to version 20220419.

### Other Changes

* Python 3.9 has been updated to version 3.9.13

* lx sendfile() compability has been improved.

<br>

---

## r151038bb (2022-05-12)
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

## r151038ba (2022-05-04)
Weekly release for w/c 2nd of May 2022.
> This is a non-reboot update

### Security Fixes

* OpenSSL has been updated to versions 3.0.3 and 1.1.1o.

* OpenJDK has been updated to version 1.8.332-09.

* Curl has been updated to version 7.83.0.

<br>

---

## r151038ay (2022-04-22)
Weekly release for w/c 18th of April 2022.
> This is a non-reboot update

### Security Fixes

* `openjdk` has been updated to 11.0.15+10, fixing several CVEs.

* `git` has been updated to version 2.31.2

* `vim` has been updated to 8.2.4691 fixing several CVEs.

<br>

---

## r151038ax (2022-04-11)
Weekly release for w/c 11th of April 2022.
> This is a non-reboot update

### Security Fixes

* `zlib` updated to version 1.2.12, fixing
  [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032).

<br>

---

## r151038aw (2022-04-08)
Weekly release for w/c 4th of April 2022.
> This update requires a reboot

### Security Fixes

* The emulated e1000g network interface in bhyve was subject to an
  out-of-bounds write vulnerability -
  [CVE-2022-23087](https://www.freebsd.org/security/advisories/FreeBSD-SA-22:05.bhyve.asc).

* `gzip` updated to version 1.12

### Other Changes

* LX zones support for newer Linux distributions that use glibc >= 2.35

* Improvements to the bhyve VNC server; support for multiple concurrent
  clients and some alternate pixmaps.

* Fix a bug where zpool expansion could hang with some disk drivers.

* Update timezone data to 2022.01.

<br>

---

## r151038av (2022-03-28)
Weekly release for w/c 28th of March 2022.
> This is a non-reboot update

### Security Fixes

* `python-39` has been updated to 3.9.12, fixing
  [several CVEs](https://www.python.org/downloads/release/python-3911/).

<br>

---

## r151038at (2022-03-17)
Weekly release for w/c 14th of March 2022.
> This is a non-reboot update

### Security Fixes

* `openssl` packages have been updated/patched, fixing
  [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778).

* `python-27` has been patched, fixing
  [CVE-2021-3733](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3733),
  [CVE-2022-0391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0391).

### Other Changes

* `expat` has been updated to 2.4.7.

<br>

---

## r151038aq (2022-02-21)
Weekly release for w/c 21st of February 2022.
> This update requires a reboot

### Security Fixes

* The Intel CPU microcode has been updated to version 20220207. Depending on
  the processor, this includes fixes for
  [CVE-2021-0146](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-0146),
  [CVE-2021-0127](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-0127).

* The `expat` library package has been updated, fixing
  [CVE-2022-23852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23852),
  [CVE-2022-23990](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23990),
  [CVE-2022-25235](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25235),
  [CVE-2022-25236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25236),
  [CVE-2022-25313](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25313),
  [CVE-2022-25314](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25314),
  [CVE-2022-25315](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25315).

* The `libxml2` library package has been updated, fixing
  [CVE-2022-23308](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23308).

* It was possible for an unprivileged user to replace the contents of a
  setuid/setgid file without clearing the special attributes, if they had
  write access to the file and were able to induce a kernel panic.

### Enhancements

* The [memrchr(3C)](https://man.omnios.org/memrchr.3c) function has been added
  to the system C library. This was necessary for continued support for running
  binaries from [Joyent's pkgsrc repository](https://pkgsrc.joyent.com/).

### Bug Fixes

* The `zpool online -e` command could cause the ZFS pool to become unavailable
  until the system is rebooted when the disk partition table needed to be
  modified.

* The `iprb` network driver was unusable due to constant watchdog resets and
  possible kernel panics..

* The UDP packet send path was acquiring a mutex unecessarily.

* The SMBIOS type 3 structure presented to bhyve guests was incorrect.

* The `sys/atomic.h` header file had some incorrect guard definitions.

### Other Changes

* The database of PCI and USB identifiers has been updated.

* Timezone data has been updated.

<br>

---

## r151038an (2022-01-31)
Weekly release for w/c 31st of January 2022.
> This is a non-reboot update

### Security Fixes

* `openjdk` has been updated to 11.0.14+9 fixing several CVEs.

<br>

---

## r151038al (2022-01-18)
Weekly release for w/c 17th of January 2022.
> This update requires a reboot.

### Security Fixes

* `tmpfs` could be induced to deadlock -
  [CVE-2021-43395](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-43395).

* `expat` updated to version 2.4.3, fixing
  [CVE-2021-45960](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45960),
  [CVE-2021-46143](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-46143),
  [CVE-2022-22822](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22822),
  [CVE-2022-22823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22823),
  [CVE-2022-22824](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22824),
  [CVE-2022-22825](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22825),
  [CVE-2022-22826](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22826)
  and
  [CVE-2022-22827](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22827).

<br>

---

## r151038ag (2021-12-17)
Weekly release for w/c 13th of December 2021.
> This update requires a reboot

### Security Fixes

* Strengthened LX-exclusive filesystems against races

### Bug Fixes

* `mpathadm` could crash when attempting to access a SCSI device.

* `chrony` could fail to keep the system clock fully synchronised.

### Other Changes

* Openssl has been updated to version 1.1.1m

* Python has been updated to version 3.9.9

* The `ena` (AWS Elastic Network Adapter) network driver has been introduced.
  This allows OmniOS to be used on AWS Nitro instances giving access to
  instances with better network and disk performance, and with the option for
  a serial console.

<br>

---

## r151038ac (2021-11-17)
Weekly release for w/c 15th of November 2021.
> This is a non-reboot update

### Security Fixes

* `vim` has been updated to version 8.2.3582.

* `python` 3.9 has been updated to version 3.9.8

### Other Changes

* Some 32-bit and legacy `net-snmp` libraries had missing symbols.

* `git-pbchk` has been updated to add a new module for verifying the format
  of package manifests.

<br>

---

## r151038z (2021-10-29)
Weekly release for w/c 25th of October 2021.
> This is a non-reboot update

### Changes

* `ca-bundle` has been updated (`nss` 3.70).

<br>

---

## r151038y (2021-10-21)
Weekly release for w/c 18th of October 2021.
> This is a non-reboot update

### Security Fixes

* `vim` has been updated to 8.2.3445 fixing several CVEs.

* `openjdk` has been updated to 11.0.13+8 and 1.8.312-07 fixing several CVEs.

### Changes

* `cpuid` has been updated to 1.8.2.

<br>

---

## r151038x (2021-10-13)
Weekly release for w/c 11th of October 2021.
> This is a non-reboot update

### Changes

* Update illumos-tools meta package to require gcc 10, which is now the
  shadow compiler for illumos-gate.

* Update the provided template `/opt/onbld/env/omnios-illumos-gate` file to
  use gcc10 for shadow in place of gcc4. See also
  <https://downloads.omnios.org/env/> for updated example files.

<br>

---

## r151038v (2021-09-28)
Weekly release for w/c 27th of September 2021.
> This update requires a reboot

### Security Fixes

* OpenSSH has been updated, fixing
  [CVE-2021-41617](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-41617).

### Bug fixes

* If the system dump device was configured on a ZVOL on a RAIDZ pool, then
  a system panic could cause unrelated corruption on the pool.

* bhyve guests could fail to boot on some older AMD machines; this was a
  regression from previous OmniOS releases.

* Several improvements have been made to the viona network driver used by
  bhyve.

* Performance of the system console has been significantly improved.

* The `update-man-index` service which re-indexes manual pages at boot and
  after package operations has been optimised so that it only rebuilds the
  required indices.

* Attempting to multiplex non-device streams could result in a kernel panic.

### New features

* bhyve now supports virtio-9p (aka VirtFS) filesystem sharing to guests.
  This is configured through the new `virtfs[N]` zone attribute as described
  in [bhyve(5)](https://man.omnios.org/bhyve.5).

### Other changes

* The gcc10 package has been updated to match the published illumos
  gcc-10.3.0-il-1 tag.

<br>

---

## r151038u (2021-09-23)
Weekly release for w/c 20th of September 2021.
> This is a non-reboot update

### Changes

* `curl` has been updated to version 7.79.1.

* A new `chrony` package is available as an alternative to `ntpsec` for
  time synchronisation.

<br>

---

## r151038t (2021-09-15)
Weekly release for w/c 13th of September 2021.
> This is a non-reboot update

### Security Fixes

* `curl` has been updated to version 7.79.0 fixing 3 security vulnerabilities:
  * [CVE-2021-22945](https://curl.se/docs/CVE-2021-22945.html)
  * [CVE-2021-22946](https://curl.se/docs/CVE-2021-22946.html)
  * [CVE-2021-22947](https://curl.se/docs/CVE-2021-22947.html)

<br>

---

## r151038s (2021-09-07)
Weekly release for w/c 06th of September 2021.
> This update requires a reboot

### Security Fixes

* Python has been updated to 3.9.7.

### New Features

* It is now possible to provide `cloud-init` configuration information to
  bhyve guests. This includes networking configuration and initial passwords/
  SSH keys. See cloud-init in [bhyve(5)](https://man.omnios.org/bhyve.5) for
  more information.

* The `__illumos__` pre-processor token is now defined by the gcc compilers.

### Bug Fixes

* Windows 11 clients could not connect to SMB shares.

* p7zip would truncate passphrases read from the terminal.

* libstdc++.so was not using a thread-safe _errno_.

* LX was not properly configuring DNS settings for Ubuntu guests.

* The emulated `/proc` filesystem in LX was improperly representing open
  directories, causing problems for some applications.

* `smbd` could crash when a domain controller normally reached via IPv6 became
  unavailable.

* A system with a large number of disks visible through the BIOS  (> 64) would
  fail to boot.

* Cloning an `ipkg` zone could fail if the ssh service was not installed.

* Enabling `promiscphys` on a bhyve NIC now automatically configures the
  `promisc-filtered` datalink property.

* KVM and bhyve brand configuration now consistently supports the same
  truth values as bhyve (on/off/true/false/yes/no/0/1) for boolean parameters.

<br>

---

## r151038q (2021-08-24)
Weekly release for w/c 23rd of August 2021.
> This is a non-reboot update

### Security Fixes

* `openssl 1.1` updated to 1.1.1l, fixing
  [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711),
  [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712)

* `openssl 1.0` patched to fix
  [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712)

<br>

---

## r151038o (2021-08-10)
Weekly release for w/c 9th of August 2021.
> This is a non-reboot update

### Security Fixes

* `perl` core module `Encode` has been patched fixing
  [CVE-2021-36770](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36770).

<br>

---

## r151038l (2021-07-23)
Weekly release for w/c 19th of July 2021.
> This is a non-reboot update

### Security Fixes

* `curl` has been updated to version 7.78.0 fixing 5 security vulnerabilities:
  * [CVE-2021-22922](https://curl.se/docs/CVE-2021-22922.html)
  * [CVE-2021-22923](https://curl.se/docs/CVE-2021-22923.html)
  * [CVE-2021-22924](https://curl.se/docs/CVE-2021-22924.html)
  * [CVE-2021-22925](https://curl.se/docs/CVE-2021-22925.html)
  * [CVE-2021-22926](https://curl.se/docs/CVE-2021-22926.html)

* `openjdk` has been upgraded to 11.0.12+7 and 1.8.302-08, fixing:
  * [CVE-2021-2341](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2341)
  * [CVE-2021-2369](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2369)
  * [CVE-2021-2388](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2388)

### Other Changes

* `brand/bhyve` was missing a version dependency.

<br>

---

## r151038k (2021-07-13)
Weekly release for w/c 12th of July 2021.
> This update requires a reboot

### Security Fixes

* Microcode for Intel CPUs has been updated to the 2021-06-08 release.

* Python has been upgraded to 3.9.6.

### New Features

* It is now possible to use a netgroup database without a system being linked
  to an LDAP or NIS server. Refer to
  [netgroup(4)](https://man.omnios.org/netgroup.4) for more information.

* lx branded zones have been updated to better support distributions using
  systemd >= v247.

* lx branded zones now have basic support for `/proc/<pid>/fdinfo/`

* The Insyde BMC virtual CD-ROM device is now supported.

### Other Changes

* SMB encryption was not working with MacOS 11.4 clients.

* netstat showed duplicate data for UDP source and destination addresses.

* `netstat -u` could associate sockets with the wrong process.

* bhyve branded zones could place pass-through devices into the wrong PCI
  function slot causing problems for the guest. Devices are now always placed
  in numerical order and the location can be overridden -
  see [bhyve(5)](https://man.omnios.org/bhyve.5)

* `csh` would not always operate correctly when being used to run scripts.

* `pkg` now uses less memory when loading catalogues.

* The PCI and USB information databases have been updated.

* It was possible, although rare, to encounter a kernel panic when using
  kernel FPU acceleration in conjunction with RAIDZ pools.

* A rare ZFS panic that could occur when deleting millions of files has been
  fixed.

* NFS server performance has been improved.

* Several fixes for the in-kernel CIFS/SMB support have been incorporated.

<br>

---

## r151038g (2021-06-14)
Weekly release for w/c 14th of June 2021.
> This update requires a reboot

### Security Fixes

* ISC DHCP updated to 4.4.2-P1, fixing
  [CVE-2021-25217](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25217).

### Other Changes

* The bhyve hypervisor and the bhyve branded zone have received several updates
  that enable running with fewer resources and fewer privileges than before.

* bhyve VNC sessions are now named based on the underlying virtual machine name
  rather than always being called "bhyve".

* Additional network backends are available for bhyve, including an emulated
  `e1000` interface type.

* SMB3 encryption no longer breaks MacOS Big Sur clients.

* Fixes for kernel FPU use.

* The ZFS ARC algorithm has been adjusted to restore memory pressure;
  see [illumos issue 13766](https://www.illumos.org/issues/13766).

* Several ZFS L2ARC fixes and improvements have been incorporated.

* The ZFS `zdb` command could crash when processing RAIDZ pools, this has
  been resolved.

* The `segkpsize` tunable can now be adjusted using the `eeprom` command - see
  [eeprom(1M)](https://man.omnios.org/eeprom.1m).

* Improvements to the native C++ and rust demangling library.

* The CDP daemon (in.cdpd) now runs with reduced privileges;

* `zpool list -vp` now shows parsable sizes in all fields.

* `nvmeadm` now supports parsable output; see
  [nvmeadm(1M)](https://man.omnios.org/nvmeadm.1m)

* `profiles -l` could crash when an LDAP backend was in use, this has been
  resolved.

<br>

---

## r151038d (2021-05-26)
Weekly release for w/c 24th of May 2021.
> This is a non-reboot update

### Security Fixes

* curl updated to 7.77.0, fixing
  [CVE-2021-22901](https://curl.se/docs/CVE-2021-22901.html),
  [CVE-2021-22898](https://curl.se/docs/CVE-2021-22898.html),
  [CVE-2021-22897](https://curl.se/docs/CVE-2021-22897.html)

<br>

---

## r151038c (2021-05-18)
Weekly release for w/c 17th of May 2021.
> This is a non-reboot update

### Security Fixes

* libxml2 updated to 2.9.12, fixing
  [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541).

### Other Changes

* A problem that could result in a newly built non-global zone having no
  functioning system log service has been resolved.

* If the global zone is using the rsyslog system logger, newly built non-global
  zones will now be configured to use the same system log service.

<br>

---

Stable and Long-Term-Supported (LTS) Release, 3rd of May 2021

`uname -a` shows `omnios-r151038-adeb0c00cf`

r151038 release repository: https://pkg.omnios.org/r151038/core

## Upgrade Notes

Before upgrading, please ensure that your `package/pkg` package is up-to-date
by running `pkg update pkg`. The `pkg` software was recently updated for all
supported releases (r151030, r151032 and r151034) to properly handle
conditional dependencies which are more widely used in r151036. The new `pkg`
also has additional diagnostic output to help troubleshoot package updates.

The default `python` mediator version is now set to 3 instead of 2; this means
that `/usr/bin/python` is now Python 3. To restore the previous configuration,
change the mediator version - `pkg set-mediator -V 2 python`. Alternatively,
the `/usr/bin/python2` link continues to point at Python 2.

OpenJDK in OmniOS no longer enables the TLSv1.0 or TLSv1.1 protocols by default.

OpenSSH in OmniOS no longer provides support for GSSAPI key exchange. If you
require this feature, please [let us know](https://omnios.org/about/contact).

Upgrades are supported from the r151030, r151032, r151034 and r151036 releases.
If upgrading from before r151036, also refer to the following documents:

 * [Release notes for r151032](https://github.com/omniosorg/omnios-build/blob/r151032/doc/ReleaseNotes.md#upgrade-notes)
 * [Release notes for r151034](https://github.com/omniosorg/omnios-build/blob/r151034/doc/ReleaseNotes.md#upgrade-notes)
 * [Release notes for r151036](https://github.com/omniosorg/omnios-build/blob/r151036/doc/ReleaseNotes.md#upgrade-notes)

## New features since r151036

### System Features

* ZFS has gained support for persistent L2ARC. This is automatically enabled
  for all layer-2 ARC devices.

* Support for one-time-boot to a new boot environment, with the
  `beadm activate -t` option. After rebooting the new boot environment,
  a subsequent reboot, crash or power cycle will revert to the original.

* System support for NVMe Hotplug.

* Userland packages are now built with extended protection against stack
  overflow bugs using the Stack Smashing Protector (SSP) compiler feature.

* The legacy OpenSSL 1.0 library is now shipped with weak ciphers disabled
  in order to protect against known security vulnerabilities.

* A number of improvements to the way that memory pages are scanned and
  paged out during low memory conditions have been incorporated in this
  release.

* The boot loader now has better support for multiple consoles, and initial
  output and menus will be displayed on each.

* The package manager has gained a new `pkg autoremove` command and others.
  See below for more information.

* A number of improvements and bug fixes to the in-kernel SMB/CIFS file
  sharing service have been integrated.

* A number of packages have been recategorised as `optional` which means that
  they are part of the default system installation, but can be removed if
  not required. The list of optional packages can be viewed using:
  ```
  pkg list -R
  ```
  and the optional system packages will show an `S` in the flags column.
  > If an optional package is removed from the global zone, then the package
  > will no longer be installed by default into any newly created non-global
  > zones.

* The system boot banner has been updated.

### Commands and Command Options

* The system shell, `/bin/sh` and `/bin/ksh` has been upgraded to _ksh93u+_.
  This fixes a number of bugs and improves standards compliance.

* Python has been upgraded to Python 3.9.

* The new `developer/exuberant-ctags` package is available, delivering a
  more capable version of `/usr/bin/ctags`. This is not installed by default.

* The `roleauth` user attribute has been added. This makes it possible to
  specify which password is required to assume a role - the password from
  the role account or the assuming user's password. See
  [user_attr(4)](https://man.omnios.org/user_attr.4) for more
  details.

* Command line completion information for the `bash` shell has been updated.

* [beadm(1M)](https://man.omnios.org/beadm.1m) has gained the `-t` and `-T`
  options for activating and de-activating one-time boot environments.

* [pkg(1)](https://man.omnios.org/pkg.1) has gained a number of new commands
  and options. Refer to _Package Management_ below.

* The [bhhwcompat(1M)](https://man.omnios.org/bhhwcompat.1m) utility has been
  re-introduced to determine whether a system supports the bhyve hypervisor.

### Libraries and Library Functions

* Support for the `IP_RECVTOS` socket option has been added.

* The [upanic(2)](https://man.omnios.org/upanic.2) system call
  has been added to terminate a process and generate a core file. This is
  an illumos-specific alternative to the `abort(3)` call which is used by
  the native stack protector. Refer to the manual page for more details.

* The [getgrouplist(3C)](https://man.omnios.org/getgrouplist.3c)
  function has been added to the C library.

* The [getcwd(3C)](https://man.omnios.org/getcwd.3c) function has been updated
  to support passing _0_ as the _size_ parameter. This improves support for
  running third party software that assumes this non-standard extension is
  available.

### Zones

* The [signalfd(3C)](https://man.omnios.org/signalfd.3c)
  function now works in non-global zones.

* The zone boot sequence has been streamlined so that zones boot faster,
  particularly when several are starting in parallel after system boot.

* The `max-processes` zone resource control is now documented and is set
  to match any configured `max-lwps` control if not explicitly set.
  See [zonecfg(1M)](https://man.omnios.org/zonecfg.1m).

* `illumos` branded zones now support boot environments; these are fully
  independant of the global zone's boot environments. To take advantage of
  this, any existing illumos branded zones will need to be re-installed,
  otherwise they will continue without BE support. The easiest way to do
  this is to snapshot and `zfs send` the old zone root, and then re-install
  it, for example, for an illumos zone called `zone1`:
  ```
  # zoneadm -z zone1 shutdown
  # zfs snapshot rpool/zones/zone1/root@migrate
  # zfs send rpool/zones/zone1/root@migrate > /tmp/zone1.zfs
  # zoneadm -z zone1 uninstall
  # zoneadm -z zone1 install -s /tmp/zone1.zfs
  # zoneadm -z zone1 boot
  ```

### LX zones

* The `/proc/sys/kernel/random/uuid` file is now available in an lx zone.
  Each read of this file returns a type 4 UUID as a string. The format of
  the ID returned from `/proc/sys/kernel/random/boot_id` is now a valid
  type 4 UUID.

* Some processes which relied on the system `RLIMIT_NPROC` parameter could
  crash on startup. This has been resolved.

* Emulation of the Linux-specific feature that allows a symbolic link to be
  opened as a file has been improved, resolving problems experienced with some
  software in lx zones.

### Bhyve

* Many improvements from upstream illumos and FreeBSD.

* Improved VNC support for the built-in framebuffer console. This now works
  properly with more clients, including native MacOS screen sharing.

* Improved emulated NVMe devices.

* Support for specifying pass-through devices in the zone configuration.
  See [bhyve(5)](https://man.omnios.org/bhyve.5) for more information.

* Support for attaching a virtio random number generator device through the
  `rng` attribute in the zone configuration
  (see [bhyve(5)](https://man.omnios.org/bhyve.5)).

* Improved automatic memory reclamation from the ZFS ARC when necessary to
  start a new bhyve virtual machine.

### ZFS

* Support for persistent L2ARC.

* Support for one-time boot environment activation.

### Package Management

* The `pkg list` command has gained some new flags:
  * `-r` shows removable packages. That is, those which have no dependants
    and could be removed if desired.
  * `-R` extends this by also showing the removable system packages, but with
    an `S` showing in the flags column.
  * `-m` shows packages which were manually installed, that is explicitly
    provided as arguments to a `pkg install` command. Manually installed
    packages show an `m` in the flags column.
  * `-M` shows the packages were **not** manually installed, that is those
    which are part of the default system or were automatically installed as
    dependencies for another package.

* A new `pkg autoremove` command has been added which automatically uninstalls
  any removable packages which were not manually installed (i.e. those packages
  listed with `pkg list -rM`). This command supports the same options as
  _uninstall_ - in particular, `pkg autoremove -nv` shows what would be done
  without making any changes to the system.

> Note that when upgrading to r151038 from an earlier release, the list of
> packages which were manually installed will be incomplete.
> This can be corrected by reviewing the output of `pkg list -rM` and using
> the `pkg flag -m` command to flag any packages that should not be considered
> by autoremove.

* Packages can be flagged as manually installed using the new `pkg flag -m`
  command. There is a corresponding `pkg flag -M` command which removes
  the flag.

* `pkg` has gained the `--temp-be-activate` option to use one-time boot
  environment activation when an update requires a new BE or one has been
  requested.

* A new system property has been added to make `--temp-be-activate` the default
  behaviour when a new boot environment is created as part of a package
  operation. This can be set with `pkg set-property temp-be-activation=True`.
  This option is useful for systems where console access is not readily
  available, since a power cycle will automatically revert to the previous
  boot environment.

* `pkg clean` can be used to manually remove cached downloaded content.
  This is useful when the _flush-content-cache-on-success_ image property
  has been set to _False_.

### Hardware Support

* Improved support for AMD Zen 3 CPUs.

* Added support for the Hygon Dhyana Family of processors.

* The X710 10GBaseT\*L Family if parts is supported.

* Support for chipset and CPU sensors has been extended.

* There have been several improvements in support for creating network link
  aggregations with a variety of network cards.

### Installer

* Support for searching for installation ZFS images on USB flash drives.
  This enables OmniOS to be installed from third party tools such as
  [Ventoy](https://github.com/ventoy/Ventoy).

* The hybrid _.iso_ image has been improved and works on more systems.
  If booting from a USB flash drive, this hybrid image should be used instead
  of the _.usb-dd_ file if possible.

* The [bhhwcompat(1M)](https://man.omnios.org/bhhwcompat.1m) utility is now
  available from the installer shell. This checks if the system supports
  the bhyve hypervisor.

### Virtualisation

* The `azure-agent` package has been upgraded and extended. It now has the
  ability to create users and provision SSH keys automatically during
  virtual machine deployment in Azure.

* A disk image suitable for using in Azure is available alongside this release.
  See <https://omnios.org/article/azure-image> for more information on how
  this can be used.

### Developer Features

* Almost all system binaries and libraries are now delivered with
  embedded Compact Type Format (CTF) debugging data and with the symbol
  table present. This increases observability by providing type data to
  `mdb`, `dtrace` and the kernel.

* A native stack smashing protection (SSP) implementation has been added to
  the standard C library (_libc.so_). The gcc compiler packages have been
  updated to use this implementation when building code with gcc's
  `-fstack-protector` option.

* The `-zassert-deflib` linker option did not work when building 64-bit
  objects; this has been corrected.

* The Compact Type Format (CTF) utilities delivered with the
  developer/build/onbld package have been updated and are able to more easily
  convert data in larger and more complex objects.

* The illumos `make` command now sets predefined macros to better values.
  For example, the `CC` variable is now `gcc` by default.
  See [make(1)](https://man.omnios.org/make.1#Predefined_Macros) for more
  details.

* The python package now includes the `pip` module, which can be invoked  via
  `python -mpip`. Python modules delivered via `pkg` cannot be uninstalled or
  replaced using pip.

* The perl _Sun::Solaris::Privilege_ and _Sun::Solaris::Ucred_ modules are now
  available in the `runtime/perl/module/sun-solaris` package. These allow
  perl programs to easily access the illumos privilege and user credentials
  features. See [privilege(3perl)](https://man.omnios.org/privilege.3perl)
  and [ucred(3perl)](https://man.omnios.org/ucred.3perl).

* OpenJDK now disables versions 1.0 and 1.1 of the TLS protocol by default.
  If you encounter issues, you can re-enable the versions by removing "TLSv1"
  and/or "TLSv1.1" from the `jdk.tls.disabledAlgorithms` security property in
  the `java.security` configuration file.

### Deprecated features

* OpenSSH in OmniOS no longer provides support for GSSAPI key exchange.

* Python 2 is now end-of-life and will not receive any further updates. The
  `python-27` package is still available for backwards compatibility but will
  be maintained only on a best-efforts basis. `/usr/bin/python` points to
  Python 3 by default. Use `/usr/bin/python2` to start the legacy version,
  or change the `python` mediator version.

* OpenSSL 1.0.x is deprecated and reached end-of-support at the end of 2019.
  OmniOS has completely transitioned to OpenSSL 1.1.1 but retains the OpenSSL
  1.0.2 libraries for backwards compatibility. The 1.0.2 libraries are
  maintained solely on a best-efforts basis.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| archiver/gnu-tar | 1.32 | 1.34
| compress/lz4 | 1.9.2 | 1.9.3
| compress/zstd | 1.4.5 | 1.4.9
| data/iso-codes | 4.5.0 | 4.6.0
| database/sqlite-3 | 3.33.0 | 3.35.5
| developer/build/autoconf | 2.69 | 2.71
| developer/build/automake | 1.16.2 | 1.16.3
| **developer/exuberant-ctags** | _New_ | 5.8
| developer/gnu-binutils | 2.35.1 | 2.36.1
| developer/parser/bison | 3.7.2 | 3.7.6
| developer/versioning/git | 2.28.1 | 2.31.1
| developer/versioning/mercurial | 5.5.1 | 5.7.1
| **diagnostic/pci** | _New_ | 0.5.11
| **driver/cpu/amd/zen** | _New_ | 0.5.11
| **driver/developer/amd/zen** | _New_ | 0.5.11
| file/gnu-findutils | 4.7.0 | 4.8.0
| ~~incorporation/jeos/illumos-gate~~ | 11 | _Removed_
| ~~incorporation/jeos/omnios-userland~~ | 11 | _Removed_
| library/c++/sigcpp | 3.0.4 | 3.0.6
| library/expat | 2.2.9 | 2.3.0
| library/glib2 | 2.66.1 | 2.68.1
| library/gmp | 6.2.0 | 6.2.1
| library/mpc | 1.2.0 | 1.2.1
| library/nghttp2 | 1.41.0 | 1.43.0
| library/nspr | 4.29 | 4.30
| library/nspr/header-nspr | 4.29 | 4.30
| library/pcre2 | 10.35 | 10.36
| library/python-3/asn1crypto-3x | 1.4.0 | 1.4.0
| library/python-3/attrs-3x | 20.2.0 | 20.3.0
| library/python-3/cffi-3x | 1.14.3 | 1.14.5
| library/python-3/cheroot-3x | 8.4.5 | 8.5.2
| library/python-3/coverage-3x | 5.3 | 5.5
| library/python-3/cryptography-3x | 3.1.1 | 3.4.6
| library/python-3/idna-3x | 2.10 | 3.1
| ~~library/python-3/importlib-metadata-37~~ | 2.0.0 | _Removed_
| library/python-3/jsonrpclib-3x | 0.4.1 | 0.4.2
| library/python-3/mako-3x | 1.1.3 | 1.1.4
| library/python-3/meson-3x | 0.55.3 | 0.57.1
| library/python-3/more-itertools-3x | 8.5.0 | 8.7.0
| **library/python-3/orjson-39** | _New_ | 3.5.1
| **library/python-3/pip-39** | _New_ | 21.0.1
| library/python-3/portend-3x | 2.6 | 2.7.1
| library/python-3/prettytable-3x | 0.7.2 | 2.1.0
| library/python-3/pycodestyle-3x | 2.6.0 | 2.7.0
| library/python-3/pyopenssl-3x | 19.1.0 | 20.0.1
| library/python-3/pytz-3x | 2020.1 | 2021.1
| library/python-3/rapidjson-3x | 0.9.1 | 1.0
| **library/python-3/semantic-version-39** | _New_ | 2.8.5
| library/python-3/setuptools-3x | 50.3.0 | 54.1.2
| **library/python-3/setuptools-rust-39** | _New_ | 0.12.1
| library/python-3/tempora-3x | 4.0.0 | 4.0.1
| **library/python-3/wcwidth-39** | _New_ | 0.2.5
| ~~library/python-3/zipp-37~~ | 3.2.0 | _Removed_
| library/readline | 8.0 | 8.1
| **library/security/openssl-10** | _New_ | 1.0.2.21
| **library/security/openssl-11** | _New_ | 1.1.1.11
| library/security/trousers | 0.3.14 | 0.3.15
| network/dns/bind | 9.11.23 | 9.16.13
| network/openssh | 8.4.1 | 8.5.1
| network/openssh-server | 8.4.1 | 8.5.1
| runtime/perl | 5.32.0 | 5.32.1
| ~~runtime/python-37~~ | 3.7.10 | _Removed_
| **runtime/python-39** | _New_ | 3.9.4
| security/sudo | 1.9.5.2 | 1.9.6.1
| service/network/ntpsec | 1.1.9 | 1.2.0
| shell/bash | 5.0.18 | 5.1.4
| **shell/ksh93** | _New_ | 93.21.1.20120801
| shell/tcsh | 6.22.2 | 6.22.3
| system/bhyve/firmware | 20200501 | 20210302
| system/cpuid | 1.7.6 | 1.8.0
| system/data/hardware-registry | 2020.9.15 | 2021.3.5
| system/data/zoneinfo | 2020.1 | 2021.1
| system/library/mozilla-nss | 3.57 | 3.63
| system/library/mozilla-nss/header-nss | 3.57 | 3.63
| system/library/pcap | 1.9.1 | 1.10.0
| system/microcode/intel | 20201118 | 20210216
| system/pciutils/pci.ids | 2.2.20200819 | 2.2.20210305
| system/rsyslog | 8.2008.0 | 8.2102.0
| system/test/fio | 3.23 | 3.26
| **system/test/ksh93** | _New_ | 0.5.11
| **system/test/libmlrpctest** | _New_ | 0.5.11
| system/virtualization/azure-agent | 2.2.46 | 2.2.54
| system/virtualization/open-vm-tools | 11.1.5 | 11.2.5
| terminal/tmux | 3.1.2 | 3.1.3
| text/gnu-grep | 3.5 | 3.6
| text/less | 551 | 563
| web/wget | 1.20.3 | 1.21.1

