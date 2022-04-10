<a href="https://omniosce.org">
<img src="https://omniosce.org/OmniOSce_logo.svg" height="128">
</a>

# Release Notes for OmniOSce v11 r151030 (LTS)

## r151030ex (2022-04-11)
Weekly release for w/c 11th of April 2022.
> This is a non-reboot update

### Security Fixes

* `zlib` updated to version 1.2.12, fixing
  [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032).

<br>

---

## r151030ew (2022-04-08)
Weekly release for w/c 4th of April 2022.
> This is a non-reboot update

### Security Fixes

* `gzip` updated to version 1.12

<br>

---

## r151030et (2022-03-17)
Weekly release for w/c 14th of March 2022.
> This is a non-reboot update

### Security Fixes

* `openssl` packages have been updated/patched, fixing
  [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778).

* `python-27` has been patched, fixing
  [CVE-2021-3733](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3733),
  [CVE-2022-0391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0391).

### Other Changes

* `expat` has been updated to 2.4.7.

<br>

---

## r151030eq (2022-02-21)
Weekly release for w/c 21st of February 2022.
> This update requires a reboot

### Security Fixes

* The Intel CPU microcode has been updated to version 20220207. Depending on
  the processor, this includes fixes for
  [CVE-2021-0146](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-0146),
  [CVE-2021-0127](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-0127).

* The `expat` library package has been updated, fixing
  [CVE-2022-23852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23852),
  [CVE-2022-23990](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23990),
  [CVE-2022-25235](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25235),
  [CVE-2022-25236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25236),
  [CVE-2022-25313](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25313),
  [CVE-2022-25314](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25314),
  [CVE-2022-25315](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-25315).

* The `libxml2` library package has been updated, fixing
  [CVE-2022-23308](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23308).

* It was possible for an unprivileged user to replace the contents of a
  setuid/setgid file without clearing the special attributes, if they had
  write access to the file and were able to induce a kernel panic.

### Bug Fixes

* The `zpool online -e` command could cause the ZFS pool to become unavailable
  until the system is rebooted when the disk partition table needed to be
  modified.

* The UDP packet send path was acquiring a mutex unecessarily.

<br>

---

## r151030el (2022-01-18)
Weekly release for w/c 17th of January 2022.
> This update requires a reboot

### Security Fixes

* `tmpfs` could be induced to deadlock -
  [CVE-2021-43395](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-43395).

* `expat` updated to version 2.4.3, fixing
  [CVE-2021-45960](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45960),
  [CVE-2021-46143](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-46143),
  [CVE-2022-22822](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22822),
  [CVE-2022-22823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22823),
  [CVE-2022-22824](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22824),
  [CVE-2022-22825](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22825),
  [CVE-2022-22826](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22826)
  and
  [CVE-2022-22827](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22827).

<br>

---

## r151030eg (2021-12-17)
Weekly release for w/c 13th of December 2021.
> This update requires a reboot if you have the lx zone brand installed

### Changes

* glib2 updated to fix
  [CVE-2021-3800](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3800).

* Strengthened LX-exclusive filesystems against races

* Openssl has been updated to version 1.1.1m

<br>

---

## r151030ec (2021-11-17)
Weekly release for w/c 15th of November 2021.
> This is a non-reboot update

### Changes

* `pkg` has been updated to fix a bug in the `pkgfmt` command which could
  cause it to fail when converting manifests to _v2_ format.

<br>

---

## r151030dz (2021-10-29)
Weekly release for w/c 25th of October 2021.
> This is a non-reboot update

### Changes

* `ca-bundle` has been updated (`nss` 3.70).

<br>

---

## r151036dy (2021-10-21)
Weekly release for w/c 18th of October 2021.
> This is a non-reboot update

### Security Fixes

* `openjdk` has been updated to 1.8.312-07 fixing several CVEs.

<br>

---

## r151030dv (2021-09-28)
Weekly release for w/c 27th of September 2021.
> This update requires a reboot

### Security Fixes

* OpenSSH has been updated, fixing
  [CVE-2021-41617](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-41617).

### Bug fixes

* Performance of the system console has been significantly improved.

* Attempting to multiplex non-device streams could result in a kernel panic.

<br>

---

## r151030du (2021-09-23)
Weekly release for w/c 20th of September 2021.
> This is a non-reboot update

### Changes

* `curl` has been updated to version 7.79.1.

<br>

---

## r151030dt (2021-09-15)
Weekly release for w/c 13th of September 2021.
> This is a non-reboot update

### Security Fixes

* `curl` has been updated to version 7.79.0 fixing 3 security vulnerabilities:
  * [CVE-2021-22945](https://curl.se/docs/CVE-2021-22945.html)
  * [CVE-2021-22946](https://curl.se/docs/CVE-2021-22946.html)
  * [CVE-2021-22947](https://curl.se/docs/CVE-2021-22947.html)

<br>

---

## r151030ds (2021-09-07)
Weekly release for w/c 06th of September 2021.
> This is a non-reboot update

### New Features

* The `__illumos__` pre-processor token is now defined by the gcc compilers.

### Bug Fixes

* p7zip would truncate passphrases read from the terminal.

<br>

---

## r151030dq (2021-08-24)
Weekly release for w/c 23rd of August 2021.
> This is a non-reboot update

### Security Fixes

* `openssl 1.1` updated to 1.1.1l, fixing
  [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711),
  [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712)

* `openssl 1.0` patched to fix
  [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712)

<br>

---

## r151030dl (2021-07-23)
Weekly release for w/c 19th of July 2021.
> This is a non-reboot update

### Security Fixes

* `curl` has been updated to version 7.78.0 fixing 5 security vulnerabilities:
  * [CVE-2021-22922](https://curl.se/docs/CVE-2021-22922.html)
  * [CVE-2021-22923](https://curl.se/docs/CVE-2021-22923.html)
  * [CVE-2021-22924](https://curl.se/docs/CVE-2021-22924.html)
  * [CVE-2021-22925](https://curl.se/docs/CVE-2021-22925.html)
  * [CVE-2021-22926](https://curl.se/docs/CVE-2021-22926.html)

* `openjdk` has been upgraded to 1.8.302-08, fixing:
  * [CVE-2021-2341](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2341)
  * [CVE-2021-2369](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2369)
  * [CVE-2021-2388](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2388)

<br>

---

## r151030dg (2021-06-14)
Weekly release for w/c 14th of June 2021.
> This is a non-reboot update

### Security Fixes

* ISC DHCP updated to 4.4.2-P1, fixing
  [CVE-2021-25217](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25217).

<br>

---

## r151030dd (2021-05-26)
Weekly release for w/c 24th of May 2021.
> This is a non-reboot update

### Security Fixes

* curl updated to 7.77.0, fixing
  [CVE-2021-22901](https://curl.se/docs/CVE-2021-22901.html),
  [CVE-2021-22898](https://curl.se/docs/CVE-2021-22898.html),
  [CVE-2021-22897](https://curl.se/docs/CVE-2021-22897.html)

<br>

---

## r151030dc (2021-05-18)
Weekly release for w/c 17th of May 2021.
> This is a non-reboot update

### Security Fixes

* libxml2 updated to 2.9.12, fixing
  [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541).

<br>

---

## r151030cy (2021-04-22)
Weekly release for w/c 19th of April 2021.
> This is a non-reboot update

### Security Fixes

* `openjdk` updated, fixing
  [CVE-2021-2161](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2161),
  [CVE-2021-2163](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-2163)

<br>

---

## r151030cx (2021-04-14)
Weekly release for w/c 12th of April 2021.
> This is a non-reboot update

### Changes

* `curl` updated to 7.76.1

<br>

---

## r151030cv (2021-04-01)
Weekly release for w/c 29th of March 2021.
> This is a non-reboot update

### Security Fixes

* `curl` updated to 7.76.0, fixing
  [CVE-2021-22876](https://curl.se/docs/CVE-2021-22876.html),
  [CVE-2021-22890](https://curl.se/docs/CVE-2021-22890.html)

<br>

---

## r151030cu (2021-03-25)
Weekly release for w/c 22th of March 2021.
> This is a non-reboot update

### Security Fixes

* `openssl` updated to 1.1.1k, fixing
  [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449),
  [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450)

<br>

---

## r151030cs (2021-03-10)
Weekly release for w/c 8th of March 2021.
> This is a non-reboot update

### Security Fixes

* `git` has been updated to version 2.21.4, fixing
  [CVE-2021-21300](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-21300).

<br>

---

## r151030cq (2021-02-26)
Weekly release for w/c 22nd of Februrary 2021.
> This is a non-reboot update

### Other Changes

* Fix a regression in the `python-35` package.

<br>

---

## r151030cp (2021-02-18)
Weekly release for w/c 15th of February 2021.
> This update requires a reboot

### Security Fixes

* `openssl` updated to 1.1.1j, fixing
  [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840),
  [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841).

* The legacy `openssl` 1.0.2 has also been patched to mitigate the above CVEs.

* All shipped `python` versions have been updated to address
  [CVE-2021-3177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3177).

### Other Changes

* Adding a second disk to an Azure instance caused a kernel panic.

* A memory leak in the SMB client has been addressed.

* The ZFS I/O pipeline is now able to use the pageout reserve memory pool
  in order to flush pages to disk under low memory conditions.

* The hardware database has been updated.

* Timezone data updated to 2021a.

<br>

---

## r151030co (2021-02-11)
Weekly release for w/c 8th of February 2021.
> This is a non-reboot update

### Security Fixes

* `screen` updated to fix
  [CVE-2021-3156](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3156).

<br>

---

## r151030cm (2021-01-25)
Weekly release for w/c 25th of January 2021.
> This update requires a reboot

### Security Fixes

* It was possible for an unprivileged user, including one in a zone, to cause
  the system to panic.

* `sudo` updated to 1.9.5p2, fixing
  [CVE-2021-3156](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3156).

* `socat` updated to fix a potential heap based buffer overflow.

### Other Changes

* Support for Active-Directory servers which enforce secure RPC
  (due to CVE-2020-1472).

* `gcc` has been updated so that the `-z assert-deflib` linker option works
  correctly for 64-bit objects.

* OpenJDK 8 has been updated to 1.8.282-b08

* ZFS `list -t bookmark` was not working for zvols.

* Add support for the `IA32_FEATURE_CONTROL` MSR in bhyve. This improves
  support for some guest operating systems.

* `pkg apply-hot-fix` could produce error messages during operation.

<br>

---

## r151030cf (2020-12-10)
Weekly release for w/c 07th of December 2020.
> This update requires a reboot

### Security Fixes

* `openssl` updated to 1.1.1i, fixing
  [CVE-2020-1971](https://www.openssl.org/news/secadv/20201208.txt)

* `openssl 1.0` updated to fix
  [CVE-2020-1968](https://www.openssl.org/news/secadv/20200909.txt),
  [CVE-2020-1971](https://www.openssl.org/news/secadv/20201208.txt)

* `curl` updated to 7.74.0, fixing
  [CVE-2020-8284](https://curl.se/docs/CVE-2020-8284.html),
  [CVE-2020-8285](https://curl.se/docs/CVE-2020-8285.html),
  [CVE-2020-8286](https://curl.se/docs/CVE-2020-8286.html)

### Bug Fixes

* MacOS Big Sur clients would experience read hangs when accessing OmniOS
  SMB shares.

* The `pkg apply-hot-fix` command, in conjunction with the creation of a new
  boot environment, would sometimes leave extra origins configured in
  non-global zones. This caused problems for subsequent package updates.

* Compiling with `gcc -pg` did not produce a working profiling binary.

### Other Changes

* The Intel CPU microcode update for some Core (Gen. 11) Mobile processors
  has been removed as it was reported to cause problems on some platforms.

<br>

---

## r151030cc (2020-11-17)
Weekly release for w/c 16th of November 2020.
> This update requires a reboot

### Security Fixes

* Updated Intel processor microcode from Intel, fixing several security
  vulnerabilities.

### Other Changes

* `pkg` could backtrace when displaying licence information.

<br>

---

## r151030bz (2020-10-26)
Weekly release for w/c 26th of October 2020.
> This is a non-reboot update

### Security Fixes

* OpenJDK 8 updated to 1.8.0.272, fixing
  [multiple CVEs](https://foojay.io/java-8/?quarter=102020&tab=cve&version=openjdk8u272).

<br>

---

## r151030by (2020-10-22)
Weekly release for w/c 19th of October 2020.
> This update requires a reboot

### Security Fixes

* Fix for
  [CVE-2020-27678](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27678)
  - a pre-auth remote root exploit in PAM.

### Other Changes

* Fixes for better handling of low memory situations, particularly when running
  in AWS.

<br>

---

## r151030bw (2020-10-05)
Weekly release for w/c 5th of October 2020.
> This is a non-reboot update

### Other Changes

* Enhancement to `pkg` to allow for more detailed diagnostic messages
  via `-vv` in the event that an upgrade solution can't be found.

<br>

---

## r151030bu (2020-09-22)
Weekly release for w/c 21st of September 2020.
> This is a non-reboot update

### Security Fixes

* `python3` updated to
  [3.5.10](https://docs.python.org/3.5/whatsnew/changelog.html).

### Other Changes

* `nss` updated to `3.57` and
  `nspr` updated to `4.29`
  (including an updated `ca-bundle`).
* `hwdata` updated to 2020.9.15.

<br>

---

## r151030bt (2020-09-15)
Weekly release for w/c 14th of September 2020.
> This update requires a reboot if bhyve is installed

### Security Fixes

* It was possible for a bhyve guest running under AMD SVM to execute some
  instructions against host physical memory -
  [CVE-2020-7467](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7467)

<br>

---

## r151030br (2020-09-01)
Weekly release for w/c 31st of August 2020.
> This update requires a reboot

### Security Fixes

* It was theoretically possible to escape from a zone that has permission
  to create a bhyve instance -
  [CVE-2020-24718](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24718)
  Note that in OmniOS only _bhyve_-branded zones have access to bhyve and this
  vulnerability does not enable escape from a bhyve virtual machine.

### Other Changes

* Fix for a ZFS-related panic -
  [13034 dnode_sync is careless with range tree](https://www.illumos.org/issues/13034)

* `crontab` has gained a `-u` option

* `/lib/svc/bin/smfcron` is provided to more easily create SMF services that
  add and remove cron jobs

<br>

---

## r151030bq (2020-08-24)
Weekly release for w/c 24th of August 2020.
> This is a non-reboot update

### Security Fixes

* `curl` updated fixing
  * [CVE-2020-8231](https://curl.haxx.se/docs/CVE-2020-8231.html).

<br>

---

## r151030bo (2020-08-10)
Weekly release for w/c 10th of August 2020.
> This is a non-reboot update

### Security Fixes

* OpenJDK 8 updated to 1.8.0.265, fixing multiple CVEs:
  * [CVE-2020-14556](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14556)
  * [CVE-2020-14577](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14577)
  * [CVE-2020-14578](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14578)
  * [CVE-2020-14579](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14579)
  * [CVE-2020-14581](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14581)
  * [CVE-2020-14583](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14583)
  * [CVE-2020-14593](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14593)
  * [CVE-2020-14621](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14621)

* Python 2.7 updated with fixes for:
  * [CVE-2020-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-20907)
  * [CVE-2020-8492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8492)

<br>

---

## r151030bn (2020-08-04)
Weekly release for w/c 3rd of August 2020.
> This is a non-reboot update

### Changes

* Update `pkg` to fix bugs with conditional dependency handling.

<br>

---

## r151030bm (2020-07-27)
Weekly release for w/c 27th of July 2020.
> This update requires a reboot

### Fixes

* System panic when using the `lockstat` command
* `lofiadm -la` does not always create devfs symlinks
* Fix for vioif hangs when using lso
* Fix for race in multi-threaded python applications using wrapped TLS sockets

<br>

---

## r151030bl (2020-07-20)
Weekly release for w/c 20th of July 2020.
> This is a non-reboot update

### Changes

 * Updated OpenJDK8 to 1.8.0\_262
 * Updated rsync to 3.2.2

<br>

---

## r151030bi (2020-07-01)
Weekly release for w/c 29th of June 2020.
> This is a non-reboot update

### Security Fixes

* Curl updated fixing
  [CVE-2020-8169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8169),
  [CVE-2020-9177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9177)

<br>

---

## r151030bh (2020-06-22)
Weekly release for w/c 22nd of June 2020.
> This update requires a reboot

### Security Fixes

* Intel microcode updated to 20200616.

<br>

---

## r151030bf (2020-06-08)
Weekly release for w/c 8th of June 2020.
> This is a non-reboot update

### Security Fixes

* `perl` updated to 5.28.3 fixing
  [CVE-2020-10543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10543),
  [CVE-2020-10878](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10878)
  and
  [CVE-2020-12723](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12723).

* `nghttp2` updated to 1.41.0 fixing
  [CVE-2020-11080](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11080).

### Other Changes

* `open-vm-tools` updated to 11.1.0.

<br>

---

## r151030be (2020-06-01)
Weekly release for w/c 01st of June 2020.
> This is a non-reboot update

### Changes

* Fix bug in the `pkgdepend` package dependency generator.
  (Required to consistently build gate after 12708 is integrated)

<br>

---

## r151030bb (2020-05-11)
Weekly release for w/c 11th of May 2020.
> This update requires a reboot

### Security Fixes

* Fix for a kernel panic when running an NFS client within an lx-branded zone

### Other Changes

* `w` and `whodo` produced error messages about processes in non-global zones

* `onu` to illumos-gate now works with installed zones

* `pkglint` now detects duplicated pkg attributes in legacy actions

<br>

---

## r151030az (2020-04-25)
Weekly release for w/c 27th of April 2020.
> This update requires a reboot

### Security Fixes

* `openssl` updated to 1.1.1g

* `git` update to 2.21.3 fixing
  [CVE-2020-5260](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-5260)
  and
  [CVE-2020-11008](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11008).

* [12523](https://www.illumos.org/issues/12523)
  Buffer overflow in `w` and `whodo`

### Other Changes

* `python` 2.7 updated to 2.7.18, the last python 2.7 release

* [12336](https://www.illumos.org/issues/12336)
  Boot hang caused by x2apic probe using incorrect local apic id

* [OS-8141](https://smartos.org/bugview/OS-8141)
  lx futex called with NULL timeout causes panic

* [12260](https://www.illumos.org/issues/12260)
  Fix zpool history unbounded memory usage

<br>

---

## r151030aw (2020-04-03)
Weekly release for w/c 06th of April 2020.
> This is a non-reboot update

### Changes

* `openssl` updated to 1.1.1f

<br>

---

## r151030av (2020-03-28)
Weekly release for w/c 30th of March 2020.
> This is a non-reboot update

### Changes

* `openssl` updated to 1.1.1e

* `fio` would crash on pre-haswell systems

<br>

---

## r151030ap (2020-02-17)
Weekly release for w/c 17th of February 2020.
> This update requires a reboot

### Security Fixes

* sudo updated to fix
  [CVE-2019-18634](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18634)

### Other Changes

* Fix for divide-by-zero bug in the i40e network driver
  [illumos 9601](https://www.illumos.org/issues/9601)

* Update `pkg` to better handle packages with broken metadata

<br>

---

## r151030al (2020-01-21)
Weekly release for w/c 20th of January 2020.
> This is a non-reboot update

### Changes

* It was not always possible to create a new boot environment from within a
  sparse-branded zone.

<br>

---

## r151030ah (2019-12-23)
Weekly release for w/c 23rd of December 2019.
> This is a non-reboot update

### Security Fixes

* OpenSSL 1.0 updated to 1.0.2u, fixing
  [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551)

### Other Changes

* Installation media updated to fix an installer bug which caused the system
  domain name to be truncated to 20 characters.

<br>

---

## r151030ae (2019-12-03)
Weekly release for w/c 2nd of December 2019.
> This update requires a reboot

### Security Fixes

* Update Intel CPU Microcode to 20191115.

### Other Changes

* Fixes to support for large (> 2TB) USB hard disks.

* mpt\_sas driver could hang after config header request timeout.

* OpenJDK updated to 1.8.0\_232-09.

<br>

---

## r151030ab (2019-11-13)
Weekly release for w/c 11th of November 2019.
> This update requires a reboot

### Bug fixes

* Fix ZFS bug that could prevent pool import following an unclean export
  in certain circumstances -
  [illumos 11942](https://www.illumos.org/issues/11942)

* Correct errors in timezone data

<br>

---

## r151030z (2019-10-31)
Weekly release for w/c 28th of October 2019.
> This is a non-reboot update

### Changes

* Python3 - upgrade to python 3.5.8

* Python2 - upgrade to python 2.7.17

* Migrate terminfo for urxvt terminals to `system/data/terminfo`. This
  fixes an issue with building illumos-gate following the integration of
  [illumos 11669](https://www.illumos.org/issues/11669)

* Fix for the handling of mediators under /usr within sparse zones.

<br>

---

## r151030y (2019-10-21)
Weekly release for w/c 21st of October 2019.
> This update requires a reboot

### Security Fixes

* Upgrade `sudo` package to 1.8.28p1, fixing
  [CVE-2019-14287](https://www.sudo.ws/alerts/minus_1_uid.html)

* Update Intel Microcode to 20190918

### Other Changes

* Update timezone and hardware databases

* CIFS: Windows usernames are now treated case-insensitively

* Improvements to AMD processor topology detection

* Improved compatibility with Linux getsockopt() in lx zones

* Fix for bad ARP behaviour after long uptimes -
  [illumos 11378](https://www.illumos.org/issues/11378)

* Fix (rare) kernel crash problem exposed by Go testsuite
  [illumos 11556](https://www.illumos.org/issues/11556)

<br>

---

## r151030v (2019-10-01)
Weekly release for w/c 30th of September 2019.
> This is a non-reboot update

### Changes

* Deliver updated `pkg` to fix a bug preventing variant changes.

* Deliver new template `.env` file for building illumos-gate on OmniOS
  following the integration of
  [illumos 7661](https://www.illumos.org/issues/7661)

<br>

---

## r151030u (2019-09-23)
Weekly release for w/c 23rd of September 2019.
> This is a non-reboot update

### Security Fixes

* `expat` updated to 2.2.8, fixing
  [CVE-2019-15903](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15903),

<br>

---

## r151030s (2019-09-12)
Weekly release for w/c 9th of September 2019.
> This is a non-reboot update

### Security Fixes

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

### Other Changes

* `pkg` updated to fix some boundary check issues when updating sparse zones.

* Updated Mozilla NSS/NSPR to version 3.46/4.22

<br>

---

## r151030q (2019-08-27)
Weekly release for w/c 26th of August 2019.
> This is a non-reboot update

### Changes

* Updated `shell/bash` package to version 5.0.9

<br>

---

## r151030m (2019-07-29)
Weekly release for w/c 29th of July 2019.
> This is a non-reboot update

### Changes

* Updated `gnu-coreutils` package to fix bugs in the GNU `ln` command.

<br>

---

## r151030l (2019-07-22)
Weekly release for w/c 22nd of July 2019.
> This is a non-reboot update

### Security Fixes

* nss upgraded to 3.45, fixing
  [CVE-2019-11719](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11719),
  [CVE-2019-11729](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11729),
  [CVE-2019-11727](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11727)
  and several other bugs.

### Other Changes

* The `gcc-ar` utility has been fixed for both gcc7 and gcc8.

* Updates to retpoline external thunk generation for both gcc7 and gcc8.
  See [illumos gcc issue 25](https://github.com/illumos/gcc/issues/25) for
  further details.

<br>

---

## r151030j (2019-07-08)
Weekly release for w/c 8th of July 2019.
> This is a non-reboot update

### Security Fixes

* bzip2 upgraded to 1.0.7, fixing
  [CVE-2019-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12900)
  and several other bugs.

<br>

---

## r151030h (2019-06-24)
Weekly release for w/c 24th of June 2019.
> This update requires a reboot.

### Security Fixes

* Expat upgraded to 2.2.7 to fix denial-of-service vulnerability.

### Other changes

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

### Security Fixes

* Curl upgraded to 7.65.1
  * [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435): Integer overflows in curl_url_set
  * [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436): tftp: use the current blksize for recvfrom()

* Vim patched against [CVE-2019-12735](https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md)

### Other changes

* Some packages could not be installed under a sparse zone, reporting that
  files were being delivered outside of the target boot environment.

* Fixes for missing runtime dependencies in `developer/gcc44`

* Add new build dependency to `developer/omnios-build-tools`

<br>

---

## r151030e (2019-06-03)
Weekly release for w/c 3rd of June 2019.
> This is a non-reboot update.

### Security Fixes

* OpenSSL updates to 1.1.1c/1.0.2s, fixing
  * [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559)
  * [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543)

<br>

---

## r151030c (2019-05-22)
Weekly release for w/c 20th of May 2019.
> This update requires a reboot.

### Security Fixes

* Mitigations for a series of CPU side channel vulnerabilities that affect
  Intel CPUs. These are collectively known as multi-architectural data
  sampling (MDS) vulnerabilities and cover the following CVEs:
  * [CVE-2018-12126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12126)
  * [CVE-2018-12127](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12127)
  * [CVE-2018-12130](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12130)
  * [CVE-2019-11091](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11091)

  For more information, refer to the [Intel security advisory](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html)

* Intel CPU microcode has been updated to the 20190514 release.

### Other Changes

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

### Package changes

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
