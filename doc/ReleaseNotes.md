<a href="https://omniosce.org">
<img src="https://omniosce.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151022

## r151022dt (2019-09-30)
Weekly release for w/c 30th of September 2019.
> This is a non-reboot update

# Security Fixes

# Other Changes

<br>

---

## r151022ds (2019-09-23)
Weekly release for w/c 23rd of September 2019.
> This is a non-reboot update

# Security Fixes

* `expat` updated to 2.2.8, fixing
  [CVE-2019-15903](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15903),

<br>

---

## r151022dq (2019-09-12)
Weekly release for w/c 9th of September 2019.
> This is a non-reboot update

# Security Fixes

* `openssl` updated to 1.0.2t, fixing
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

## r151022dj (2019-07-22)
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

## r151022dh (2019-07-08)

# Security Fixes

* bzip2 upgraded to 1.0.7, fixing
  [CVE-2019-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12900)
  and several other bugs.

<br>

---

## r151022df (2019-06-24)
Weekly release for w/c 24th of June 2019.
> This is a non-reboot update.

# Security Fixes

* Update to `expat` to fix denial-of-service bug.

<br>

---

## r151022dd (2019-06-11)
Weekly release for w/c 10th of June 2019.
> This is a non-reboot update.

# Security Fixes

* Curl upgraded to 7.65.1
  * [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435): Integer overflows in curl_url_set
  * [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436): tftp: use the current blksize for recvfrom()

* Vim patched against [CVE-2019-12735](https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md)

<br>

---

## r151022dc (2019-06-03)
Weekly release for w/c 3rd of June 2019.
> This is a non-reboot update.

# Security Fixes

* OpenSSL update to 1.0.2s, fixing
  * [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559)

<br>

---

## r151022da (2019-05-22)
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

## r151022cx (2019-04-29)
Weekly release for w/c 29th of April 2019.
> This is a non-reboot update.

# Security fixes

* Update to `pkg`, fixing
  [CVE-2019-2704](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-2704)
*  `wget` updated to 1.20.3, fixing
  [CVE-2019-5953](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5953)

<br>

---

## r151022ct (2019-04-01)
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

## r151022cr (2019-03-19)
Weekly release for w/c 18th of March 2019.
> This is a non-reboot update.

# Security fixes

* The `network/ntp` package has been updated to version 4.2.8p13 addressing
  [one security vulnerability](http://support.ntp.org/bin/view/Main/SecurityNotice#Recent_Vulnerabilities).

<br>

---

## r151022cp (2019-03-06)
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

## r151022co (2019-02-27)
Weekly release for w/c 25th of February 2019.
> This is a non-reboot update

# Security fixes

* `openssl` updated to 1.0.2r fixing
  [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559)

<br>

---

## r151022cm (2019-02-11)
Weekly release for w/c 11th of February 2019.
> This is a non-reboot update

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

## r151022cj (2019-01-21)
Weekly release for w/c 21st of January 2019.
> This is a non-reboot update

### Security fixes

* `openssh` updated to fix
  [CVE-2018-20685](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20685),
  [CVE-2019-6109](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6109),
  [CVE-2019-6110](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6110),
  [CVE-2019-6111](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6111)

<br>

---

## r151022ch (2019-01-07)
Weekly release for w/c 7th of January 2019.
> This is a non-reboot update

### Security fixes

* Update GNU tar to 1.31, fixing
  [CVE-2018-20482](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20482)
* libxml2 updated to fix -
  [CVE-2018-9251](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-9251),
  [CVE-2018-14404](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14404),
  [CVE-2018-14567](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14567)

<br>

----

## r151022cd (2018-12-10)
Weekly release for w/c 10th of December 2018.
> This is a non-reboot update.

### Security fixes

* `nss` updated to fix -
  [CVE-2018-12404](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12404)

### Other Changes

* `web/ca-bundle` updated

<br>

----

## r151022cc (2018-12-03)
Weekly release for w/c 3rd of December 2018.
> This is a non-reboot update.

### Security fixes

* `perl` security updates -
  [CVE-2018-12015](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-12015)
  [CVE-2018-18311](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-18311)
  [CVE-2018-18312](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-18312)
  [CVE-2018-18313](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-18313)
  [CVE-2018-18314](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-18314)

* `nss/nspr` updated to 3.40.1/4.20 -
  [CVE-2018-12404](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12404)

<br>

----

## r151022ca (2018-11-22)
Weekly release for w/c 19th of November 2018.
> This is a non-reboot update.

### Security fixes

* openssl updated to 1.0.2q
  [CVE-2018-0734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0734)
  [CVE-2018-5407](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-5407)
* openjdk updated to 1.7.0_201-b00

### Other Changes

* `screen` updated to use the ncurses library providing access to definitions
  for more terminal types.

<br>

----

## r151022by (2018-11-05)
Weekly release for w/c 5th of November 2018.
> This is a non-reboot update.

### Security fixes

* Curl updated to 7.62.0
  [CVE-2018-16842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-16842)

<br>

----

## r151022bu (2018-10-08)
Weekly release for w/c 8th of October 2018.
> This is a non-reboot update.

### Security fixes

* Git updated to 2.14.5
  [CVE-2018-17456](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17456)

* Mercurial updated to fix a potential out-of-bounds read in manifest parsing C code.

* Mozilla NSS updated to version 3.38
  [CVE-2018-0495](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0495)

<br>

----

## r151022bt (2018-10-01)
Weekly release for w/c 1st of October 2018.
> This update requires a reboot

### Security fixes

* Mitigation for Foreshadow/L1TF -
  [CVE-2018-3646](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-3646),
  with thanks to Joyent. This includes a CPU microcode update.

  For full protection from this problem, ensure that sensitive services,
  including KVM instances, are separated into different non-global zones.

  Protection status for this and other vulnerabilities can be viewed with
  `mdb -ke ::sec`.

### Bug fixes

* Kernel panic in RPC gss module -
  [illumos issue 3354](https://illumos.org/issues/3354)

* Kernel panic with Smartmontools 6.6 on ESXi 6.7 when trying to enable smart
  on rpool -
  [omnios-build issue 960](https://github.com/omniosorg/omnios-build/issues/960)

<br>

----

## r151022bp (2018-09-05)
Weekly release for w/c 3rd of September 2018.
> This is a non-reboot update.

### Security fixes

* Curl updated to 7.61.1
  [CVE-2018-14618](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-14618)

* Zsh updated to fix 
  [CVE-2018-0502](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0502)
  and
  [CVE-2018-13259](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-13259)

### Other changes

* system/cpuid updated to introduce detection of features listed in the
  May 2018 Intel ISA extensions manual.

<br>

----

## r151022bn (2018-08-20)
Weekly release for w/c 20th of August 2018.
> This is a non-reboot update.

### Security fixes

* OpenSSH updated to patch user-enumeration flaw
  [CVE-2018-15473](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-15473)

<br>

----

## r151022bm (2018-08-15)
Weekly release for w/c 13th of August 2018.
> This update requires a reboot.

### Security fixes

* OpenSSL updated to 1.0.2p
  [CVE-2018-0732](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0732)
  [CVE-2018-0737](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0737)

* NTP Daemon updated to 4.2.8p12
  [Network Time Foundation Security Notice](http://support.ntp.org/bin/view/Main/SecurityNotice)

### Bug Fixes

* [SmartOS Issue OS-7064](https://smartos.org/bugview/OS-7064)
  Fix KPTI-related kernel panic.
* [SmartOS Issue OS-7090](https://smartos.org/bugview/OS-7090)
  Fix for virtual machine memory management.

<br>

----

## r151022bk (2018-07-30)
Weekly release for w/c 30th of July 2018.
> This update requires a reboot.

### Security fixes

* Kernel Page Table Isolation (KPTI) feature from Joyent. This adds protection
  against the [Meltdown](http://meltdownattack.com) Intel CPU vulnerability
  announced early in 2018. See
  [https://omniosce.org/info/kpti](https://omniosce.org/info/kpti)
  for details.
* Kernel update to protect against the Lazy FPU vulnerability
  * [CVE-2018-3665](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-3665)

### Bug Fixes

* Newer versions of the iproute2 utilities fail in an lx zone
  with `('DONE truncated', 'Dump terminated')`
* [illumos Issue 8806](https://www.illumos.org/issues/8806)
  xattr_dir_inactive() releases used vnode with kernel panic
* [illumos Issue 9317](https://www.illumos.org/issues/9317)
  FMD crashes with zero-length allocation

### Other Changes

* New `::sec` mdb command to summarise protection against CPU vulnerabilities

<br>

----

## r151022bi (2018-07-16)
Weekly release for w/c 16th of July 2018.
> This is a non-reboot update.

### Security fixes

* Mercurial updated to fix
  [CVE-2018-13348](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-13348)
* Curl updated to 7.61.0
  * [CVE-2018-0500](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0500)
* Bind updated to 9.10.8
  * [CVE-2018-5738](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-5738)

<br>

----

## r151022bc (2018-06-04)
Weekly release for w/c 4th of June 2018.
> This is a non-reboot update.

### Security fixes

* `git` upgraded to version 2.13.7:
  * [CVE-2018-11233](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-11233)
  * [CVE-2018-11235](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-11235)

<br>

----

## r151022ba (2018-05-17)
Weekly release for w/c 17th of May 2018.
> This is a non-reboot update.

### Security fixes

* `curl` upgraded to version 7.60.0:
  * [CVE-2018-1000300](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000300)
  * [CVE-2018-1000301](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000301)

<br>

----

## r151022ay (2018-05-07)
Weekly release for w/c 7th of May 2018.
> This is a non-reboot update.

### Security fixes

* `p7zip` updated to fix:
  * [CVE-2018-5996](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-5996)
  * [CVE-2018-10115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-10115)
* `ncurses` updated to fix:
  * [CVE-2018-10754](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-10754)
* `wget` updated to 1.19.5 to fix:
  * [CVE-2018-0494](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-0494)

<br>

----

## r151022ax (2018-05-01)
Weekly release for w/c 30th of April 2018.
> This is a non-reboot update.

### Security fixes

* `python` upgraded to 2.7.15, fixing various security issues.

### Enhancements

* Ship `certutil` with the `system/library/mozilla-nss` package.

### Bug fixes

* Update `openssh` to work properly with SMF-based ipfilter.

<br>

----

## r151022av (2018-04-16)
Weekly release for w/c 16th of April 2018.
> This update requires a reboot.

### Security fixes

* `perl` updated to fix:
  * [CVE-2018-6797](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-6797)
  * [CVE-2018-6798](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-6798)
  * [CVE-2018-6913](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-6913)
* `zsh` updated to fix:
  * [CVE-2018-1100](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1100)
* `nghttp2` updated to fix:
  * [CVE-2018-1000168](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000168)

### Bug fixes

* Backport xnf network driver fix to avoid crash under Xen 4.x.
  * [illumos issue 7186](https://www.illumos.org/issues/7186)

<br>

----

## r151022at (2018-04-03)
Weekly release for w/c 2nd of April 2018.
> This is a non-reboot update.

### Security fixes

* `unzip` updated to fix:
  * [CVE-2018-1000035](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000035)

<br>

----

## r151022as (2018-03-28)
Weekly release for w/c 26th of March 2018.
> This is a non-reboot update.

### Security fixes

* `openssl` updated to 1.0.2o
  * [CVE-2018-0739](https://www.openssl.org/news/vulnerabilities.html#2018-0739)

<br>

----

## r151022ar (2018-03-19)
Weekly release for w/c 19th of March 2018.
> This is a non-reboot update.

### Security fixes

* `curl` updated to 7.59.0
  * [CVE-2018-1000120](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000120)
  * [CVE-2018-1000121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000121)
  * [CVE-2018-1000122](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-1000122)
* `bind` updated to 9.10.7
  * [CVE-2017-3140](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3140)
  * [CVE-2017-3141](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3141)
  * [CVE-2017-3142](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3142)
  * [CVE-2017-3143](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3143)
  * [CVE-2017-3145](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3145)

<br>

----

## r151022ap (2018-03-05)
Weekly release for w/c 5th of March 2018.
> This is a non-reboot update.

### Security fixes

* `DHCP` updated to 4.3.6-P1
  * [CVE-2018-5732](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-5732)
  * [CVE-2018-5733](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-5733)
* `NTP` updated to 4.2.8p11
  * [CVE-2016-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2016-1549)
  * [CVE-2018-7182](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-7182)
  * [CVE-2018-7170](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-7170)
  * [CVE-2018-7184](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-7184)
  * [CVE-2018-7185](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-7185)
  * [CVE-2018-7183](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-7183)

<br>

----

[Instructions for updating from OmniTI OmniOS r151022 are available on our web site](https://omniosce.org/upgrade)

## r151022ao (2018-02-26)
Weekly release for w/c 26th of Februrary 2018.
> This update requires a reboot.

### Security fixes

* `GNU patch` updated to fix
  * [CVE-2018-6951](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2018-6951)

### Bug fixes

* Fix for time-of-day clock error
  [illumos issue 8680](https://www.illumos.org/issues/8680)
* Fix for broken ZFS ACL inheritance
  [illumos issue 8984](https://www.illumos.org/issues/8984)

> If you use ZFS ACLs (i.e. more than just the standard permissions set with
> `chmod`) and use ACL inheritance, then it is possible that this bug will
> have resulted in files with overly permissive permissions. To check a
> data-store for this problem, you can use a script similar to that at
> https://downloads.omniosce.org/misc/8984-acl-check
> If you need any help with this, please get in touch via
> [the lobby](https://gitter.im/omniosorg/Lobby) or 
> [#omnios on Freenode](http://webchat.freenode.net?randomnick=1&channels=%23omnios&uio=d4)

### Enhancements

* New package command to easily install a hotfix from a local package
  archive or remote web site, for example:
```
% pfexec pkg apply-hot-fix --be-name=hotfix1234 \
    https://downloads.omniosce.org/pkg/r151022/1234_hotfix.p5p
```

<br>

----

## r151022al (2018-02-06)
Weekly release for w/c 5th of Februrary 2018.
> This is a non-reboot update.

### Security fixes

* `p7zip` updated to fix
  * [CVE-2017-17969](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-17969)

<br>

----

## r151022ak (2018-01-29)
Weekly release for w/c 29th of January 2018.
> This is a non-reboot update

### Changes

* Update `rsync` to 3.13
* Update timezone data to 2018c release
* Update certificate authority database to NSS 3.5

<br>

----

## r151022aj (2018-01-24)

Weekly release for w/c 22nd of January 2018.
> This is a non-reboot update.

### Security fixes

* `bind` updated to 9.10.6-P1:
  * [CVE-2017-3145](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3145)
* `curl` updated to 7.58.0
  * [CVE-2018-1000005](https://curl.haxx.se/docs/adv_2018-824a.html)
  * [CVE-2018-1000007](https://curl.haxx.se/docs/adv_2018-b3bf.html)

### Other Changes

* **Update `system/cpuid` package.** Amongst other improvements, this new
  version can report on support for the new speculation control and branch
  predictor instructions added via microcode updates.
  ```
        # cpuid | egrep 'IBRS|STI'
          Speculation Control (IBRS and IBPB)
          Single Thread Indirect Branch Predictors (STIBP)
  ```

* **Fix extended attribute related kernel panic.**
  This change has not yet been published to the repository as it would force
  a reboot for all users and has only been reported by one user. It will be
  rolled up into the next release. If you need this fix in the meantime, it is
  [available for download](https://downloads.omniosce.org/pkg/8806-backport_r22.p5p). See [illumos issue 8806](https://www.illumos.org/issues/8806).

> [Instructions for applying the interim updates](https://github.com/omniosorg/illumos-omnios/blob/r151022/README.OmniOS)

<br>

----

## r151022ae (2017-12-18)

Weekly release for w/c 18th of December 2017.
> This is a non-reboot update.

### Changes

* Fix crash in `nscd` related to ldap maps and hardware acceleration.

<br>

----

## r151022ad (2017-12-07)

Early weekly release for w/c 11th of December 2017.
> This is a non-reboot update.

### Security fixes

* `openssl` updated to 1.0.2n:
  * [CVE-2017-3737](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3737)

* `rsync`:
  * [CVE-2017-17433](http://www.security-database.com/detail.php?alert=CVE-2017-17433)
  * [CVE-2017-17434](http://www.security-database.com/detail.php?alert=CVE-2017-17434)

<br>

----
## r151022ac (2017-12-04)

Weekly release for w/c 4th of December 2017.
> This update requires a reboot.

### Security fixes

* `vim` updated to fix:
  * [CVE-2017-17087](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-17087)

### Other changes

* [8880](https://www.illumos.org/issues/8880) Improve DTrace error checking

<br>

----

## r151022ab (2017-11-29)

Weekly release for w/c 27th of November 2017.
> This is a non-reboot update.

### Security fixes

* `curl` updated to 7.57.0
  * [CVE-2017-8816](https://curl.haxx.se/docs/adv_2017-11e7.html)
  * [CVE-2017-8817](https://curl.haxx.se/docs/adv_2017-ae72.html)
  * [CVE-2017-8818](https://curl.haxx.se/docs/adv_2017-af0a.html)

<br>

----

## r151022y (2017-11-03)

Early weekly release for w/c 6th of November 2017.
> This update requires a reboot.

### Security fixes

* `openssl` updated to 1.0.2m
  * [CVE-2017-3735](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3735)
  * [CVE-2017-3736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-3736)

### Other Changes

* [8742](https://www.illumos.org/issues/8742) Fixes for potential iSCSI-related crashes.

* [8648](https://www.illumos.org/issues/8648) Fix range locking in ZIL commit codepath.

* `library/python-2/setuptools-27` upgraded to latest version. The previous
  version can no longer automatically download build-time dependencies
  from _pypi.python.org_ as that site now enforces HTTPS which is not supported
  by the old package.

* Removal of `library/python-2/vcversioner-27` package. No longer required
  with above setuptools update.

<br>

----

## r151022x (2017-10-30)

Weekly release for w/c 30th of October 2017.
> This is a non-reboot update.

### Security fixes

* `wget` updated to 1.19.2
  * [CVE-2017-13089](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-13089)
  * [CVE-2017-13090](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-13090)

### Other Changes

* Mozilla `nss/nspr` updated to 3.33/4.17
* Fix crash in `nscd` when ldap maps are used and the connection to the LDAP
  server is protected with AES encryption.
* Add `library/python-2/vcversioner-27` package which is now required to
  build OmniOS r151022.

<br>

----
## r151022w (2017-10-23)

Weekly release for w/c 23rd of October 2017.
> This is a non-reboot update.

### Security fixes

* `curl` updated to 7.56.1
  * [CVE-2017-1000257](https://curl.haxx.se/docs/adv_20171023.html)

<br>

----

## r151022u (2017-10-09)

Weekly release for w/c 9th of October 2017.
> This is a non-reboot update.

### Security fixes

* `curl` updated to 7.56.0
  * [CVE-2017-1000254](https://www.cvedetails.com/cve/CVE-2017-1000254/)
* `OpenSSH` - sftp-server users with read-only access could create
  zero-length files.
  * [CVE-2017-15906](https://www.cvedetails.com/cve/CVE-2017-15906/)
* `sudo` update to 1.8.21p2
  * [CVE-2017-1000368](https://nvd.nist.gov/vuln/detail/CVE-2017-1000368)

### Other changes

* `SUNWcs` partially updated to deliver new `/etc/motd` file matching
  the kernel version. This update was published to the repository last
  week.

<br>

----

## r151022s (2017-09-21)

Early weekly release for w/c 25th of September 2017,
uname -a shows `omnios-r151022-eb9d5cb557`
> This update requires a reboot.

### Security fixes

* Security updates for in-kernel CIFS client & server
  * [8662](https://www.illumos.org/issues/8662) SMB server ioctls should be appropriately sized
  * [8663](https://www.illumos.org/issues/8663) SMB client assumes serialized ioctls
* Perl fixes:
  * [CVE-2017-12837](https://www.cvedetails.com/cve/CVE-2017-12837/)
  * [CVE-2017-12883](https://www.cvedetails.com/cve/CVE-2017-12883/)

### Other changes

* [8651](https://www.illumos.org/issues/8651) loader: fix problem where
  `No rootfs module provided, aborting` could appear on some systems.
* IPsec observability improvements.

Due to the fix to the loader, new release media will be built for this
release.

<br>

----

## r151022r (2017-09-18)

Weekly release for w/c 18th of September 2017.
> This is a non-reboot update.

### Security fixes

* `libxml2` updated to version 2.9.5
* `python` updated to version 2.7.14

### Other changes

* Mozilla NSS updated to version 4.16
* Mozilla NSPR updated to version 3.32.1
* Web CA certificates updated

<br>

----

## r151022q (2017-09-11)

Weekly release for w/c 11th of September 2017.
> This is a non-reboot update.

### Security fixes

* `gnu-binutils` fix for:
  * [CVE-2017-14129](https://www.cvedetails.com/cve/CVE-2017-14129/)

<br>

----

## r151022o (2017-08-28)

Weekly release for w/c 28th of August 2017.
> This is a non-reboot update.

### Security fixes

* `libxml2` fixes for:
  * [CVE-2016-4658](https://www.cvedetails.com/cve/CVE-2016-4658/)
  * [CVE-2016-5131](https://www.cvedetails.com/cve/CVE-2016-5131/)
  * [CVE-2017-0663](https://www.cvedetails.com/cve/CVE-2017-0663/)
  * [CVE-2017-5969](https://www.cvedetails.com/cve/CVE-2017-5969/)
  * [CVE-2017-9047](https://www.cvedetails.com/cve/CVE-2017-9047/)
  * [CVE-2017-9048](https://www.cvedetails.com/cve/CVE-2017-9048/)
  * [CVE-2017-9049](https://www.cvedetails.com/cve/CVE-2017-9049/)
  * [CVE-2017-9050](https://www.cvedetails.com/cve/CVE-2017-9050/)
* `bzip2` fix for:
  * [CVE-2016-3189](https://www.cvedetails.com/cve/CVE-2016-3189/)

### Other changes

* Update `java` to OpenJDK 1.7.0\_141-b02
* Update `/etc/release` to include release version suffix

<br>

----

## r151022m (2017-08-11)

Early weekly release for w/c 14th of August 2017
> This is a non-reboot update.

### Security fixes

* `git` updated to version 2.13.5
  * CVE-2017-1000117
* `mercurial` updated to version 4.2.3
  * CVE-2017-1000116
  * CVE-2017-1000115

### Other changes

* Update `/etc/release` to include release version suffix

<br>

----

## r151022l (2017-08-07)

Weekly release for w/c 7th of August 2017.
> This release requires a reboot.

### Security fixes

### Bug fixes

* [8395](https://www.illumos.org/issues/8395) mr\_sas: sizeof on array function parameter will return size of pointer
* [8543](https://www.illumos.org/issues/8543) nss\_ldap crashes handling a group with no gidnumber attribute 

### LX zones

* OS-6238 panic in lxpr\_access

### Other changes

* Update `archiver/gnu-tar` manifest to include runtime dependencies
* Update `/etc/release` to include release version suffix

<br>

----  

## r151022k (2017-07-31)

Weekly release for w/c 31st of July 2017.
> This is a non-reboot update.

### Security fixes

* `ncurses` updated to fix:
  * [CVE-2017-10684](https://www.cvedetails.com/cve/CVE-2017-10684/)
  * [CVE-2017-10685](https://www.cvedetails.com/cve/CVE-2017-10685/)
  * [CVE-2017-11112](https://www.cvedetails.com/cve/CVE-2017-11112/)
  * [CVE-2017-11113](https://www.cvedetails.com/cve/CVE-2017-11113/)
* `bind` updated to version 9.10.6

### Other changes

* Update `/etc/release` to include release version suffix and OmniOSce copyright
* Update `/etc/notices/LICENSE` and `/etc/notices/COPYRIGHT` to include OmniOSce copyright

<br>

----  

## r151022i (2017-07-17)

Weekly release for w/c 17th of July 2017,
uname -a shows `omnios-r151022-5e982daae6`.
> This release requires a reboot.

### Security fixes

* expat updated to version 2.2.2 ([release notes](https://github.com/libexpat/libexpat/blob/R_2_2_2/expat/Changes))

### Bug fixes

* [3167](https://www.illumos.org/issues/3167) kernel panic in apix:apic_timer_init
* [7600](https://www.illumos.org/issues/7600) zfs rollback should pass target snapshot to kernel
* [8055](https://www.illumos.org/issues/8055) mr_sas online-controller-reset (OCR) does not work with some gen3 adapters
* [8303](https://www.illumos.org/issues/8303) loader: biosdisk interface should be able to cope with 4k sectors
* [8377](https://www.illumos.org/issues/8377) Panic in bookmark deletion (ZFS)
* [8378](https://www.illumos.org/issues/8378) crash due to bp in-memory modification of nopwrite block(ZFS)
* [8429](https://www.illumos.org/issues/8429) getallifaddrs dereferences invalid pointer causing SIGSEGV

#### LX zones

* OS-569 svcs -Z should not emit an error message for zones without SMF
* OS-601 svcs -Z in GZ should skip zones in ready state
* OS-1634 svcs -ZL does not work when a pattern is specified
* OS-5028 mount -t nfs4 not working
* OS-6222 lxbrand lseek32 mishandles negative offsets

### Other changes

* Updated loader screen for community edition
* Updated `package/pkg` to display link for OmniOSce release notes
* Added `developer/omnios-build-tools` meta-package

<br>

----  

## r151022h (2017-07-12)

Weekly release for w/c 10th of July 2017,
uname -a shows `omnios-r151022-f9693432c2`.
This is the initial OmniOSce release.

### Security fixes

* expat updated to version 2.2.1 ([CVE-2017-9233](https://libexpat.github.io/doc/cve-2017-9233/))
* curl updated to version 7.54.1 ([CVE-2017-9502](https://curl.haxx.se/docs/adv_20170614.html))
* bind updated to version 9.10.5-P3 ([CVE-2017-3140](https://kb.isc.org/article/AA-01495/0/CVE-2017-3140%3A-An-error-processing-RPZ-rules-can-cause-named-to-loop-endlessly-after-handling-a-query.html))
* p7zip updated ([CVE-2016-9296](https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2016-9296))

### Other updates

* openssl updated to version 1.0.2l
* web/ca-bundle updated to include OmniOSce Certificate Authority certificate

