<a href="https://omniosce.org">
<img src="https://omniosce.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151030 (LTS)

## r151030u (2019-09-23)
Weekly release for w/c 23rd of September 2019.
> This is a non-reboot update

# Security Fixes

# Other Changes

<br>

---

## r151030s (2019-09-12)
Weekly release for w/c 9th of September 2019.
> This is a non-reboot update

# Security Fixes

* `openssl` updated to 1.1.1d/1.0.2t, fixing
  [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547),
  [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549),
  [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563)

* `curl` updated to 7.66.0, fixing
  [CVE-2019-5481](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5481),
  [CVE-2019-5482](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5482)

* `ca-bundle` updated, removing four expired root certificates.

* Terminal information is now provided for the `rxvt-unicode` terminal type.
  This is via the new `system/data/urxvt-terminfo` package which will be
  automatically installed when upgrading to this release.

# Other Changes

* `pkg` updated to fix some boundary check issues when updating sparse zones.

* Updated Mozilla NSS/NSPR to version 3.46/4.22

<br>

---

## r151030q (2019-08-27)
Weekly release for w/c 26th of August 2019.
> This is a non-reboot update

# Changes

* Updated `shell/bash` package to version 5.0.9

<br>

---

## r151030m (2019-07-29)
Weekly release for w/c 29th of July 2019.
> This is a non-reboot update

# Changes

* Updated `gnu-coreutils` package to fix bugs in the GNU `ln` command.

<br>

---

## r151030l (2019-07-22)
Weekly release for w/c 22nd of July 2019.
> This is a non-reboot update

# Security Fixes

* nss upgraded to 3.45, fixing
  [CVE-2019-11719](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11719),
  [CVE-2019-11729](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11729),
  [CVE-2019-11727](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11727)
  and several other bugs.

# Other Changes

* The `gcc-ar` utility has been fixed for both gcc7 and gcc8.

* Updates to retpoline external thunk generation for both gcc7 and gcc8.
  See [illumos gcc issue 25](https://github.com/illumos/gcc/issues/25) for
  further details.

<br>

---

## r151030j (2019-07-08)
Weekly release for w/c 8th of July 2019.
> This is a non-reboot update

# Security Fixes

* bzip2 upgraded to 1.0.7, fixing
  [CVE-2019-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12900)
  and several other bugs.

<br>

---

## r151030h (2019-06-24)
Weekly release for w/c 24th of June 2019.
> This update requires a reboot.

# Security Fixes

* Expat upgraded to 2.2.7 to fix denial-of-service vulnerability.

# Other changes

* Performance improvements and fixes for occasional VM lockups -
  [SmartOS OS-7753](https://smartos.org/bugview/OS-7753)

* Improvements to support for running under Hyper-V, including fixes for
  running with a single virtual CPU, under lower memory conditions and on
  newer versions of the hypervisor.

* Addition of the `system/virtualization/azure-agent` package to provide the
  agent service required for running under Microsoft Azure.

* Update of the gcc-7 package to include the latest fixes from the upstream
  illumos gcc branch.

* Update to the template environment files that can be used for building
  illumos-gate - `/opt/onbld/env/`

<br>

---

## r151030f (2019-06-11)
Weekly release for w/c 10th of June 2019.
> This is a non-reboot update.

# Security Fixes

* Curl upgraded to 7.65.1
  * [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435): Integer overflows in curl_url_set
  * [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436): tftp: use the current blksize for recvfrom()

* Vim patched against [CVE-2019-12735](https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md)

# Other changes

* Some packages could not be installed under a sparse zone, reporting that
  files were being delivered outside of the target boot environment.

* Fixes for missing runtime dependencies in `developer/gcc44`

* Add new build dependency to `developer/omnios-build-tools`

<br>

---

## r151030e (2019-06-03)
Weekly release for w/c 3rd of June 2019.
> This is a non-reboot update.

# Security Fixes

* OpenSSL updates to 1.1.1c/1.0.2s, fixing
  * [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559)
  * [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543)

<br>

---

## r151030c (2019-05-22)
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

* TCP wrapper support for OpenSSH has been restored.

<br>

---

## r151030 (2019-05-06)

Stable and LTS Release, 6th of May 2019

`uname -a` shows `omnios-r151030-f1189fc02c`

r151030 release repository: https://pkg.omniosce.org/r151030/core

## Upgrade Notes

* As the _developer/library/lint_ and _developer/sunstudio12.1_ packages have
  been removed in this release, any old packages which depend on them must
  be uninstalled before upgrading. These packages can be found using:
  ```
  pkg search -l ':depend:require:*lint'
  pkg search -l ':depend:require:*studio*'
  ```

* Several legacy SunSSH compatibility options for OpenSSH were deprecated
  with release r151026 and were removed in r151028. **Please ensure that the
  old directives are removed from your configuration files prior to upgrading
  to this release.**
  Refer to <https://omniosce.org/info/sunssh> for more details.

* The format of package version numbers changed slightly in the previous
  r151028 release. For example, the terminal/screen package in r151026
  looked like this:

    _pkg://omnios/terminal/screen@4.6.2,5.11-**0.151026**:20180420T095117Z_

  and as of r151028, the ordering of the branch version has been changed

    _pkg://omnios/terminal/screen@4.6.2,5.11-**151028.0**:20181101T113741Z_

  This allows for better use of the branch version for future package updates.

## New features since r151028

### System Features

* Support for the SMB 2.1 client protocol has been added
  [illumos issue 9735](https://illumos.org/issues/9735).

* The console now has full framebuffer support with variable resolution,
  more colours and unicode fonts. This is also visible in the boot loader.

* Several 32-bit only packages have been moved to 64-bit only.

* OmniOS userland is now built with gcc version 8.

* A default installation now includes `ntpsec` in place of `ntp`; the package
  can still be removed if not required.

* A default set of system default parameters are now installed in
  `/etc/system.d/_omnios:system:defaults`. These can be overidden if necessary
  by creating additional local files under `/etc/system.d/`.

### Commands and Command Options

* The `ipadm` and `dladm` commands now show IP and link information if invoked
  without arguments.

* `dladm show-vnic` now shows the zone to which each VNIC is assigned.

* The default behaviour of recursive `chown` and `chgrp` has changed and these
  commands are now safer with respect to following symbolic links. If only
  the `-R` parameter is provided then these utilities now behave as if `-P`
  was also specified. Refer to the chown(1) and chgrp(1) manual pages for more
  information.

* The `/usr/lib/fm/fmd/fmtopo` command has improved support for enumerating
  USB topology.

### Zones

* The defaults for new zones have changed. Creating a new zone now initially
  sets `brand=lipkg` and `ip-type=exclusive`.

* Zone brand templates are available allowing zones to be created within
  zonecfg via: `create -t <type>`.

* `pkgsrc` branded zones are now available; these are sparse zones with pkgsrc
  pre-installed.

* `illumos` branded zones are now available; these run an independant illumos
  distribution under the shared OmniOS kernel. Subject to the constraints
  imposed by the shared kernel, it can be used to run a different version of
  OmniOS userland or even a different illumos distribution.

* Zone VNICs and networking information can now be dynamically managed as part
  of the zone configuration. Refer to <https://omniosce.org/setup/zones>
  for more details.

* A firewall policy can now be enforced on a non-global zone by creating
  ipf configuration files under `<zoneroot>/etc/`. Rules defined in these
  files cannot be viewed nor overridden from inside the zone. Additional
  rules can be defined within the zone. This works for all zone types apart
  from kvm zones; it is even possible to define a global firewall policy
  for a bhyve zone.

* The memory footprint of zones has been reduced by disabling unecessary
  services.

### ZFS

* Support for importing pools using a temporary name.

* Support for variable-sized dnodes.

### Package Management

* `pkg verify` has gained an option to verify individual files:
  ```
  # chown sys /var
  # pkg verify -p /var
  PACKAGE                                                            STATUS
  pkg://omnios/SUNWcs                                                 ERROR
        dir: var
                ERROR: Owner: 'sys (3)' should be 'root (0)'
  ```

* Individual origins for a publisher can be enabled and disabled using -g to
  specify the origin:
  ```
  # pkg set-publisher -g https://pkg.omniosce.org/bloody/fred/ --disable omnios
  # pkg publisher
  PUBLISHER    TYPE     STATUS   P LOCATION
  omnios       origin   online   F https://pkg.omniosce.org/bloody/core/
  omnios       origin   disabled F https://pkg.omniosce.org/bloody/fred/
  ```

* Package manifests now include SHA-2 hashes for objects, and extended hash
  information for binary objects, alongside the existing SHA-1 information
  for backwards compatibility with older `pkg` versions.

* Automatic boot-environment names can now be based on the current date and
  time as well as the publication date of the update. Refer to the pkg(5)
  man page for more information. Example:
  ```
  # pkg set-property auto-be-name time:omnios-%Y.%m.%d
  ```

### Hardware Support

* Support for modern AMD and Intel systems.

* New para-virtualisation drivers for running OmniOS under Microsoft
  Hyper-V/Azure (beta).
  These are delivered by the new `driver/hyperv/pv` package.
  > NB: At present, only Gen1 machines are supported and at least two
  > vCPUs must be configured. These limitations will be addressed in a future
  > release.

* New `bnx` (Broadcom NetXtreme) network driver.

* Improved support for USB 3.1.

### Installer

* ZFS streams used for installation are now compressed using `xz` format.
  This has resulted in a decrease in the size of all media. Kayak now
  supports installing from ZFS streams compressed with any of _gzip_, _bzip2_
  or _xz_.

* The first boot of a newly installed system is now quicker due to
  the service management framework being pre-seeded.

### Developer Features

* Python version 3 is now the default python version and most packages have
  been updated so that they use Python 3; a noteable exception is the
  `mercurial` package which does not yet support Python 3.
  Most python 2.7 modules have been removed.
  Python bindings for libxml2 and libxslt have been removed.

* OpenJDK has been upgraded to 1.8.

* A new native name demangling library is available
  [illumos issue 6375](https://illumos.org/issues/6375).

* The `mdb` _::dcmds_ and _::walkers_ commands now take an optional filter
  argument to limit the returned results.

* `mdb` has been extended with the ability to trace processes inside bhyve
  virtual machines.

* Rather than editing `/etc/system`, settings can be applied in fragment
  files under `/etc/system.d/`. This allows for separation of settings
  by function, and allows them to be delivered by packages.
  Refer to the system(4) manual page for more information.

* SMF method scripts that leave no processes running but should not be
  considered to have failed may now exit with `$SMF_EXIT_NODAEMON` to
  indicate this to the system. Refer to the smf\_method(5) manual page for
  more information.

* Sun Studio is no longer required to build OmniOS and is no longer shipped.

* Lint libraries are no longer shipped.

* New public `getrandom(2)` interface.

* The linux-compatible inotify(5) driver is now a first-class citizen and
  `/usr/include/sys/inotify.h` is present. NB: Some broken software spots
  this file and uses it as a hint to use Linux-specific features.

### Deprecated features

* Python 2.7 is deprecated and reaches end-of-support at the end of 2019.
  OmniOS has mostly transitioned to Python 3. A Python 2 package is still
  available but most previously-shipped modules have been obsoleted.

* Python bindings for libxml2 and libxslt have been removed.

* Several legacy SunSSH compatibility options for OpenSSH were deprecated
  with release r151026 and were removed in r151028. Please ensure that the
  old directives are removed from your configuration files prior to upgrading
  to this release. Refer to
  <https://omniosce.org/info/sunssh> for more details.

### Package changes ([+] Added, [-] Removed, [\*] Changed)

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| archiver/gnu-tar | 1.31 | 1.32
| compress/gzip | 1.9 | 1.10
| **consolidation/l10n/l10n-incorporation** | _New_ | 0.5.11
| data/iso-codes | 4.1 | 4.2
| database/sqlite-3 | 3.25.2 | 3.28.0
| ~~developer/acpi/compiler~~ | 20180810 | _Removed_
| ~~developer/bmake~~ | 20180512 | _Removed_
| **developer/debug/ctf** | _New_ | 0.5.11
| developer/gcc7 | 7.3.0 | 7.4.0
| developer/gcc8 | 8.2.0 | 8.3.0
| developer/gnu-binutils | 2.31.1 | 2.32
| ~~developer/java/jdk~~ | 1.7.0.201.0 | _Removed_
| ~~developer/java/jdk8~~ | 1.8.0.202.20190219 | _Removed_
| **developer/java/openjdk8** | _New_ | 1.8.0.202.20190219
| ~~developer/library/lint~~ | 0.5.11 | _Removed_
| developer/nasm | 2.13.3 | 2.14.2
| developer/parser/bison | 3.1 | 3.3.2
| ~~developer/sunstudio12.1~~ | 12.1 | _Removed_
| developer/versioning/git | 2.19.2 | 2.21.0
| developer/versioning/mercurial | 4.9 | 4.9.1
| developer/versioning/sccs | 0.5.11 | 5.9
| **driver/hyperv/pv** | _New_ | 0.5.11
| **driver/inotify** | _New_ | 0.5.11
| editor/vim | 8.1.978 | 8.1.1057
| file/gnu-coreutils | 8.30 | 8.31
| library/c++/sigcpp | 2.99.11 | 2.99.12
| library/glib2 | 2.58.1 | 2.60.0
| library/mpfr | 4.0.1 | 4.0.2
| library/ncurses | 6.1.20180923 | 6.1.20190323
| library/nghttp2 | 1.33.0 | 1.37.0
| library/nspr | 4.20 | 4.21
| library/nspr/header-nspr | 4.20 | 4.21
| library/pcre | 8.42 | 8.43
| **library/pcre2** | _New_ | 10.33
| ~~library/python-2/asn1crypto-27~~ | 0.24.0 | _Removed_
| ~~library/python-2/cffi-27~~ | 1.11.5 | _Removed_
| ~~library/python-2/cheroot-27~~ | 6.5.2 | _Removed_
| ~~library/python-2/cherrypy-27~~ | 17.3.0 | _Removed_
| ~~library/python-2/contextlib2-27~~ | 0.5.5 | _Removed_
| ~~library/python-2/coverage-27~~ | 4.5.1 | _Removed_
| ~~library/python-2/cryptography-27~~ | 2.3.1 | _Removed_
| ~~library/python-2/enum-27~~ | 1.1.6 | _Removed_
| ~~library/python-2/functools32-27~~ | 3.2.3.2 | _Removed_
| ~~library/python-2/functools_lru_cache-27~~ | 1.5 | _Removed_
| ~~library/python-2/idna-27~~ | 2.7 | _Removed_
| ~~library/python-2/ipaddress-27~~ | 1.0.22 | _Removed_
| ~~library/python-2/jaraco.classes-27~~ | 1.5 | _Removed_
| ~~library/python-2/jaraco.functools-27~~ | 1.20 | _Removed_
| ~~library/python-2/jsonrpclib-27~~ | 0.1.7 | _Removed_
| ~~library/python-2/jsonschema-27~~ | 2.6.0 | _Removed_
| ~~library/python-2/mako-27~~ | 1.0.7 | _Removed_
| ~~library/python-2/more-itertools-27~~ | 4.3.0 | _Removed_
| ~~library/python-2/ply-27~~ | 3.11 | _Removed_
| ~~library/python-2/portend-27~~ | 2.3 | _Removed_
| ~~library/python-2/prettytable-27~~ | 0.7.2 | _Removed_
| ~~library/python-2/pybonjour-27~~ | 1.1.1 | _Removed_
| ~~library/python-2/pycparser-27~~ | 2.18 | _Removed_
| ~~library/python-2/pycurl-27~~ | 7.43.0.2 | _Removed_
| ~~library/python-2/pyopenssl-27~~ | 18.0.0 | _Removed_
| ~~library/python-2/pytz-27~~ | 2018.5 | _Removed_
| library/python-2/setuptools-27 | 40.2.0 | 40.8.0
| ~~library/python-2/simplejson-27~~ | 3.16.0 | _Removed_
| ~~library/python-2/six-27~~ | 1.11.0 | _Removed_
| ~~library/python-2/tempora-27~~ | 1.13 | _Removed_
| ~~library/python-2/zc.lockfile-27~~ | 1.3.0 | _Removed_
| **library/python-3/attrs-35** | _New_ | 19.1.0
| library/python-3/cffi-35 | 1.11.5 | 1.12.2
| library/python-3/cheroot-35 | 6.5.2 | 6.5.4
| library/python-3/cherrypy-35 | 18.0.1 | 18.1.1
| library/python-3/coverage-35 | 4.5.1 | 4.5.3
| library/python-3/cryptography-35 | 2.3.1 | 2.6.1
| library/python-3/idna-35 | 2.7 | 2.8
| library/python-3/jsonrpclib-35 | 0.3.1 | 0.4.0
| library/python-3/jsonschema-35 | 2.6.0 | 3.0.1
| library/python-3/mako-35 | 1.0.7 | 1.0.8
| **library/python-3/meson-35** | _New_ | 0.50.1
| library/python-3/more-itertools-35 | 4.3.0 | 7.0.0
| library/python-3/pycparser-35 | 2.18 | 2.19
| library/python-3/pyopenssl-35 | 18.0.0 | 19.0.0
| **library/python-3/pyrsistent-35** | _New_ | 0.14.11
| library/python-3/pytz-35 | 2018.5 | 2019.1
| library/python-3/setuptools-35 | 40.2.0 | 40.8.0
| library/python-3/six-35 | 1.11.0 | 1.12.0
| library/python-3/tempora-35 | 1.13 | 1.14
| library/python-3/zc.lockfile-35 | 1.3.0 | 1.4
| library/readline | 7.0 | 8.0
| library/security/openssl | 1.1.0.10 | 1.1.1.2
| ~~library/security/openssl/preview~~ | 1.1.1.2 | _Removed_
| network/dns/bind | 9.11.4.2 | 9.11.6
| network/openssh | 7.8.1 | 7.9.1
| network/openssh-server | 7.8.1 | 7.9.1
| ~~package/pkg-35~~ | 0.5.11 | _Removed_
| ~~runtime/java~~ | 1.7.0.201.0 | _Removed_
| **runtime/java/openjdk8** | _New_ | 1.8.0.202.20190219
| ~~runtime/java8~~ | 1.8.0.202.20190219 | _Removed_
| runtime/python-35 | 3.5.6 | 3.5.7
| security/sudo | 1.8.25.1 | 1.8.27
| shell/bash | 4.4.23 | 5.0
| shell/zsh | 5.6.2 | 5.7.1
| system/data/zoneinfo | 2018.7 | 2019.1
| **system/defaults** | _New_ | 0.5.11
| **system/hyperv/tools** | _New_ | 0.5.11
| **system/library/bhyve** | _New_ | 0.5.11
| system/library/dbus | 1.12.10 | 1.12.12
| **system/library/demangle** | _New_ | 0.5.11
| **system/library/iconv/extra** | _New_ | 0.5.11
| ~~system/library/iconv/utf-8/manual~~ | 0.5.11 | _Removed_
| system/library/libdbus | 1.12.10 | 1.12.12
| ~~system/library/liblayout~~ | 0.5.11 | _Removed_
| system/library/mozilla-nss | 3.41 | 3.43
| system/library/mozilla-nss/header-nss | 3.41 | 3.43
| **system/library/python/libbe-35** | _New_ | 0.5.11
| **system/library/python/solaris-35** | _New_ | 0.5.11
| **system/library/python/zfs-35** | _New_ | 0.5.11
| system/management/mdata-client | 20170105 | 20190228
| **system/network/lldp** | _New_ | 0.4.0
| system/pciutils/pci.ids | 2.2.20181025 | 2.2.20190312
| **system/test/elftest** | _New_ | 0.5.11
| system/test/fio | 3.10 | 3.13
| **system/test/smbclient** | _New_ | 0.5.11
| system/virtualization/open-vm-tools | 10.3.0 | 10.3.10
| **system/zones/brand/illumos** | _New_ | 0.5.11
| **system/zones/brand/pkgsrc** | _New_ | 0.5.11
| terminal/tmux | 2.7 | 2.8
| ~~text/auto_ef~~ | 0.5.11 | _Removed_
| text/gawk | 4.2.1 | 5.0.0
| text/gnu-diffutils | 3.6 | 3.7
| text/gnu-grep | 3.1 | 3.3
| text/gnu-sed | 4.5 | 4.7
| text/groff | 1.22.3 | 1.22.4
| web/curl | 7.64.0 | 7.64.1
