<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151044

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
