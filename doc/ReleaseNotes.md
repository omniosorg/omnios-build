<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151058

Stable Release, 4th of May 2026

`uname -a` shows `omnios-r151058-516f7694c9`

r151058 release repository: https://pkg.omnios.org/r151058/core

## Upgrade Notes

Upgrades are supported from the r151054 and r151056 releases only. If
upgrading from an earlier version, upgrade in stages, referring to the table
at <https://omnios.org/upgrade>.

## New features since r151056

### System Features

* IPv6 networking has gained a fast path implementation, similar to that
  already present for IPv4. This bypasses the data link services (DLS) layer
  for suitable traffic and improves throughput.

* The kernel MAC framework's softring polling code now correctly enforces its
  configured byte limit, and various accounting issues with fanout statistics
  and dual-stack TCP softrings have been corrected.

* Disabling hardware checksum offload via `dohwcksum` now also disables Large
  Segment Offload (LSO), preventing transmission failures on certain
  interfaces.

* The Intel IOMMU code is now more informative when it encounters unknown
  remapping structures, and the `immu-dmar-print` debug option works again.

### Commands and Command Options

* The [snoop(8)](https://man.omnios.org/snoop) utility has gained a new
  direction flag, along with corresponding incoming- and outgoing-only DLPI
  capture modes in the kernel. This makes it possible to reliably capture
  only inbound or only outbound traffic on an interface.

* [smbios(8)](https://man.omnios.org/smbios) now displays an
  endian-corrected form of the system UUID alongside the raw value, decodes
  Type 43 (TPM) records and decodes management device and component records.

* `pcieadm` has gained the ability to decode Data Object Exchange (DOE)
  capabilities, decode Virtio vendor-specific capabilities, display PCI
  configuration space at arbitrary offsets and manipulate device BARs.

* [nvmeadm(8)](https://man.omnios.org/nvmeadm) can now run vendor-specific
  commands, list namespace format information and supports several Sandisk
  vendor-specific commands and log pages, including telemetry log retrieval.
  The identify controller and features support has been updated for the
  NVMe 2.1 specification.

* [diskinfo(8)](https://man.omnios.org/diskinfo) now correctly displays
  location information for NVMe devices.

* [du(1)](https://man.omnios.org/du) handles large offsets correctly and
  the `-A` flag continues to report block counts rather than bytes.

* [pmap(1)](https://man.omnios.org/pmap) now supports the `-A` option when
  inspecting core files.

* [cp(1)](https://man.omnios.org/cp) and [mv(1)](https://man.omnios.org/mv)
  have gained a new `-n` option (do not overwrite an existing file), and
  [ln(1)](https://man.omnios.org/ln) has gained `-i` (interactive prompt
  before overwrite). The `-i` mode now also prompts before overwriting
  non-regular files.

### Libraries and Library Functions

* AES-GMAC sign and verify support has been added to PKCS#11, and the
  underlying kernel AES implementation now supports GMAC input through the
  standard mac interfaces.

* `atan2(0.0, -0.0)` no longer sets `errno` unexpectedly.

### Networking

* SMB 3.1.1 supports GMAC signing, with associated capability negotiation.
  This generally offers better performance than CMAC on modern hardware.
  The supporting cryptographic infrastructure has been reworked to use
  unified MAC functions and single-shot scatter/gather signing interfaces.

* SMB Active Directory join has been improved: the server now avoids using
  kadmin/setpw kpasswd when not required, falls back gracefully if
  `krb5.conf` is not configured and recovers cleanly from a domain re-join
  failure that previously left `smbd` in an inconsistent state.

* SMB2 asynchronous responses now more closely match the behaviour of
  Windows servers.

* The C$ administrative share now requires administrative privileges.

* Multiple fixes to the kernel NLM (Network Lock Manager) implementation
  resolve memory leaks, NULL pointer dereferences, port leaks that could
  cause NFS services to become unavailable, and a regression with macOS 14
  servers.

### ZFS

* `zfs change-key` can now atomically update user properties at the same
  time as it changes an encryption key, by way of new `-o user:prop=value`
  arguments. This eliminates a window in which the property and key could
  become out of sync.

* A bug in the ZFS Intent Log replay path could cause transactions to be
  replayed out of order following an unexpected system restart, potentially
  leading to data corruption. This has been fixed.

* The SMB server and ZFS getattr paths now avoid many redundant idmap
  lookups, improving performance for SMB workloads on ZFS.

### Bhyve

* Bhyve now supports transitional virtio devices, presenting both the
  legacy and modern (1.0+) virtio interfaces simultaneously. This improves
  guest compatibility, particularly for guests booted via modern UEFI
  firmware.

* The viona virtual NIC has gained virtio-net multi-queue support, and now
  supports asymmetric receive and transmit queue sizes. Bhyve advertises
  link speed and duplex to guests, and the corresponding illumos `vioif`
  driver consumes that information.

* The bhyve virtio-scsi device is now enabled, supports multiple backends,
  multiple targets and task management functions, and offers a USCSI
  backend.

* The kernel `vioscsi` driver has received numerous correctness fixes.

* Virtio devices in bhyve no longer expose unsupported MSI capabilities;
  only legacy and MSI-X interrupts are advertised.

* Various smaller bhyve improvements: better diagnostics for non-bootable
  VMs, the umouse device makes fewer assumptions about the request format,
  and the pci-uart device sets the correct subclass.

* Setting the `bootnext` attribute in a bhyve-branded zone no longer
  prevents the zone from booting.

### LX zones

* The emulated `/proc/self/coredump_filter` file is now provided.

### Hardware Support

* A new I2C and SMBus framework has been added to illumos, providing the
  `i2cnex` kernel driver, `libi2c.so.1` userland library and the
  [i2cadm(8)](https://man.omnios.org/i2cadm) administration tool.

* A new kernel GPIO framework provides the `kgpio`
  driver, `libxpio.so.1` library and the
  [gpioadm(8)](https://man.omnios.org/gpioadm) command, along with support
  for AMD GPIO controller attributes.

* New drivers built on these two frameworks include:
  * Intel SMBus Controllers (`pchsmbus(4D)` and `ismt(4D)`)
  * LTC4305/6 I2C Mux and GPIO
  * PCA954x family I2C multiplexers
  * PCA953x family I2C GPIO expanders
  * AT24C family I2C EEPROMs
  * DDR4 and DDR5 I2C SPD EEPROMs
  * TS511x DDR5 temperature sensors (integrated with ksensor)
  * LM75 family I2C temperature sensors
  * TMP43x family I2C temperature sensors

* A new EEPROM driver framework provides a standardised character device
  interface for EEPROM-class devices.

* Support has been added for the Intel E610 family of network interfaces
  via the `ixgbe` driver.

* The `ena` driver now attaches correctly on AWS Nitro v5/v6 instance
  types (such as the `m8a` family).

* The libsff values have been updated to reflect the latest SFF
  transceiver specifications.

* Support has been added for AMD Phoenix 2 processors in `amdzen(4D)`,
  and for Alder Lake-N SMBus device IDs.

* On Zen5 processors with sufficiently new microcode, the previously
  disabled `RDSEED` instruction is now re-enabled.

* The `asy(4D)` serial driver has gained better debugging facilities and
  is no longer overly chatty when ports are missing.

### Storage

* `scsi_vhci` now supports configuration of the load-balancing policy for
  individual logical units via [mpathadm(8)](https://man.omnios.org/mpathadm),
  rather than only globally.

* NVMe devices used as a system boot device no longer end up with only a
  single I/O queue, and are no longer reported as failed by ZFS when they
  return a queue-saturation error.

### Modular Debugger

* `mdb` has gained a new dcmd (`::pcie_fatal_errors`) for inspecting the
  source of a PCIe fatal error, to aid in diagnosing AER-reported failures.

### Boot Loader

* On UEFI, the loader now produces stack traces on panics and faults,
  no longer complains about missing block device handles, and several
  bugs in UEFI and the TSS setup have been resolved.

* IP fragment reassembly in the loader has been corrected.

* Systems which map the linear framebuffer above 32 bits no longer cause
  `dboot` to overwrite arbitrary memory because the BSS is now correctly
  zeroed.

### Cryptography

* New tests have been added for HMAC-SHA2 and various PKCS CCM/GCM cases.
  In the process, a panic in the kernel crypto driver and a
  `cryptoadm` failure to retrieve the mechanism list were fixed.
  Crypto tests can also now be run as a non-root user.

### Installer

* It was previously not possible to configure the serial console
  configuration during installation for anything other than `ttya`; this
  has been corrected.

### Developer Features

* OmniOS userland is now built with gcc 15 by default. The previous
  gcc 14 compiler remains available, and a new `developer/gcc15` package
  has been added. A large number of packages have received minor build
  fixes for compatibility with the newer compiler.

* The kernel runtime linker is now able to load larger kernel modules.

* The `cw` compiler wrapper has gained a `--time` option to report
  compiler execution time.

* `pcre2` is now built with JIT support.

### Deprecated features

* The `grub` boot loader is deprecated and was removed in the r151048
  release. If you have not yet migrated to the new boot loader, and would like
  assistance, please
  [get in touch](https://omnios.org/about/contact).

* OpenSSL 1.0.x and 1.1.1 are deprecated and reached end-of-support at the end
  of 2019 and in September 2023 respectively. OmniOS has transitioned to
  OpenSSL 3 and still ships older versions for backwards compatibility, but
  these are maintained solely on a best-efforts basis. If possible, recompile
  software to use OpenSSL 3.

* Python 2 is now end-of-life and will not receive any further updates. The
  `python-27` package is still available for backwards compatibility but will
  be maintained only on a best-efforts basis.

* OpenSSH in OmniOS no longer provides support for GSSAPI key exchange.
  This was removed in release r151038.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| compress/7zip | 25.1 | 26.0
| compress/brotli | 1.1.0 | 1.2.0
| compress/lzip | 1.25 | 1.26
| compress/xz | 5.8.1 | 5.8.3
| data/iso-codes | 4.18.0 | 4.20.1
| database/sqlite-3 | 3.50.4 | 3.51.3
| **developer/gcc15** | _New_ | 15.2.0
| developer/gnu-binutils | 2.45 | 2.46.0
| developer/macro/gnu-m4 | 1.4.20 | 1.4.21
| developer/swig | 4.3.1 | 4.4.1
| developer/versioning/git | 2.51.2 | 2.53.0
| developer/versioning/mercurial | 7.0.2 | 7.2
| editor/vim | 9.1.1730 | 9.2.68
| file/gnu-coreutils | 9.8 | 9.10
| library/expat | 2.7.2 | 2.7.5
| library/glib2 | 2.84.4 | 2.86.4
| library/libmagic | 5.46 | 5.47
| library/libxml2 | 2.14.6 | 2.15.2
| library/libxslt | 1.1.43 | 1.1.45
| library/lzlib | 1.15 | 1.16
| library/ncurses | 6.5.20240511 | 6.6
| library/nghttp2 | 1.67.1 | 1.68.1
| library/nspr | 4.37 | 4.38.2
| library/pcre2 | 10.46 | 10.47
| library/python-3/attrs-313 | 25.3.0 | 25.4.0
| library/python-3/coverage-313 | 7.10.6 | 7.13.5
| library/python-3/crossenv-313 | 1.5.0 | 1.6.1
| library/python-3/cryptography-313 | 45.0.7 | 46.0.5
| library/python-3/idna-313 | 3.10 | 3.11
| library/python-3/jsonrpclib-313 | 0.4.3.4 | 1.0.0
| library/python-3/meson-313 | 1.9.0 | 1.10.2
| library/python-3/orjson-313 | 3.11.3 | 3.11.7
| library/python-3/packaging-313 | 25.0 | 26.0
| library/python-3/pip-313 | 25.2 | 26.0.1
| library/python-3/pycparser-313 | 2.22 | 3.0
| library/python-3/pycurl-313 | 7.45.6 | 7.45.7
| library/python-3/pyopenssl-313 | 25.1.0 | 26.0.0
| library/python-3/pyyaml-313 | 6.0.2 | 6.0.3
| library/python-3/setuptools-313 | 80.9.0 | 82.0.1
| library/python-3/tomli-313 | 2.2.1 | 2.4.0
| library/security/openssl | 3.5.6 | 3.6.2
| library/security/openssl-3 | 3.5.6 | 3.6.2
| library/unixodbc | 2.3.12 | 2.3.14
| library/zlib | 1.3.1 | 1.3.2
| network/dns/bind | 9.18.39 | 9.18.47
| network/openssh | 10.0.2 | 10.3.1
| network/openssh-server | 10.0.2 | 10.3.1
| network/socat | 1.8.0.3 | 1.8.1.1
| network/test/iperf | 3.19.1 | 3.20
| runtime/python-313 | 3.13.9 | 3.13.12
| shell/bash | 5.3 | 5.3.3
| shell/pipe-viewer | 1.9.34 | 1.10.5
| system/file | 5.46 | 5.47
| **system/gpio** | _New_ | 0.5.11
| **system/i2c** | _New_ | 0.5.11
| system/library/g++-runtime | 14 | 15
| system/library/gcc-runtime | 14 | 15
| system/library/gfortran-runtime | 14 | 15
| system/library/gobjc-runtime | 14 | 15
| system/library/mozilla-nss | 3.116 | 3.122
| system/library/pcap | 1.10.5 | 1.10.6
| system/management/snmp/net-snmp | 5.9.4 | 5.9.5.2
| system/rsyslog | 8.2508.0 | 8.2602.0
| **system/test/i2ctest** | _New_ | 0.5.11
| system/virtualization/open-vm-tools | 13.0.0 | 13.0.10
| system/watch | 4.0.5 | 4.0.6
| terminal/tmux | 3.5 | 3.6
| text/groff | 1.23.0 | 1.24.1
| text/less | 679 | 692
| text/words | 20200724 | 20260225
| web/wget2 | 2.2.0 | 2.2.1
