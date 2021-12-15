<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151040

## r151040g (2021-12-17)
Weekly release for w/c 13th of December 2021.
> This update requires a reboot

### Security Fixes

* Strengthened LX-exclusive filesystems against races

### Bug Fixes

* `chrony` could fail to keep the system clock fully synchronised.

### Other Changes

* Openssl has been updated to version 1.1.1m

* Python has been updated to version 3.9.9

* The `ena` (AWS Elastic Network Adapter) network driver has been introduced.
  This allows OmniOS to be used on AWS Nitro instances giving access to
  instances with better network and disk performance, and with the option for
  a serial console.

* The `bhyve` hypervisor has been updated with the latest bits from
  illumos. The most notable improvement here is that guests can now make use
  of SMEP and SMAP processor features if the host supports them.

<br>

---

## r151040c (2021-11-17)
Weekly release for w/c 15th of November 2021.
> This is a non-reboot update

### Security Fixes

* `vim` has been updated to version 8.2.3582.

* `python` 3.9 has been updated to version 3.9.8

### Other Changes

* `openjdk17` would previously produce many warnings such as:
  `SIGSEGV happened inside stack but outside yellow and red zone.`

* Some 32-bit and legacy `net-snmp` libraries had missing symbols.

* `git-pbchk` has been updated to add a new module for verifying the format
  of package manifests.

<br>

---

Stable Release, 1st of November 2021

`uname -a` shows `omnios-r151040-92ae97307e`

r151040 release repository: https://pkg.omnios.org/r151040/core

## Upgrade Notes

Upgrades are supported from the r151038 release only. If upgrading from an
earlier version, upgrade in stages, referring to the table at
<https://omnios.org/upgrade>.

OpenSSH no longer accepts RSA signatures using SHA-1 by default. When
connecting to very old servers, it may be necessary to selectively re-enable
RSA/SHA1. The following stanza in ~/.ssh/config will enable RSA/SHA1 for a
single destination host:
  ```
  Host old-host
      HostkeyAlgorithms +ssh-rsa
  ```

## New features since r151038

### System Features

* OmniOS userland is now built with gcc version 11.

* Improved NVMe Hot-plug support.

* Support for promiscuous mode on _vioif_ network interfaces.

* Support for local [netgroups](https://man.omnios.org/netgroup.4).

* It is now possible to easily tune the kernel's `segkpsize` variable if
  required - see [eeprom(1M)](https://man.omnios.org/eeprom#OPERANDS).

* The `chrony` NTP package is now available as an alternative to `ntpsec`.
  New OmniOS installations will now have `chrony` installed by default.

* `openjdk17` is now available but will not automatically be the default system
  java implementation if installed. As for most components, the default openjdk
  version can be changed via a mediator:
  ```
  pkg set-mediator -V 17 openjdk
  ```
  > Thanks to Peter Tribble for doing the work to get OpenJDK17 running on
  > illumos.

* The experimental `cloud-init` package is included in this release and
  installable cloud images with this package pre-installed are available
  for download.

### Commands and Command Options

* The `nvmeadm list` command now supports options to enable parsable output.

* `prtvtoc` has been updated to include the sector count for MBR disks.

* The `passmgmt` utility has a new option to allow setting a user's password
  hash directly.

* `tftp` now supports command history and editing.

* `netstat` has been updated to better disambiguate between sockets and also
  to prevent showing duplicated data for UDP source and destination addresses.

* System components now support higher baud rates.

### Libraries and Library Functions

* The [memrchr(3C)](https://man.omnios.org/memrchr.3C) function has been added
  to the C library.

### Zones

* It is now possible to specify, in the brand, what happens when a zone's
  init process exits.

* A default set of security flags can be specified for a brand, and all zones
  of that brand will inherit these by default.

### LX zones

* Improved support for recent versions of _systemd_ and distributions which
  use it.

* The `/proc/sys/kernel/random/uuid` device has been added.

* `/proc/<pid>/fdinfo` is now available.

* systemd units that assert `NoNewPrivs`, no longer fail to start.

### Bhyve

* Many improvements from upstream illumos and FreeBSD.

* The bhyve hypervisor and the bhyve branded zone have received several updates
  that enable running with fewer resources and fewer privileges than before.

* bhyve VNC sessions are now named based on the underlying virtual machine name
  rather than always being called "bhyve".

* It is now possible to provide `cloud-init` configuration information to
  bhyve guests. This includes networking configuration and initial passwords/
  SSH keys. See cloud-init in [bhyve(5)](https://man.omnios.org/bhyve.5) for
  more information.

* bhyve now supports virtio-9p (aka VirtFS) filesystem sharing to guests.
  This is configured through the new `virtfs[N]` zone attribute as described
  in [bhyve(5)](https://man.omnios.org/bhyve.5).

* Additional network backends are available for bhyve, including an emulated
  `e1000` interface type.

* It is now possible to set memory aside for exclusive bhyve use using the
  `/usr/lib/rsrvrctl` command. This feature is not yet integrated into the
  OmniOS bhyve brand.

* bhyve guest metrics are now exposed as kstats.

### Package Management

* A new debug flag is available for troubleshooting connectivity and
  certificate issues. For example:
  ```
  pkg -Dcurlverbose=1 refresh
  ```

### Hardware Support

* The Time Stamp Counter (TSC) register calibration now occurs earlier in the
  boot process and a new plugin architecture allows for better calibration
  in different environments. Specific support has been added for VMware.

* Support for FTDI FT232H serial interfaces

### Developer Features

* Version 11 of the `gcc` compiler is available in this release and, if
  installed, becomes the system default version of gcc unless the mediator is
  manually changed.

* This release includes OpenSSL 3.0.0 which is mediated along with the other
  provided OpenSSL versions. The default value for the `openssl` mediator
  version is still 1.1 but will change to 3 in a future release. OpenSSL 3
  can be selected as the default system version by installing the package and
  changing the mediator, i.e.
  ```
  pkg install openssl-3
  pkg set-mediator -V 3 openssl
  ```
  To compile software against version 3 regardless of the mediator setting, set
  compile environment variable such as:
  ```
  CFLAGS=-I/usr/ssl-3/include LDFLAGS=-L/usr/ssl-3/lib/amd64
  ```

* `perl` has been updated to version 5.34

* There have been several improvements and fixes to core file generation.

* A utility is available as `/usr/lib/pci/pcieadm` that allows viewing
  the PCIe device tree and configuration space. This is not a stable interface
  and may change in subsequent releases.

* The Sun::Solaris::{Privilege,Ucred} perl modules have been re-introduced.

* The DLPI interface has been updated to provide new rx-only DLPI
  promiscuous modes - see
  [dlpi\_promiscon(3DLPI)](https://man.omnios.org/dlpi_promiscon).

### Deprecated features

* OpenSSH no longer accepts RSA signatures using SHA-1 by default.

* Version 9 of the `gcc` compiler has been removed in this release.

* OpenSSH in OmniOS no longer provides support for GSSAPI key exchange.
  This was removed in release r151038.

* Python 2 is now end-of-life and will not receive any further updates. The
  `python-27` package is still available for backwards compatibility but will
  be maintained only on a best-efforts basis.

* OpenSSL 1.0.x is deprecated and reached end-of-support at the end of 2019.
  OmniOS has completely transitioned to OpenSSL 1.1.1 and will begin to move
  to OpenSSL 3 in a future release, but retains the OpenSSL 1.0.2 libraries for
  backwards compatibility. The 1.0.2 libraries are maintained solely on a
  best-efforts basis.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| compress/gzip | 1.10 | 1.11
| compress/zstd | 1.4.9 | 1.5.0
| data/iso-codes | 4.6.0 | 4.7.0
| database/sqlite-3 | 3.35.5 | 3.36.0
| developer/build/automake | 1.16.3 | 1.16.4
| **developer/gcc11** | _New_ | 11.2.0
| ~~developer/gcc9~~ | 9.3.0 | _Removed_
| developer/gnu-binutils | 2.36.1 | 2.37
| developer/macro/gnu-m4 | 1.4.18 | 1.4.19
| developer/parser/bison | 3.7.6 | 3.8.2
| developer/versioning/git | 2.31.1 | 2.33.1
| developer/versioning/mercurial | 5.7.1 | 5.9.1
| library/c++/sigcpp | 3.0.6 | 3.0.7
| library/expat | 2.3.0 | 2.4.1
| library/glib2 | 2.68.1 | 2.68.4
| library/libffi | 3.3 | 3.4.2
| library/libidn | 1.36 | 1.38
| library/nghttp2 | 1.43.0 | 1.45.1
| library/nspr | 4.30 | 4.32
| library/nspr/header-nspr | 4.30 | 4.32
| library/pcre | 8.44 | 8.45
| library/pcre2 | 10.36 | 10.37
| library/python-3/attrs-39 | 20.3.0 | 21.2.0
| library/python-3/cffi-39 | 1.14.5 | 1.14.6
| library/python-3/cherrypy-39 | 18.6.0 | 18.6.1
| library/python-3/cryptography-39 | 3.4.6 | 3.4.8
| library/python-3/idna-39 | 3.1 | 3.2
| library/python-3/mako-39 | 1.1.4 | 1.1.5
| library/python-3/meson-39 | 0.57.1 | 0.59.1
| library/python-3/more-itertools-39 | 8.7.0 | 8.9.0
| library/python-3/orjson-39 | 3.5.1 | 3.6.3
| library/python-3/pip-39 | 21.0.1 | 21.2.4
| library/python-3/prettytable-39 | 2.1.0 | 2.2.0
| library/python-3/pycurl-39 | 7.43.0.6 | 7.44.1
| library/python-3/pyrsistent-39 | 0.17.3 | 0.18.0
| library/python-3/setuptools-39 | 54.1.2 | 58.0.4
| library/python-3/six-39 | 1.15.0 | 1.16.0
| library/python-3/tempora-39 | 4.0.1 | 4.1.1
| library/readline | 8.1 | 8.1.1
| **library/security/openssl-3** | _New_ | 3.0.0
| network/dns/bind | 9.16.13 | 9.16.21
| network/openssh | 8.5.1 | 8.8.1
| network/openssh-server | 8.5.1 | 8.8.1
| **runtime/java/openjdk17** | _New_ | 17.0.1.12
| runtime/perl | 5.32.1 | 5.34.0
| security/sudo | 1.9.6.1 | 1.9.8.2
| **service/network/chrony** | _New_ | 4.1
| service/network/ntpsec | 1.2.0 | 1.2.1
| shell/bash | 5.1.4 | 5.1.8
| shell/pipe-viewer | 1.6.6 | 1.6.20
| shell/tcsh | 6.22.3 | 6.22.4
| system/data/hardware-registry | 2021.6.2 | 2021.9.23
| system/data/urxvt-terminfo | 9.22 | 9.26
| system/data/zoneinfo | 2021.1 | 2021.5
| system/library/g++-runtime | 10 | 11
| system/library/gcc-runtime | 10 | 11
| system/library/gccgo-runtime | 10 | 11
| system/library/gfortran-runtime | 10 | 11
| system/library/gobjc-runtime | 10 | 11
| system/library/libdbus-glib | 0.110 | 0.112
| system/library/mozilla-nss | 3.63 | 3.70
| system/library/mozilla-nss/header-nss | 3.63 | 3.70
| system/library/pcap | 1.10.0 | 1.10.1
| **system/management/cloud-init** | _New_ | 21.3
| system/management/snmp/net-snmp | 5.9 | 5.9.1
| system/pciutils/pci.ids | 2.2.20210516 | 2.2.20210923
| system/rsyslog | 8.2102.0 | 8.2108.0
| system/test/fio | 3.26 | 3.28
| system/virtualization/open-vm-tools | 11.2.5 | 11.3.0
| terminal/tmux | 3.1.3 | 3.2
| text/gnu-diffutils | 3.7 | 3.8
| text/gnu-grep | 3.6 | 3.7
| text/less | 563 | 590
| web/wget | 1.21.1 | 1.21.2
