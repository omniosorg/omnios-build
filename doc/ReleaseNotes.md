<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOS v11 r151048

## $`\color{red}{\textit{These are DRAFT release notes}}`$

Stable Release, TBC of Nov 2023

`uname -a` shows `omnios-r151048-XXX`

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

