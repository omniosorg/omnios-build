<a href="https://omniosce.org">
<img src="https://omniosce.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151028

## r151028au (2019-09-23)
Weekly release for w/c 23rd of September 2019.
> This is a non-reboot update

# Security Fixes

# Other Changes

<br>

---

## r151028as (2019-09-12)
Weekly release for w/c 9th of September 2019.
> This is a non-reboot update

# Security Fixes

* `openssl` updated to 1.1.0l/1.0.2t, fixing
  [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547),
  [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563)

* `curl` updated to 7.66.0, fixing
  [CVE-2019-5481](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5481),
  [CVE-2019-5482](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5482)

* `ca-bundle` updated, removing four expired root certificates.

# Other Changes

* Updated Mozilla NSS/NSPR to version 3.46/4.22

<br>

---

## r151028al (2019-07-22)
Weekly release for w/c 22nd of July 2019.
> This is a non-reboot update

# Security Fixes

* nss upgraded to 3.45, fixing
  [CVE-2019-11719](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11719),
  [CVE-2019-11729](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11729),
  [CVE-2019-11727](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11727)
  and several other bugs.

# Other changes

* nspr upgraded to 4.21

<br>

---

## r151028aj (2019-07-08)

# Security Fixes

* bzip2 upgraded to 1.0.7, fixing
  [CVE-2019-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12900)
  and several other bugs.

<br>

---

## r151028ah (2019-06-24)
Weekly release for w/c 24th of June 2019.
> This is a non-reboot update.

# Security Fixes

* Expat upgraded to 2.2.7 to fix denial-of-service vulnerability.

<br>

---

## r151028af (2019-06-11)
Weekly release for w/c 10th of June 2019.
> This is a non-reboot update.

# Security Fixes

* Curl upgraded to 7.65.1
  * [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435): Integer overflows in curl_url_set
  * [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436): tftp: use the current blksize for recvfrom()

* Vim patched against [CVE-2019-12735](https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md)

# Other changes

* Fix for package signing incompatibility with r151030 servers

<br>

---

## r151028ae (2019-06-03)
Weekly release for w/c 3rd of June 2019.
> This is a non-reboot update.

# Security Fixes

* OpenSSL updates to 1.1.0k/1.0.2s, fixing
  * [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559)
  * [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543)

<br>

---

## r151028ac (2019-05-22)
Weekly release for w/c 20th of May 2019.
> This update requires a reboot.

# Security Fixes

* Mitigations for a series of CPU side channel vulnerabilities that affect
  Intel CPUs. These are collectively known as multi-architectural data
  sampling (MDS) vulnerabilities and cover the following CVEs:
  * [CVE-2018-12126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12126)
  * [CVE-2018-12127](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12127)
  * [CVE-2018-12130](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12130)
  * [CVE-2019-11091](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11091)

  For more information, refer to the [Intel security advisory](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html)

* Intel CPU microcode has been updated to the 20190514 release.

# Other Changes

* New feature allowing hyperthreading to be disabled on a running system or
  at boot time. To disable on an active system use `psradm -aS` and to disable
  at every boot `echo smt_enabled=false > /boot/conf.d/smt`
  [illumos 11048](https://www.illumos.org/issues/11048)

* The `mdb -ke ::sec` command has been updated to cover the new MDS
  vulnerabilities.

* It is now possible to configure the desired behaviour in response to receipt
  of an NMI via a boot option in place of `/etc/system`. For example, to
  cause a panic, `echo nmi=panic > /boot/conf.d/nmi`. Other options are
  _kmdb_ and _ignore_ (the default).

* The `cpuid` utility has been updated to show whether the processor supports
  the new *MD\_CLEAR* feature (delivered via microcode update).

<br>

---

## r151028z (2019-04-29)
Weekly release for w/c 29th of April 2019.
> This is a non-reboot update.

# Security fixes

* Update to `pkg`, fixing
  [CVE-2019-2704](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-2704)
*  `wget` updated to 1.20.3, fixing
  [CVE-2019-5953](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5953)

# Other changes

* `perl` updated to 5.28.2

<br>

---

## r151028v (2019-04-01)
Weekly release for w/c 1st of April 2019.
> This update requires a reboot.

# Security fixes

* Access problem with SMB server -
  [illumos issue 10506](https://illumos.org/issues/10506) -
  [CVE-2019-9579](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9579)
* dls\_unbind() needs better checking -
  [illumos issue 10543](https://illumos.org/issues/10543)

<br>

---

## r151028u (2019-03-27)
Weekly release for w/c 25th of March 2019.
> This is a non-reboot update.

# Changes

* Update the `lipkg` and `sparse` brands to fix a problem where openssh was
  not being installed in new zones.

<br>

---

## r151028t (2019-03-19)
Weekly release for w/c 18th of March 2019.
> This is a non-reboot update.

# Security fixes

* The `network/ntp` package has been updated to version 4.2.8p13 addressing
  [one security vulnerability](http://support.ntp.org/bin/view/Main/SecurityNotice#Recent_Vulnerabilities).

# Other changes

* A new `system/network/cdp` package is available that provides a service
  that uses Cisco Discovery Protocol to advertise the local host to
  neighbouring switches, and to maintain a table of neighbours that can
  be viewed via `cdpadm show nei`. This new service was contributed by
  [Prominic.NET](https://prominic.net).

<br>

---

## r151028r (2019-03-06)
Weekly release for w/c 4th of March 2019.
> This update requires a reboot.

# Security fixes

* A system crash can occur if a corrupt/malicious ELF object is executed;
  [illumos issue 10505](https://illumos.org/issues/10505).
* Fix for denial of service (requires access to a non-global zone in order
  to exploit); [illumos issue 10472](https://illumos.org/issues/10472).
* `python2` updated to 2.7.16 fixing
  [CVE-2019-5010](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5010),
  [CVE-2013-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-1752),
  [CVE-2018-14647](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14647)

<br>

---

## r151028q (2019-02-27)
Weekly release for w/c 25th of February 2019.
> This is a non-reboot update.

# Security fixes

* `openssl` updated to 1.0.2r/1.1.1b fixing
  [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559)

* `vim` updated to 8.1.978 fixing
  [CVE-2018-20786](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20786)

<br>

---

## r151028o (2019-02-11)
Weekly release for w/c 11th of February 2019.
> This is a non-reboot update.

### Security fixes

* `curl` update to 7.64.0 fixing
  [CVE-2018-16890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890),
  [CVE-2019-3822](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822),
  [CVE-2019-3823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823).

* `mercurial` updated to 4.9 addressing a security issue regarding symlinks and
  subrepository checkout.

### Other fixes

* Fix problem where `pkg` could take a long time to generate a uuid by
  installing the `developer/object-file` package by default.

<br>

---

## r151028l (2019-01-21)
Weekly release for w/c 21st of January 2019.
> This is a non-reboot update.

### Security fixes

* `ntpsec` updated to version 1.1.3 fixing
  [CVE-2019-6442](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6442),
  [CVE-2019-6443](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6443),
  [CVE-2019-6444](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6444),
  [CVE-2019-6445](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6445)

* `openssh` updated to fix
  [CVE-2018-20685](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20685),
  [CVE-2019-6109](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6109),
  [CVE-2019-6110](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6110),
  [CVE-2019-6111](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6111)

### Other Fixes

* Update to `openssh` to fix a problem that could cause occasional terminal
  hangs.

<br>

---

## r151028j (2019-01-07)
Weekly release for w/c 7th of January 2019.
> This update requires a reboot.

### Security fixes

* Update GNU tar to 1.31, fixing
  [CVE-2018-20482](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20482)
* libxml2 updated to 2.9.9 -
  [CVE-2018-9251](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-9251),
  [CVE-2018-14404](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14404),
  [CVE-2018-14567](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14567)

### Updates

* Fix for ZFS performance degredation with some pools due frequent metaslab
  unload and re-load - [OS-7151](https://smartos.org/bugview/OS-7151)

* bhyve updates including disk performance improvements.

* Performance improvement in zone resource tracking on machines with
  many CPUs - [illumos 9936](https://illumos.org/issues/9936)

### Fixes

* Workarounds for some hard disks and SSDs with buggy firmware relating to
  power conditions.

* LX: fix to openat() in order to support newer _systemd_.
  - [see #331](https://github.com/omniosorg/illumos-omnios/issues/331)

* bhyve/kvm brands did not support more than one disk when configured via
  `zonecfg`

### Features

* Added `library/security/openssl/preview` to allow installation and testing
  of OpenSSL 1.1.1 -
  see [blog post](https://omniosce.org/article/openssl-preview)

<br>

----

## r151028f (2018-12-10)
Weekly release for w/c 10th of December 2018.
> This update requires a reboot (if `system/bhyve` is installed).

### Security fixes

* `bhyve` updated to fix -
  [CVE-2018-17160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17160)

* `nss` updated to fix -
  [CVE-2018-12404](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12404)

### Other Changes

* `web/ca-bundle` updated

<br>

----

## r151028e (2018-12-03)
Weekly release for w/c 3rd of December 2018.
> This is a non-reboot update.

### Security fixes

* `perl` updated to 5.28.1 -
  [CVE-2018-18311](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-18311)
  [CVE-2018-18312](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-18312)

* `nss` updated to 3.40.1 -
  [CVE-2018-12404](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12404)

<br>

----

## r151028d (2018-11-26)
Weekly release for w/c 26th of November 2018.
> This is a non-reboot update.

### Security fixes

* `git` updated to 2.19.2
  [CVE-2018-19486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-19486)

<br>

----

## r151028c (2018-11-22)
Weekly release for w/c 19th of November 2018.
> This is a non-reboot update.

### Security fixes

* openssl updated to 1.1.0j/1.0.2q
  [CVE-2018-0734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0734)
  [CVE-2018-5407](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-5407)
* openjdk updated to 1.7.0_201-b00

### Other Changes

* `pkg` updated to fix a problem that could occur when removing some packages.
* `system/header` updated to add missing header file
* `openssh` updated to work around a VMware bug in handling packets with
  certain QoS options set - see <https://communities.vmware.com/thread/590825>

<br>

----

## r151028b (2018-11-12)
Weekly release for w/c 12th of November 2018.
> This is a non-reboot update.

### Updates

* `ipmitool` updated to fix crash when doing AES encryption with lanplus;
* Updated illumos-gate build templates in `developer/build/onbld`;
* `developer/illumos-tools` updated to include `python-35` and `gcc7`;
* Installer updated to set default route without requiring an additional
  reboot.

<br>

----

Stable Release, 5th of November 2018

`uname -a` shows `omnios-r151028-d3d0427bff`

r151028 release repository: https://pkg.omniosce.org/r151028/core

## Upgrade Notes

* Several legacy SunSSH compatibility options for OpenSSH were deprecated
  with release r151026 and have now been removed. **Please ensure that the
  old directives are removed from your configuration files prior to upgrading
  to this release.**
  Refer to <https://omniosce.org/info/sunssh> for more details.

* The format of package version numbers has changed slightly with this
  release. For example, the terminal/screen package in r151026 looked like
  this:

    _pkg://omnios/terminal/screen@4.6.2,5.11-**0.151026**:20180420T095117Z_

  and as of r151028, the ordering of the branch version has been changed

    _pkg://omnios/terminal/screen@4.6.2,5.11-**151028.0**:20181101T113741Z_

  This allows for better use of the branch version for future package updates.

## New features since r151026

### System Features

* The bhyve hypervisor is much improved and generally suitable for production
  use.

* It is possible to run both KVM and bhyve virtual machines on the same
  physical host.

* bhyve and kvm branded zones are now available. Our website contains
  [documentation](https://omniosce.org/info/bhyve_kvm_brand) on how to make
  use of these.

* The default openssl version is 1.1 and OmniOS itself is now built against
  that version. The system openssl version can be changed back to 1.0.2 via
  the version property of the _openssl_ mediator, i.e.
```
      pkg set-mediator -V 1.0 openssl
```
  To compile software against version 1.0 reglardless of the mediator setting,
  use

  `CFLAGS=-I/usr/ssl-1.0/include LDFLAGS=-L/usr/ssl-1.0/lib/amd64`

  (drop the trailing `/amd64` if building 32-bit software)

* openssh has been upgraded to 7.8p1. This version drops support for some
  very old SSH implementations (pre-2001);
  refer to the [release notes](https://www.openssh.com/txt/release-7.7)
  for more details. Several legacy SunSSH compatibility options for OpenSSH
  that were deprecated in release r151026 have been removed;
  see *Deprecated features* below.

* `beadm list` is now significantly faster on systems with many snapshots.
  This change has also improved the speed of zone boot and `pkg` operations on
  such systems.

* ZFS support for mounting filesystems in parallel. This significantly
  improves boot time for systems with many filesystems.

* ZFS support for initialising unused blocks with a pattern -
  [see blog post](https://omniosce.org/article/hole-punching)

* Boot archives are now created in _cpio_ format by default. This makes
  for significantly quicker boot archive creation when upgrading.

* Several 32-bit only packages have been moved to 64-bit only.

* OmniOS userland is now built with gcc version 7.

### Commands and Command Options

* `smbios` can now display more information including that relating to
   power-supply-units (PSUs), cooling devices and voltage and temperature
   probes.

* New `cxgbetool` command for managing Chelsio T4/5/6 NICs.

* The `sasinfo` command now support 12Gb/s SAS.

* `getent` can now list attribute databases such as *auth_attr*. See the
  getent(1m) manpage for more details.

* New `pptadm` command for managing PCI device pass-through to bhyve virtual
  machines.

### LX zones

* Support for the Linux auditing subsystem.

* Support for newer IP utilities.

* Many other fixes and compatibility updates from Joyent.

### Package Management

* Automatic naming is now supported for boot environments created during
  package operations. This is configured via the new `auto-be-name` image
  property which specifies a template for the new name; see the man page for
  the `pkg` command for more information and examples. The default property
  value is `omnios-r%r` which results in BE names such as `omnios-r151028x`:

  ```
  # pkg set-property auto-be-name omnios-r%r
  # pkg update
  ...
  A clone of r151028 exists and has been updated and activated.
  On the next boot the Boot Environment omnios-r151028x will be
  mounted on '/'.  Reboot when ready to switch to this updated BE.
  ```

* The `pkg set-publisher` command now accepts the `-r` option to indicate
  that the changes should be applied recursively to linked child zones.
  This makes upgrades easier and our
  [upgrade guide](https://omniosce.org/upgrade) has been updated to make use
  of this new feature.

* The `pkgrecv` command now accepts the `--mog-file` option to allow
  transforms to be applied during package transfer.

* New `--no-network-cache` global option to force cache bypass headers to
  be added to network requests.

* New `nochild` publisher property to allow omission of GZ publisher in
  linked zones, see the _pkg(1)_ man page for more information.

* New `pkgrepo diff` command to compare repositories.

* New `preserve=install-only` option for package manifests, see _pkg(5)_ for
  more details.

* `pkg verify` can now produce parsable JSON output via the `--parsable 0`
  parameter.

* `pkg verify` can now report on unpackaged files via `--unpackaged` and
  `--unpackaged-only`.

* The `release/name` package version now reflects the OmniOS release name
  in its branch revision, for example
  _pkg://omnios/release/name@0.5.11-**151028.28**:20180905T084129Z_
  would correspond to `r151028ab`.

### Hardware Support

* Support for Emulex 31000/32000-based Fibrechannel cards.

* Support for ATTO Celerity FC-162E Gen 5 and Celerity FC-162P Gen 6
  Fibrechannel cards.

* Support for QLogic 16Gb/s Gen5/6 fibrechannel cards.

* Support for QLogic QL41000/45000 series devices.

* Support for NVMe 1.3 devices.

* Fix for SMB access to some HP scanner models.

### Installer

* The installer has been updated to allow selection of the shell to be used
  for a user created via the post-installation configuration menu.

* The `/etc/inet/hosts` file is now populated based on options selected
  in the post-installation configuration menu.

* When creating an initial user via the post-installation configuration menu
  the user's home directory is now placed on a boot-environment independent
  dataset and the _autofs_ automounter is disabled.

* The installer is now able to force 4k or 8k alignment on the root pool
  regardless of the underlying storage. Previously only 4k was available
  and this did not work for NVMe or virtual disks.

### Developer Features

* GCC version 8 is now available - pkg install developer/gcc8 - and can be
  found in /opt/gcc-8. Details of the changes in GCC 8 can be found on the
  [gcc web site](https://gcc.gnu.org/gcc-8/changes.html).

* The shipped gcc7 and gcc8 compilers will now never honour the
  `-fomit-frame-pointer` directive resulting in binaries which are easier to
  debug.

* The default version of OpenSSL is now 1.1. See *System Features* above
  for more information.

* Python version 3 has been added to the core system; it is not installed
  by default in this release. All python components will be moved over to
  python 3 in the next release in preparation for the python 2 end-of-life.

* Perl has been upgraded to 5.28.

* sqlite3 is now built with support for additional column metadata API
  functions.

* Some internet address manipulation functions functions have been moved from
  libsocket/nsl to libc.

* The `memset_s(3C)` function is now available.

* New `system/library/gfortran-runtime` package to deliver the runtime
  libraries required to run fortran programs.

* Packaged binaries which previously had been fully stripped now include
  at least the symbol table.

### Deprecated features

* GCC version 6 has been removed; however, if it is already installed on a
  system which is upgraded, then it is left in-place.

* The Sun Availability Suite has been removed.

* Several legacy SunSSH compatibility options for OpenSSH were deprecated
  with release r151026 and have now been removed. Please ensure that the
  old directives are removed from your configuration files prior to upgrading
  to this release. Refer to
  <https://omniosce.org/info/sunssh> for more details.

* Python 2 is deprecated and will become unmaintained starting with the next
  OmniOS release. `/usr/bin/python` is now a mediated link that points to
  python2 by default.

* The java-based Amazon EC2 API tools are deprecated and have been removed;
  however, if already installed on a system which is upgraded, then they are
  left in-place. The recommended replacement is the new AWS command-line
  interface which can be installed as follows:
  ```
  # pkg install python-35
  # python3 -m ensurepip
  # pip3 install --upgrade pip
  # pip3 install awscli --upgrade
  # aws --version
  ```

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| compress/xz | 5.2.3 | 5.2.4
| data/iso-codes | 3.77 | 4.1
| database/sqlite-3 | 3.23.1 | 3.25.2
| developer/acpi/compiler | 20180313 | 20180810
| developer/bmake | 20180222 | 20180512
| ~~developer/gcc6~~ | 6.4.0 | _Removed_
| ~~developer/gcc6/libgmp-gcc6~~ | 6.1.2 | _Removed_
| ~~developer/gcc6/libmpc-gcc6~~ | 1.0.3 | _Removed_
| ~~developer/gcc6/libmpfr-gcc6~~ | 3.1.5 | _Removed_
| **developer/gcc8** | _New_ | 8.2.0
| developer/gnu-binutils | 2.30 | 2.31.1
| developer/java/jdk | 1.7.0.171.2 | 1.7.0.191.2
| developer/parser/bison | 3.0.4 | 3.1
| developer/versioning/git | 2.17.2 | 2.19.1
| developer/versioning/mercurial | 4.5.3 | 4.7.2
| **driver/network/qede** | _New_ | 0.5.11
| ~~driver/storage/sv~~ | 0.5.11 | _Removed_
| editor/vim | 8.0.586 | 8.1
| file/gnu-coreutils | 8.29 | 8.30
| library/c++/sigcpp | 2.99.10 | 2.99.11
| library/expat | 2.2.5 | 2.2.6
| library/glib2 | 2.56.0 | 2.58.1
| library/libidn | 1.34 | 1.35
| library/ncurses | 6.1.20180428 | 6.1.20180923
| library/nghttp2 | 1.31.1 | 1.33.0
| library/nspr | 4.19 | 4.20
| library/nspr/header-nspr | 4.19 | 4.20
| library/python-2/cheroot-27 | 6.0.0 | 6.5.2
| library/python-2/cherrypy-27 | 14.0.1 | 17.3.0
| **library/python-2/contextlib2-27** | _New_ | 0.5.5
| library/python-2/cryptography-27 | 2.2.2 | 2.3.1
| **library/python-2/functools_lru_cache-27** | _New_ | 1.5
| library/python-2/idna-27 | 2.6 | 2.7
| library/python-2/ipaddress-27 | 1.0.19 | 1.0.22
| library/python-2/jaraco.classes-27 | 1.4.3 | 1.5
| **library/python-2/jaraco.functools-27** | _New_ | 1.20
| library/python-2/more-itertools-27 | 4.1.0 | 4.3.0
| library/python-2/portend-27 | 2.2 | 2.3
| **library/python-2/prettytable-27** | _New_ | 0.7.2
| **library/python-2/pycparser-27** | _New_ | 2.18
| library/python-2/pycurl-27 | 7.43.0.1 | 7.43.0.2
| library/python-2/pyopenssl-27 | 17.5.0 | 18.0.0
| library/python-2/pytz-27 | 2018.3 | 2018.5
| library/python-2/setuptools-27 | 39.0.1 | 40.2.0
| library/python-2/simplejson-27 | 3.13.2 | 3.16.0
| library/python-2/tempora-27 | 1.11 | 1.13
| **library/python-2/zc.lockfile-27** | _New_ | 1.3.0
| **library/python-3/asn1crypto-35** | _New_ | 0.24.0
| **library/python-3/cffi-35** | _New_ | 1.11.5
| **library/python-3/cheroot-35** | _New_ | 6.5.2
| **library/python-3/cherrypy-35** | _New_ | 18.0.1
| **library/python-3/contextlib2-35** | _New_ | 0.5.5
| **library/python-3/coverage-35** | _New_ | 4.5.1
| **library/python-3/cryptography-35** | _New_ | 2.3.1
| **library/python-3/functools_lru_cache-35** | _New_ | 1.5
| **library/python-3/idna-35** | _New_ | 2.7
| **library/python-3/jaraco.functools-35** | _New_ | 1.20
| **library/python-3/jsonrpclib-35** | _New_ | 0.3.1
| **library/python-3/jsonschema-35** | _New_ | 2.6.0
| **library/python-3/mako-35** | _New_ | 1.0.7
| **library/python-3/more-itertools-35** | _New_ | 4.3.0
| **library/python-3/pep8-35** | _New_ | 1.7.1
| **library/python-3/ply-35** | _New_ | 3.11
| **library/python-3/portend-35** | _New_ | 2.3
| **library/python-3/prettytable-35** | _New_ | 0.7.2
| **library/python-3/pybonjour-35** | _New_ | 1.1.1
| **library/python-3/pycparser-35** | _New_ | 2.18
| **library/python-3/pycurl-35** | _New_ | 7.43.0.2
| **library/python-3/pyopenssl-35** | _New_ | 18.0.0
| **library/python-3/pytz-35** | _New_ | 2018.5
| **library/python-3/setuptools-35** | _New_ | 40.2.0
| **library/python-3/simplejson-35** | _New_ | 3.16.0
| **library/python-3/six-35** | _New_ | 1.11.0
| **library/python-3/tempora-35** | _New_ | 1.13
| **library/python-3/zc.lockfile-35** | _New_ | 1.3.0
| library/security/openssl | 1.0.2.16 | 1.1.0.9
| library/unixodbc | 2.3.6 | 2.3.7
| network/dns/bind | 9.11.4 | 9.11.4.2
| network/openssh | 7.6.1 | 7.8.1
| network/openssh-server | 7.6.1 | 7.8.1
| **package/pkg-35** | _New_ | 0.5.11
| runtime/java | 1.7.0.171.2 | 1.7.0.191.2
| runtime/perl | 5.26.2 | 5.28.0
| runtime/perl-64 | 5.26.2 | 5.28.0
| runtime/perl/manual | 5.26.2 | 5.28.0
| **runtime/python-35** | _New_ | 3.5.6
| security/sudo | 1.8.22 | 1.8.25.1
| service/network/ntpsec | 1.1.0 | 1.1.2
| ~~service/storage/avs/cache-management~~ | 0.5.11 | _Removed_
| shell/bash | 4.4.19 | 4.4.23
| shell/zsh | 5.5.1 | 5.6.2
| ~~storage/avs~~ | 0.5.11 | _Removed_
| ~~storage/avs/point-in-time-copy~~ | 0.5.11 | _Removed_
| ~~storage/avs/remote-mirror~~ | 0.5.11 | _Removed_
| system/cpuid | 1.6.5 | 1.7.2
| system/data/zoneinfo | 2018.3 | 2018.7
| system/library/dbus | 1.12.6 | 1.12.10
| system/library/g++-runtime | 7 | 8
| system/library/gcc-runtime | 7 | 8
| system/library/gfortran-runtime | 7 | 8
| system/library/libdbus | 1.12.6 | 1.12.10
| system/library/mozilla-nss | 3.38 | 3.39
| system/library/mozilla-nss/header-nss | 3.38 | 3.39
| system/library/pcap | 1.8.1 | 1.9.0
| ~~system/management/ec2-api-tools~~ | 1.7.5.1 | _Removed_
| system/management/snmp/net-snmp | 5.7.3 | 5.8
| system/pciutils | 3.5.6 | 3.6.2
| system/pciutils/pci.ids | 2.2.20180208 | 2.2.20181025
| system/test/fio | 3.5 | 3.10
| system/virtualization/open-vm-tools | 10.2.5 | 10.3.0
| **system/zones/brand/bhyve** | _New_ | 0.5.11
| **system/zones/brand/kvm** | _New_ | 0.5.11
| terminal/tmux | 2.6 | 2.7
