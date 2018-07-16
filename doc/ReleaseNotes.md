<a href="https://omniosce.org">
<img src="https://omniosce.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151026

## r151026k (2018-07-16)
Weekly release for w/c 16th of July 2018.
> This is a non-reboot update.

### Security fixes

* Mercurial updated to fix
  * [CVE-2018-13348](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-13348)
* Curl updated to 7.61.0
  * [CVE-2018-0500](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0500)
* Bind updated to 9.11.4
  * [CVE-2018-5738](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-5738)

<br>

----

## r151026i (2018-07-02)
Weekly release for w/c 2nd of July 2018.
> This update requires a reboot.

### Security fixes

* Kernel update to protect against the Lazy FPU vulnerability
  * [CVE-2018-3665](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-3665)
* Mozilla NSS updated to version 3.38
  * [CVE-2018-0495](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0495)

### Other Changes

* New `::sec` mdb command to summarise protection against CPU vulnerabilities
* Fix problem when using native grep with context arguments (-A, -B, -C)
* Linked-ipkg zones could end up with packages newer than those in the global
  zone; this is now resolved.
* Add support for recursive `pkg set-publisher` operations

<br>

----

## r151026g (2018-06-18)
Weekly release for w/c 18th of June 2018.
> This is a non-reboot update.

### Changes

* `rsync` has been updated and is now twice as fast at checksumming data.

<br>

----

## r151026e (2018-06-04)
Weekly release for w/c 4th of June 2018.
> This is a non-reboot update.

### Security fixes

* `git` upgraded to version 2.17.1:
  * [CVE-2018-11233](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-11233)
  * [CVE-2018-11235](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-11235)

### Other changes

* `pkg` updated to fix support URL.

<br>

----

## r151026c (2018-05-17)
Weekly release for w/c 17th of May 2018.
> This is a non-reboot update.

### Security fixes

* `curl` upgraded to version 7.60.0:
  * [CVE-2018-1000300](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000300)
  * [CVE-2018-1000301](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000301)

### Other changes

* `dma` updated so that it strips header lines that begin with the
  five-character sequence _"From "_. This is the default behaviour of other
  MTAs such as Sendmail. This fixes a problem with processing emails generated
  by cron or by other users of the `mail` command where message headers end
  up as part of the body.

<br>

----

## r151026 (2018-05-07)

Stable Release, 7th of May 2018

`uname -v` shows `omnios-r151026-673c59f55d`

r151026 release repository: https://pkg.omniosce.org/r151026/core

## New features since r151024

### System Features

* Kernel Page Table Isolation (KPTI) feature from Joyent. This adds protection
  against the [Meltdown](http://meltdownattack.com) Intel CPU vulnerability
  announced early in 2018. See
  [https://omniosce.org/info/kpti](https://omniosce.org/info/kpti)
  for details.

* Stack-clash mitigation for 64-bit processes; from Joyent.

* Experimental support for `bhyve` virtual machines. See
  [https://omniosce.org/info/bhyve](https://omniosce.org/info/bhyve)
  for details.

* Support for `sparse` branded zones. This is a linked-ipkg
  zone that shares most of the `/usr`, `/sbin` and `/lib` directories with
  the global zone. Sparse zones are tiny (under 4MiB of installed
  files) and perfect for isolating small services or VM instances for extra
  security or to apply more granular resource controls.

* The ISO/USB installer has received multiple updates. It is now half the
  size and around seven times faster to start up, text menus have been
  replaced with dialogues to make it easier to navigate, and it is now
  possible to select DHCP assignment of the DNS parameters. Additional
  options are available for configuring aspects of the root pool including
  whether to force a 4K block size (ashift=12), whether to use stripe, mirror
  or a RAIDZ level, and whether to use EFI or MBR labels.

* The default mail submission agent is now `Dragonfly Mail Agent (dma)` rather
  than sendmail. In a default installation, `/usr/lib/sendmail` points to
  `dma` and can deliver email messages to local users and Internet recipients.
  Dragonfly supports TLS and SMTP authentication out of the box - see
  `/etc/dma/dma.conf` and `man dma` for available options.
  There are now three mediated MTA/MSA packages in OmniOS, `dma`, `sendmail`
  and `mailwrapper`; only `dma` is installed by default. To switch between
  them, install the appropriate package and then configure the `mta` mediator
  implementation, for example:
    ```
	# pkg install service/network/smtp/sendmail

	# pkg mediator -a mta
	MEDIATOR VER. SRC. VERSION IMPL. SRC. IMPLEMENTATION
	mta      system            system     mailwrapper
	mta      system            system     sendmail
	mta      vendor            vendor     dma

	# pkg set-mediator -I sendmail mta
    ```

  Note that `dma` does not support more advanced features such as `.forward`
  files in home directories. If you need these features you should switch back
  to `sendmail` as shown above.

  Mailwrapper is still available to support use of packages from non-IPS
  repositories such as _pkgsrc_ via `/etc/mailer.conf`

* A new `service/network/ntpsec` package is available as an alternative to
  `service/network/ntp`. NTPsec is a secure, hardened and improved
  implementation of the Network Time Protocol derived from NTP Classic.
  NTPsec also runs with stack protection and ASLR out of the box on OmniOS.
  To switch just record any changes you have made to `/etc/inet/ntp.conf` and
  the service manifest properties (`svcprop -p config ntp`) and then
  `pkg uninstall service/network/ntp && pkg install service/network/ntpsec`.
  Restore any customisations and then start the network/ntp service.

* A number of system components now enable Address Space Layout Randomisation
  (ASLR) by default:
    * DHCP daemon
    * Dragonfly Mail Agent
    * NTP & NTPsec
    * OpenSSH daemon
    * pfexecd
    * rpcbind
    * Sendmail
    * SNMP daemon

* `openssh` has been upgraded to 7.6p1. This version drops support for
  SSH protocol version 1, RSA keys under 1024 bits in length and a number
  of old ciphers and MACs. Refer to
  [the release notes](https://www.openssh.com/txt/release-7.6) for more
  details.
  Several legacy SunSSH compatibility options for OpenSSH are deprecated
  and will be removed in a future release; see below for more details.

  > Note that OpenSSH is now delivered as a 64-bit application and so you
  > may need to adjust your PAM configuration if you have custom rules in
  > `/etc/pam.conf`

* `libdiskmgt` (and therefore `diskinfo`) now recognises nvme, sata and xen
  controllers.

* It is now possible to boot OmniOS from a root pool which uses RAIDZ2 or
  RAIDZ3.

* New `zfs remove` and `zpool checkpoint` features - see _Commands and options_
  below.

* Improved support for ZFS pool recovery - see
  [Pavel Zakharov's _Turbocharging ZFS Data Recovery_ article](https://www.delphix.com/blog/openzfs-pool-import-recovery)
  for more details.

* The `/etc/screenrc` file delivered by the `screen` package is now based on
  the recommended global template as delivered by the authors; you may wish
  to check that it still meets your needs. If you have previously customised
  this file then it will not be updated but the new template file will be
  installed as `/etc/screenrc.new`.

* `screen` is now linked against ncurses in order to support more terminal
  types (e.g. iterm)

* New fault management (FMA) event for an SSD that is nearing its end-of-life
  as projected by the manufacturer (SSD wearout, see
  [illumos Issue 8074](https://www.illumos.org/issues/8074))

* Many improvements in resource management within zones.

* IPv6 default address selection table updated for RFC6724.

* Improvements to page recovery under low memory conditions.

* Workarounds for some systems with known broken firmware.

* New file: `/etc/os-release`

### Commands and Command Options

* ZFS now supports the removal of a top-level vdev from a pool via
  `zfs remove`, reducing the total amount of storage in the pool without
  requiring a pool rebuild. More information ca be found in
  [illumos Issue 7614](https://www.illumos.org/issues/7614).

* ZFS now supports pool-wide state checkpoints via `zpool checkpoint`.
> A pool checkpoint can be thought of as a pool-wide snapshot and should be
> used with care as it contains every part of the pool's state, from
> properties to vdev configuration.
  Refer to the zpool man page for more details.
  [illumos Issue 9166](https://www.illumos.org/issues/9166)

* `/bin/uname -o` and `/usr/gnu/bin/uname -o` report `illumos` as the
  operating system name.

* `grep` now supports context options (-A, -B, -C)

* `date -r` to display the date associated with an epoch value, or the
  timestamp of a file.

* `netstat` now supports the `-c` option to print IPv4 networks using CIDR
  notation (x.y.z.a/NN) with the _-i_, _-r_ and _-M_ options. IPv6 networks
  default to including the mask information but, to preserve backwards
  compatibility, IPv4 ones do not without this new flag.

* The `reboot now` command, as sometimes mistyped due to its prevelance on
  other system types, no longer breaks booting due to trying to load a
  kernel called `now`; the system now always falls back to `unix` for the
  default kernel.

### LX zones

* The IP address information for an interface in an LX zone can now be
  set directly via the `allowed-address` and `defrouter` properties instead
  of by using attributes. In addition to setting the address within the
  zone, this also enables L3 protection on the interface so that it can
  no longer be changed from inside the zone. The old method of setting
  attributes is still supported but does not afford this protection.
    ```
	GZ# zonecfg -z lx info net
	net:
		address not specified
		allowed-address: 172.30.1.129/26
		defrouter: 172.30.1.254
		physical: deb0

	GZ# dladm show-linkprop deb0
	LINK         PROPERTY        PERM VALUE          DEFAULT        POSSIBLE
	deb0         protection      rw   ip-nospoof     --             
	deb0         allowed-ips     rw   172.30.1.129/32 --            --
    ```

* Any secondary file-systems mounted within /usr, /lib or /sbin are no longer
  accessible from within an LX zone through /native/.

* Report that `/proc/sys` is writable to keep _systemd_ happy.

* More complete emulation of `/proc/mounts`.

* Emulate a userspace clock of 100Hz to accommodate some broken applications.

* Support for joining multicast group.

* Many other fixes and compatibility updates from Joyent.

### Package Management

* A new `pkg apply-hot-fix` command has been added to make it easier to apply
  a hot-fix directly from a package archive. For example:
    ```
	% pfexec pkg apply-hot-fix --be-name=hotfix1234 https://downloads.omniosce.org/pkg/r151022/1234_hotfix.p5p
    ```

* It is now possible to set an image property to make recursive operations
  the default behaviour and also to specify the default concurrency for
  package operations. So if you routinely use `pkg udpate -r -C 0` then you
  can now:

    ```
	# pkg set-property default-recurse True
	# pkg set-property recursion-concurrency 0
    ```

  The new `-R` option allows temporary override for recursion, refer to the
  `pkg.1` man page for more details.

* The `pkg set-publisher -O` option is now documented and has been extended
  to support bare and relative path-names. This is now the recommended way
  to switch releases - see [upgrade notes](https://omniosce.org/upgrade)

* A number of core packages can now be removed if not required. In particular
  removing packages which require a reboot on upgrade will mean that the
  reboot is avoided if that package is updated upstream. The list can be
  viewed with `pkg contents -m entire | grep optional`. This in addition
  to the _runtime/java_ _java/jdk_ and _service/resource-pools/poold_
  packages which became optional in the last release.

* `pkgsign` has gained `--dkey` and `--dcert` options to enable use of an
  SSL client certificate when signing packages in a remote HTTPS repository.

* `pkg install` now permits package downgrades.

* `pkg history -o time,command -n 5` now works as expected.

### Hardware Support

* Support for Broadcom/Avago tri-mode adapters.

* Better support for AMD Ryzen processors.

* Support for Sound Blaster Audigy RX.

### Developer Features

* GCC version 7 is now available - `pkg install developer/gcc7` - and can be
  found in `/opt/gcc-7`.
  Details of the changes in GCC 7 can be found on
  [the gcc web site](https://gcc.gnu.org/gcc-7/changes.html).

* Perl has been upgraded to 5.26.

* MDB smart-write feature via `/z` - see
  [illumos issue 9091](https://www.illumos.org/issues/9091)

### Deprecated features

* Several legacy SunSSH compatibility options for OpenSSH are deprecated
  with this release and should be removed from SSH daemon configuration
  files. A future release of OmniOS will remove support for these options
  completely. Refer to
  [https://omniosce.org/info/sunssh](https://omniosce.org/info/sunssh)
  for more details.

* The python `m2crypto`, `typing`, `lxml` and `pyrex` modules
  have been removed as they are no longer required by core OmniOS packages.

### Package changes

| Package | Old Version | New Version |
| :------ | :---------- | :---------- |
| archiver/gnu-tar | 1.29 | 1.30
| compress/gzip | 1.8 | 1.9
| data/iso-codes | 3.76 | 3.77
| database/sqlite-3 | 3.20.1 | 3.23.1
| **developer/acpi/compiler** | _New_ | 20180313
| developer/bmake | 20170812 | 20180222
| **developer/build-essential** | _New_ | 11
| developer/build/automake | 1.15.1 | 1.16.1
| ~~developer/gcc5/libgmp-gcc5~~ | 6.1.2 | _Removed_
| ~~developer/gcc5/libmpc-gcc5~~ | 1.0.3 | _Removed_
| ~~developer/gcc5/libmpfr-gcc5~~ | 3.1.5 | _Removed_
| ~~developer/gcc6/libgmp-gcc6~~ | 6.1.2 | _Removed_
| ~~developer/gcc6/libmpc-gcc6~~ | 1.0.3 | _Removed_
| ~~developer/gcc6/libmpfr-gcc6~~ | 3.1.5 | _Removed_
| **developer/gcc7** | _New_ | 7.3.0
| developer/gnu-binutils | 2.25 | 2.30
| developer/java/jdk | 1.7.0.151.1 | 1.7.0.171.2
| **developer/nasm** | _New_ | 2.13.3
| developer/versioning/git | 2.14.2 | 2.17.0
| developer/versioning/mercurial | 4.3.3 | 4.5.3
| file/gnu-coreutils | 8.28 | 8.29
| library/c++/sigcpp | 2.99.9 | 2.99.10
| library/expat | 2.2.4 | 2.2.5
| library/glib2 | 2.54.0 | 2.56.0
| **library/libedit** | _New_ | 3.1
| library/libidn | 1.33 | 1.34
| library/libxml2 | 2.9.6 | 2.9.8
| **library/mpc** | _New_ | 1.1.0
| **library/mpfr** | _New_ | 4.0.1
| library/ncurses | 6.0.20171014 | 6.1.20180331
| library/nghttp2 | 1.26.0 | 1.31.1
| library/nspr | 4.17 | 4.19
| library/nspr/header-nspr | 4.17 | 4.19
| library/pcre | 8.41 | 8.42
| library/python-2/asn1crypto-27 | 0.23.0 | 0.24.0
| library/python-2/cffi-27 | 1.11.1 | 1.11.5
| library/python-2/cheroot-27 | 5.8.3 | 6.0.0
| library/python-2/cherrypy-27 | 11.0.0 | 14.0.1
| library/python-2/coverage-27 | 4.4.1 | 4.5.1
| library/python-2/cryptography-27 | 2.0.3 | 2.2.2
| library/python-2/enum-27 | 0.4.6 | 1.1.6
| library/python-2/ipaddress-27 | 1.0.18 | 1.0.19
| **library/python-2/jaraco.classes-27** | _New_ | 1.4.3
| ~~library/python-2/lxml-27~~ | 4.0.0 | _Removed_
| ~~library/python-2/m2crypto-27~~ | 0.27.0 | _Removed_
| **library/python-2/more-itertools-27** | _New_ | 4.1.0
| ~~library/python-2/numpy-27~~ | 1.13.3 | _Removed_
| library/python-2/ply-27 | 3.10 | 3.11
| library/python-2/pycurl-27 | 7.43.0 | 7.43.0.1
| ~~library/python-2/pylint-27~~ | 1.7.4 | _Removed_
| library/python-2/pyopenssl-27 | 17.3.0 | 17.5.0
| ~~library/python-2/pyrex-27~~ | 0.9.9 | _Removed_
| ~~library/python-2/python-extra-27~~ | 0.5.11 | _Removed_
| library/python-2/pytz-27 | 2017.2 | 2018.3
| library/python-2/setuptools-27 | 36.5.0 | 39.0.1
| library/python-2/simplejson-27 | 3.11.1 | 3.13.2
| library/python-2/tempora-27 | 1.9 | 1.11
| ~~library/python-2/typing-27~~ | 3.6.2 | _Removed_
| library/unixodbc | 2.3.4 | 2.3.6
| network/dns/bind | 9.10.7 | 9.11.3
| network/openssh | 7.5.1 | 7.6.1
| network/openssh-server | 7.5.1 | 7.6.1
| network/service/isc-dhcp | 4.3.6.1 | 4.4.1
| runtime/java | 1.7.0.151.1 | 1.7.0.171.2
| runtime/perl | 5.24.4 | 5.26.2
| runtime/perl-64 | 5.24.4 | 5.26.2
| runtime/perl/manual | 5.24.4 | 5.26.2
| security/sudo | 1.8.21.2 | 1.8.22
| **service/network/ntpsec** | _New_ | 1.1.0
| **service/network/smtp/dma** | _New_ | 0.11
| shell/bash | 4.4.12 | 4.4.19
| shell/zsh | 5.4.2 | 5.5.1
| **system/bhyve** | _New_ | 0.5.11
| **system/bhyve/firmware** | _New_ | 20180309
| **system/bhyve/tests** | _New_ | 0.5.11
| ~~system/boot/wanboot~~ | 0.5.11 | _Removed_
| ~~system/boot/wanboot/internal~~ | 0.5.11 | _Removed_
| **system/library/c-runtime** | _New_ | 0.5.11
| system/library/dbus | 1.11.20 | 1.12.6
| ~~system/library/g++-5-runtime~~ | 5.5.0 | _Removed_
| ~~system/library/g++-6-runtime~~ | 6.4.0 | _Removed_
| **system/library/g++-runtime** | _New_ | 7
| ~~system/library/gcc-5-runtime~~ | 5.5.0 | _Removed_
| ~~system/library/gcc-6-runtime~~ | 6.4.0 | _Removed_
| **system/library/gcc-runtime** | _New_ | 7
| **system/library/gfortran-runtime** | _New_ | 7
| system/library/libdbus | 1.11.20 | 1.12.6
| system/library/libdbus-glib | 0.108 | 0.110
| system/library/mozilla-nss | 3.33 | 3.36
| system/library/mozilla-nss/header-nss | 3.33 | 3.36
| system/pciutils | 3.5.5 | 3.5.6
| system/pciutils/pci.ids | 2.2.20170423 | 2.2.20180208
| **system/test/cryptotest** | _New_ | 0.5.11
| system/test/fio | 3.1 | 3.5
| system/virtualization/open-vm-tools | 10.1.15 | 10.2.5
| **system/zones/brand/sparse** | _New_ | 0.5.11
| terminal/screen | 4.6.1 | 4.6.2
| text/gawk | 4.1.4 | 4.2.1
| text/gnu-patch | 2.7.5 | 2.7.6
| text/gnu-sed | 4.4 | 4.5
| text/less | 487 | 530
| web/wget | 1.19.2 | 1.19.4

