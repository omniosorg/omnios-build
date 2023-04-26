<a href="https://omnios.org">
<img src="https://omnios.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r1510XX

+## $\color{red}{\textit{These are DRAFT release notes}}$

Stable `?and Long-Term-Supported (LTS)?` Release, TBC of May/Nov 20XX

`uname -a` shows `omnios-r1510XX-XXX`

r1510XX release repository: https://pkg.omnios.org/r1510XX/core

## Upgrade Notes

Upgrades are supported from the r1510... releases
only. If upgrading from an earlier version, upgrade in stages, referring to the
table at <https://omnios.org/upgrade>.

## New features since r1510XX

### System Features

### Commands and Command Options

### Libraries and Library Functions

### Zones

### LX zones

### Bhyve

### ZFS

### Package Management

### Hardware Support

### Installer

### Virtualisation

### Developer Features

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

