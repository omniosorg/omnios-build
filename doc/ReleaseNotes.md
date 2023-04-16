<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151046

## $\color{red}{\textit{These are DRAFT release notes}}$

Stable and Long-Term-Supported (LTS) Release, TBC of May 2023

`uname -a` shows `omnios-r151046-XXX`

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

